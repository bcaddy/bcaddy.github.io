---
title:      Arm DDT with GPUs                 # Title
author:     Robert Caddy               # Author Name
date:       2022-09-08 11:53:28 -0400  # Date
categories: [Arm DDT, Guides]     # Catagories, no more than 2
tags:       [Debugger, Debugging]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Debugging GPU Codes with Arm DDT

See the [Arm Forge User Guide](https://developer.arm.com/documentation/#f[navigationhierarchiescontenttype]=User%20Guide&cf[navigationhierarchiesproducts]=%20Tools%20and%20Software,Server%20and%20HPC,Arm%20Architecture%20tools,Arm%20HPC%20products,Arm%20Forge) for all the info, this is just a place for some notes and tips

- Use `-g -O0` to compile host code and `-g -G -cudart shared` to compile device
  code. The `-g -G` enable debugging symbols and `-cudart shared` enable device
  memory debugging.
- A device pointer's contents can be accessed by preappending `@global` to its
  type. A permanant version of this can be done with expressions.
  - `((@global TYPE *)(VARIABLE_NAME)` to get the proper pointer
  - `((@global TYPE *)(VARIABLE_NAME)[IDX]` to get the value at `IDX`
  - `((@global TYPE *)(VARIABLE_NAME)[IDX]@N` to get `N` values starting at `IDX`
- The expressions panel: can also be used for any other debugging or math
  expression you want
- Array Viewer: Any expression can go in the brackets and be displayed in 2D.
  The correct indexing scheme for Cholla is `xid + yid*nx + zid*nx*ny +
  field*n_cells`.

## Arm MAP

- `map --profile --cuda-kernel-analysis --cuda-transfer-analysis mpirun -n 4 EXECUTABLE ARGS`
  - `--profile`: Standard flag for profiling
  - `--cuda-kernel-analysis`: Enables CUDA kernel profiling
  - `--cuda-transfer-analysis`: Enables CUDA memory transfer profiling
  - The CUDA args require `-lineinfo` when compiling
  - The CUDA args have a HUGE performance impact on host code so host and device
    code should be profiled separately. The NVIDIA GPU metrics will be adversely
    affected by this overhead, particularly the GPU utilization metric
- View with `map —connect MAP_FILE.map` or download and open with Arm MAP
- Can make reports from .map files with `perf-report map-file.map`

## Arm Performance Reports

`perf-report mpirun -n 4 EXECUTABLE ARGS` or `perf-report map-file.map`.
Generates a nice HTML and text summary of the profiling.
