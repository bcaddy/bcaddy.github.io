---
title:      PLMC Fusion 2                 # Title
author:     Robert Caddy               # Author Name
date:       2024-03-15 16:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Reconstruction, Refactor, Paper]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## PLMC Kernel Fusion

I did the last of the debuggin on NVIDIA this week and when I went to test on AMD GPUs I ran into some significant issues. The two primary issues were:

1. A bug in the `AutomaticLaunchParams` class
2. The default 128 register limit in the HIP compiler

The bug was reasonably easy to fix. On AMD you need to specify the maximum number of threads per block by querying the kernel attributes with the `cudaFuncGetAttributes` function and then use the `maxThreadsPerBlock` method of the returned struct to set the maximum number of threads per block in the `cudaOccupancyMaxPotentialBlockSize` call. I added this fix to [PR #377](https://github.com/cholla-hydro/cholla/pull/377).

The second issue was more tricky and led to more issues. By default it seems that HIP kernels are limited to using 128 registers per thread. You can manually raise this most easily with the `__launch_bounds__()` specifier. However, even with that set the optimal number found through experimentation with each kernel, the additional register demands of fusing the PLMC reconstructor with the Riemann solver meant that fewer blocks could be run at once and overall performance decreased compared to the unfused version. So for now the PLMC fusion PR ([PR #382](https://github.com/cholla-hydro/cholla/pull/382)) is pointing at a branch that is not dev in case anyone wants to pursue it in the future. I think that a net performance gain could be made if the kernels accessed cells in the direction of the solve rather than always in X so that data could be shared between cells but I don't currently have the bandwidth to investigate that.

## Other

- Started scaling tests for new fused version of Cholla
- Started on reviewer report for the MHD methods paper
