---
title:      "GPU Port of Ramses: Proof of Concept"                 # Title
author:     Robert Caddy               # Author Name
date:       2025-03-03 11:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Ramses, Hydrodynamics, GPU Port, CUDA, Fortran, CUDA Fortran, RSE]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Porting Mini-Ramses hydrodynamics to GPUs: Proof of Concept

## Summary

The primary goal of this project is to determine if the oct based Adaptive Mesh Refinement (AMR) of [Ramses](https://github.com/ramses-organisation/ramses) can be ported to GPUs performantly. Currently we're limiting it to a static mesh and single MPI rank, though the implementation should generalize to adaptive meshes and multiple MPI ranks reasonably easily. The small size of an oct (a 2x2x2 block of cells) makes coalesced reads/writes potentially challenging on GPUs. All of this work is done in the context of [Mini-Ramses](https://bitbucket.org/rteyssie/mini-ramses/src/develop/), a simplified version of Ramses that is used as a testbed for significant changes to Ramses.

All the results in this document were generated using Mini-Ramses at commit `0a9c8d4`.

## Implementation Strategy

The biggest initial challenge of porting Mini-Ramses to run on GPUs was figuring out how to allocate work to the GPU. Each oct has far too much data and work to assign to a single thread but not nearly enough to assign to an entire kernel launch; instead I took a middle ground and used CUDA blocks. This method revolves around performing the integration on "subgrids" consisting of 2x2x2 "real" octs in the center surrounded by a single layer of octs to act as the ghost/halo cells. In total this is a small uniform grid of 8x8x8 cells, 512 total cells, an appropriate size to assign to a single CUDA block. Originally I chose to use an 8x8x8 cell subgrid with 2x2x2 real octs over a 6x6x6 subgrid with a single central real oct becaus CUDA warps are 32 threads wide and having 8 cells on a side divides 32 more neatly. In the final version this is turned out to not be a concern, 6x6x6 cell subgrids should work well.

The general structure is:

### Setup

On the first time step only, create a connectivity graph for each subgrid. I.e. a small array that has the indices of each oct within each subgrid so the GPU can load the octs easily. Then copy this map to the GPU and leave it there the remainder of the simulation. In a future version of GPU accelerated Ramses this step could be redone whenever the mesh is recomputed.

### During Each Time step

1. Copy the array of octs to the GPU
2. Launch a kernel to load all the octs into the subgrid in shared memory then perform the integration to update the real cells in each oct.
3. Copy the array of octs back to the host

The integration itself is done with small grid stride loops, all the threads in a block collectively loop over all the elements that need computed. The integration is done with a second order MUSCL scheme utilizing the minmod limiter and HLL Riemann Solver. The structure of the integrator kernel is:

1. Load every cell into the subgrid from global memory, converting to primitive variables and saving to shared memory as it goes
2. Use the subgrid values in shared memory and loop over the inner 6x6x6 cells to reconstruct the interface states. Save the interface states to shared memory as well.
3. Perform the Riemann solve with the interface states in shared memory. Write the fluxes back to the left interface state shared arrays to save on the very limited shared memory
4. Update the inner real cells and write them to global memory. Currently this actually loads the conserved variables from global memory to update them. Using the primitive variables that are in shared memory and converting them to conserved variables then updating and writing to global memory is actually slightly slower.

The whole kernel is written such that it should be reasonably easy to convert to C++ in the future using either CUDA or Kokkos and the subgrid size could be easily templated in that case. The individual steps are also all in their own device functions and could easily be extracted into their own kernels if needed in the future.

My work on this project is in [PRs #14-18 and #19-22](https://bitbucket.org/rteyssie/mini-ramses/pull-requests/?state=ALL&author=%7B0e078fe3-52ab-4739-856d-2437b21e79d8%7D) with the bulk of the integrator implementation in [PR #19](https://bitbucket.org/rteyssie/mini-ramses/pull-requests/19) and [PR #22](https://bitbucket.org/rteyssie/mini-ramses/pull-requests/22).

## Correctness Test

To prove correctness of the implementation I used the Sedov Blast test since it's a complex and extreme 3D test that will likely show if there are any bugs present in the code; a "production ready" version would require additional tests to rigorously prove correctness but for a prototype this is sufficient. The Sedov Blast test initial conditions have a constant density, zero velocity, low pressure state across the entire domain except a single cell at the origin with very high pressure. It uses periodic boundary conditions and so you can see the blast wave seeming to emanate from each corner of the domain.

The results of the Sedov test at four different resolutions are shown in Figures 1-4. These figures show the results of running the test on the CPU, GPU, and the difference between them. I don't expect bitwise identical results in all cases since the implementation details differ slightly and the underlying library functions are different. Despite this many of the fields do show bitwise identical results for most or all of the domain which is excellent. The L2 errors between the CPU and GPU versions are also given in the captions and are all near the limit of double precision accuracy. These very small errors in this complex and demanding test make me quite confident that the GPU implementation of the integrator is correct.

| ![projected_results_level_5.svg](/assets/img/2025-post-assets/2025-03-03-projected_results_level_7.svg) |
|:--:|
| *Figure 1: Final state at t=1.0 for the 32^3 cell 3D Sedov test comparing the CPU results (left), GPU results (middle), and the difference between them (right). The L2 Error is $4.98\times10^{18}$* |

| ![projected_results_level_6.svg](/assets/img/2025-post-assets/2025-03-03-projected_results_level_7.svg) |
|:--:|
| *Figure 2: Final state at t=1.0 for the 64^3 cell 3D Sedov test comparing the CPU results (left), GPU results (middle), and the difference between them (right). The L2 Error is $5.68\times10^{18}$* |

| ![projected_results_level_7.svg](/assets/img/2025-post-assets/2025-03-03-projected_results_level_7.svg) |
|:--:|
| *Figure 3: Final state at t=1.0 for the 128^3 cell 3D Sedov test comparing the CPU results (left), GPU results (middle), and the difference between them (right). The L2 Error is $1.18\times10^{17}$* |

| ![projected_results_level_8.svg](/assets/img/2025-post-assets/2025-03-03-projected_results_level_8.svg) |
|:--:|
| *Figure 4: Final state at t=1.0 for the 256^3 cell 3D Sedov test comparing the CPU results (left), GPU results (middle), and the difference between them (right). The L2 Error is $8.07\times10^{14}$* |

## Performance Analysis

The most important part of this project is the performance. In this section I've pulled the CPU performance data from the `hydro - godunov` part of the timing data that Mini-Ramses prints at the end of every run and the GPU data from [NVTX](https://github.com/NVIDIA/NVTX) ranges which are then measured when profiling the code with NVIDIA Nsight Systems. This allows easy fine grain timing of specific sections and subsections of the code.

The performance results shown in Tables 1 & 2 and in Figures 5-8 show that the actual integration done in the GPU kernel is 22-38 times faster than the same integration done on the CPU. However, the copying of the grid to and from the GPU takes slightly longer than the integration which is a significant amount of overhead. This shows that oct-based AMR can be done efficiently on a GPU, the 22-38x speedup of the integration makes the performance competitive with other GPU accelerated hydrodynamics codes like AthenaK or Cholla. To realize the full speedup however the grid will need to be moved full time, or nearly full time, to the GPU.

| Simulation Size | Host to Device Copy (ms) | GPU Integration (ms) | Device to Host Copy (ms) | GPU Total (ms) | CPU Total (ms) |
|-----------------|--------------------------|----------------------|--------------------------|----------------|----------------|
| 32^3            | 0.0409                   | 0.0362               | 0.0241                   |  0.101         |   1.16         |
| 64^3            | 0.156                    | 0.156                | 0.0983                   |  0.410         |   5.94         |
| 128^3           | 0.978                    | 1.15                 | 0.694                    |  2.82          |  32.67         |
| 256^3           | 4.74                     | 8.96                 | 5.44                     | 19.1           | 197.49         |

*Table 1: Timing data for a static grid. GPU time is broken down into the individual components*

| Simulation Size | Total Speedup | Integrator Only Speedup | Fraction of Time in GPU Overhead |
|-----------------|---------------|-------------------------|----------------------------------|
| 32^3            | 11.49x        | 32.11x                  | 64.23%                           |
| 64^3            | 14.48x        | 38.09x                  | 61.98%                           |
| 128^3           | 11.58x        | 28.41x                  | 59.25%                           |
| 256^3           | 10.32x        | 22.04x                  | 53.19%                           |

*Table 2: Speedup of the GPU vs. CPU version. The integrator only speedup disregards this overhead and shows the expected 20-30x speedup that is consistent with other CPU vs. GPU hydrodynamics codes.*

| ![performance_level_5.svg](/assets/img/2025-post-assets/2025-03-03-performance_level_5.svg) |
|:--:|
| *Figure 5: Time to perform a single time step for a 32^3 cell simulation on the CPU vs. GPU* |

| ![performance_level_6.svg](/assets/img/2025-post-assets/2025-03-03-performance_level_6.svg) |
|:--:|
| *Figure 6: Time to perform a single time step for a 64^3 cell simulation on the CPU vs. GPU* |

| ![performance_level_7.svg](/assets/img/2025-post-assets/2025-03-03-performance_level_7.svg) |
|:--:|
| *Figure 7: Time to perform a single time step for a 128^3 cell simulation on the CPU vs. GPU* |

| ![performance_level_8.svg](/assets/img/2025-post-assets/2025-03-03-performance_level_8.svg) |
|:--:|
| *Figure 8: Time to perform a single time step for a 256^3 cell simulation on the CPU vs. GPU* |

Determining the optimal block size will be critical for the performance of this code since the threads within a block have a fixed amount of work, no matter how many threads there are in the block. If we use too many threads then most will be idle most of the time and if we use to few then we won't have enough active threads to take advantage of latency hiding. The optimal number of threads per block turned out to be 128, though 96 and 160 were similar. Figure 9 shows the time the execute the kernel as a function of the number of threads per block.

| ![performance_vs_block_size.svg](/assets/img/2025-post-assets/2025-03-03-performance_vs_block_size.svg) |
|:--:|
| *Figure 9: Kernel execution time as a function of CUDA block size, i.e. number of GPU threads allocated per block/subgrid* |

## Future Work

The prototype GPU integrator has shown that Ramses could be performantly ported to GPUs but making a "production ready" version would require significantly more work, mostly in converting the grid into a more GPU friendly format to eliminate the copying stages and port the remainder of the code and physics modules to GPUs. The following is a list of what I see as the future work that would need to be done along with a few ideas/suggestions.

- Refactor the grid to be more GPU friendly. This probably means restructuring to use a struct of arrays rather than an array of structs. I.e. a structs that has a single `density` array that stores all the densities, then another array for momentum, energy, etc.
- Port the code, or at least the GPU parts, to C++. The state of GPU accelerators in Fortran is quite poor; it feels like using an alpha version of CUDA from a decade ago. The `nvfortran` compiler is rife with bugs that were reported to NVIDIA years ago and remain unfixed. C++ has much better GPU support and more options for GPU APIs. Fortran interoperability with C, and by extension C++, is pretty much limited to calling functions and passing primitive type and arrays of primitives, another reason to convert to structs of arrays rather than arrays of structs.
- AMR support. In the final version we'll likely want to run the integrator for all levels simultaneously either on different streams or with a single kernel launch. This will avoid the case where you don't have enough octs on a given level to occupy the GPU and it sits partially inactive until you get to a level with enough octs; which may never happen.
- MPI support.
- Try 6x6x6 subgrids. I have a suspicion that the reduced shared memory demands of a 6x6x6 subgrid vs an 8x8x8 subgrid might allow more latency hiding and so actually be faster, or at least similar, to the performance of the 8x8x8 subgrid.
- Splitting the integration kernel into multiple kernels might reduce register usage and improve performance. In my opinion that is unlikely to help with the current reconstruction method and Riemann solver since register usage is already low for a finite volume code. However, more complex reconstructions, Riemann solvers, or additional fields (i.e. MHD), will likely significantly increase register usage.
- Convert indexing in the kernel to use enums instead of named members. I.e. instead of `primitive%velocity_x` use `primitive%(velocity_x)`. We did this in Cholla and it make looping through fields and permutation operations much easier.

## How to Run the Code

Since the GPU integrator is essentially a drop in replacement for the `godfine1` subroutine all you need to do is compile the code with the `COMPILER=NVHPC` argument and the makefile will take care of the rest. Make sure you're using a recent version of the NVHPC compilers, on the Della Grace Hopper nodes I used the `hpcx`, `nvhpc-hpcx-cuda12/24.5`, and `cudatoolkit/12.6` modules.
