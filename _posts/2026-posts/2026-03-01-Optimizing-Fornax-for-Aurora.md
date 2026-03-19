---
title:      Optimizing Fornax for Aurora                # Title
author:     Robert Caddy               # Author Name
date:       2026-03-19 12:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [GPU, Fornax, Aurora, Intel GPU, ALCF, Argonne National Lab, C Language]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
geometry: margin=4cm # sets the margins for pandoc
---

<!-- 
Convert to pdf with:
pandoc -s -o optimizing_fornax_report.pdf 2026-03-01-Optimizing-Fornax-for-Aurora.md
 -->

# Optimizing Fornax for Aurora (and Polaris)

## Summary

The primary goal of this project was to improve the GPU performance of [Fornax](https://doi.org/10.3847/1538-4365/ab007f) on [Aurora](https://www.alcf.anl.gov/aurora) with a secondary goal of improving performance on [Polaris](https://www.alcf.anl.gov/polaris); note that this project is only concerned with single GPU performance so MPI performance and scaling performance is largely disregarded. The original goal was to get a 2x speedup on Aurora to match the performance on Polaris. At the conclusion of this project I have achieved a 1.82x speedup.

One thing to note is that in the middle of this project the GPU clock speed of the GPUs on Aurora was lowered from 1600MHz to 1500MHz. All the speedups quoted in this report are based off running the original version of Fornax on a node with that 1500MHz clock speed and comparing the results to the optimized version also running on a 1500MHz node. However, on the GitHub pages for the various PRs most of those are comparing to a fiducial run on a node with a 1600MHz GPU clock speed so some of the speedups there are reported as slightly lower than they actually are.

A significant confounding factor with measuring performance and performance gains on Aurora is the large run-to-run and GPU-to-GPU variance. I've noticed a roughly 5% variance in both which makes it challenging to quantify what impact a given change has on performance. As such all the speedups here are simply the average speedup of the `step` function, which occupies most of the runtime, over 10 runs across 2 different nodes where each run is ~50 time steps.

## Pull Requests

Below is the list of pull requests with brief summaries of the changes. More detailed information on each PR can be found by following the link to the GitHub page for that PR, though those links will only work if you have access to the Fornax repository. All performance gains stated are for Aurora, none of these changes had significant impacts on the performance of Fornax on Polaris. Note that this list is ordered by the timeline within the code which doesn't exactly correspond to monotonically increasing PR numbers.

| Pull Request                                                                                                                  | Cumulative speedup |
| ----------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| [PR 9](https://github.com/PrincetonUniversity/Fornax/pull/9)                                                                  | 1.04x              |
| [PR 11](https://github.com/PrincetonUniversity/Fornax/pull/11)                                                                | 1.09x              |
| [PR 12](https://github.com/PrincetonUniversity/Fornax/pull/12)                                                                | 1.17x              |
| [PR 13](https://github.com/PrincetonUniversity/Fornax/pull/13)                                                                | 1.59x              |
| [PR 14](https://github.com/PrincetonUniversity/Fornax/pull/14)                                                                | 1.61x              |
| [PR 16](https://github.com/PrincetonUniversity/Fornax/pull/16)                                                                | 1.65x              |
| PRs [17](https://github.com/PrincetonUniversity/Fornax/pull/17) & [15](https://github.com/PrincetonUniversity/Fornax/pull/15) | 1.82x              |
| [PR 18](https://github.com/PrincetonUniversity/Fornax/pull/18)                                                                | 1.82x              |

*Table 1: summary of performance gains*

- [Refactoring & setting groundwork, PR #9](https://github.com/PrincetonUniversity/Fornax/pull/9), ~1.04x net speedup
  - This PR contains a handful of changes before I started the major modifications. These changes are mostly refactoring code for clarity and so don't generate significant performance gains. Nonetheless these changes result in a few percent gain on Aurora, though that is within run-to-run variance. There are smaller gains on Polaris too but they're too small for me to be sure they're not run-to-run variance.
- [Update compiler flags PR #11](https://github.com/PrincetonUniversity/Fornax/pull/11), ~1.09x net speedup
  - Updated the compilers flags for Aurora based on suggestions from the intel engineers. Primarily that the old `-device 12.60.7` flag with the newer `-device pvc` flag. This results in a roughly 2% performance gain.
- [Apply workaround for intel compiler bug PR #12](https://github.com/PrincetonUniversity/Fornax/pull/12), 1.17x net speedup
  - The two host-to-device (H2D) copies of `sim_p` and `sim_ph` in the step function took about 8% of the total runtime. This was largely because the compiler was launching many thousands of extra very small copies. This change was suggested by Patrick Steinbrecher at Intel as a workaround until Intel fixes the issue. It reduces each copy from about 23ms to 2.9ms. I've witnessed performance gains of 10-15% from this change. I also applied this change to the device-to-host copies which showed this issue as well, though to a lesser degree. That got another few percent gain.
- [Remove unnecessary memsets in GPU kernels PR #13](https://github.com/PrincetonUniversity/Fornax/pull/13), 1.59x net speedup
  - The radiation module had time consuming memsets in a few functions called on the GPU that were using a ton of time. Replacing them by initializing the arrays to zero properly results in an additional 1.3-1.4x speedup, for a project total of 1.5-1.6x speedup.
- [Remove verbose and commented out code PR #14](https://github.com/PrincetonUniversity/Fornax/pull/14), 1.61x net speedup
  - Removed the verbose variable all over the place to simplify the GPU code since it isn't useful there. Also removed a bunch of commented out code to generally clean the code up a bit. This improves performance a little bit it's within run-to-run variance. Total speedup seems to have gone from 1.5-1.64x to 1.54-1.66x and the compiler is no longer warning that the `push` kernel is spilling registers to L1.
- [Split prim_to_fluxes3 into 3 kernels PR #16](https://github.com/PrincetonUniversity/Fornax/pull/16), ~1.62x net speedup
  - I split the three parts of the `prim_to_fluxes3` kernel into their own kernels with `nowait` directives to they can all run concurrently. This is about 20% faster on Aurora per invocation than when they were all one kernel. Time per invocation is down to ~43ms from ~52ms. A full time step went from ~440ms to ~425ms, a ~3.5% gain. On Polaris the gain is about half as much, 45ms per invocation down from 50 and total time step time is ~309ms down from ~318ms, a ~2.8% gain.
- [Refactor `multipole_gravity_start` to improve performance PR #15](https://github.com/PrincetonUniversity/Fornax/pull/15) and [Clarify comments since PR #15 workaround is now permanent PR #17](https://github.com/PrincetonUniversity/Fornax/pull/17), 1.82x net speedup
  - Profiling showed that the kernel in `multipole_gravity_start` was taking about 20-25% of the run time and that almost all of that was in the final load from `ylm` before the atomic add. This was because `ylm` is extremely large (about 1.6KB) and there isn't space in the registers and L1 cache combined to hold a ylm array for each thread. As such the ylm array gets evicted to global memory and the resulting load later is quite slow. I refactored this so that the loop over cells is parallelized with one team per iteration instead of one thread per iteration. Then thread 0 in each team does most of the computations and the final `l` and `m` loops are run in parallel across the team. This enables me to keep `ylm` in shared memory/L1 cache and improve kernel performance by about 4x so that this kernel now takes about 5% of the runtime. This improves performance by quite a bit, from ~1.5x total speedup for this project to ~1.8x, though I've seen as high as 1.89x. This refactor is only faster on Aurora and is much slower on Polaris so I've used preprocessor directives to modify the parallelization based on the system that Fornax is running on. The `nvc` compiler on Polaris also has some bugs related to using OpenMP team local memory which might have contributed to the slowdown.
- [Removed some timing code I missed PR #18](https://github.com/PrincetonUniversity/Fornax/pull/18), 1.82x net speedup

## Things that Didn't Work

- Adding `nowait` + `omp taskwait` to copies between host and device. I tried adding them all over the `step` and it either had no impact or made it very slightly slower. I got the same results on Aurora and Polaris
- [GPU-Aware MPI](https://github.com/PrincetonUniversity/Fornax/pull/10) to eliminate expensive `sim_p` and `sim_ph` copies. It's an issue with both `sim_p`/`sim_ph` and Aurora. GPU-aware MPI on Aurora is not recommended at this time according to our ALCF point of contact. Additionally, the MPI commands in Fornax rely on constructed MPI datatypes and strides that require access to the CPU pointers. Since `sim_p` and `sim_ph` are both lookup tables to arrays with unclear organization on the GPU this means that it's not easy, and potentially impossible, to use GPU aware MPI without either massive rewrites to the MPI infrastructure in Fornax or rewriting `sim_p` and `sim_ph` into standard arrays.
- Converting the `geom` variable from an array of structs to a struct of arrays. No gain on Aurora, potential gain on Polaris but after a system update it segfaults. Since the primary goal was performance improvement on Aurora I didn't pursue this much.
- Adding `const` and `restrict` to everywhere possible had no impact on performance.
- Adding more parallel regions within `multipole_gravity_start`. All the other loops in `multipole_gravity_start` are either not parallelizable or adding a parallel region to them slowed the code.
- Changing compiler flags. I tried pretty much every combination of compiler flags. The only ones that helped were some flags related to "fast math" and precision but they led to unstable results for very little gain in performance
- There's a few more memsets floating around in GPU code. Removing them had no impact on performance.
- Applying the same one-team-per-cell trick that worked on `multipole_gravity_start` to `push`. `Push` has way too many functions with side effects that write to things that would be in shared memory for this to work without a massive refactor of the kernel.

## Future Potential Optimizing Opportunities

- Most kernels in Fornax have very large thread-local arrays. Refactoring the code to remove these could significantly improve performance. I tried this in the `push` and `prim_to_fluxes3` kernels but could only eliminate a small subset of the large arrays in the time remaining in the project and that wasn't enough to make a difference.
- Multidimensional arrays are stored as lookup tables. Replacing this with just a regular array might improve performance if the programmer is careful to get coalesced I/O. This might be more of a style change that performance one. Careful profiling would be required to determine if it's worth the effort.
- Converting the many arrays-of-structs to structs-of-arrays. This is similar to the last suggestion in that careful profiling should be done to determine if this is worth the time.
