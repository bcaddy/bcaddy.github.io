
---
title:      Occupancy & MHD Debugging  # Title
author:     Robert Caddy               # Author Name
date:       2022-10-07 14:22:42 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Reductions, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Occupancy

With the help of some folks at NVIDIA I finally figured out the issue I was
running into with our reductions. It turns out that the reduction kernels
required more registers in debug mode and the GPU didn't have enough. I fixed
this by setting the kernel launch parameters using the occupancy API instead of
just using the maximum number of threads and blocks the GPU supports.

## MHD Debugging

My MHD code passes all the compute sanitizer checks, after I made sure to
initialize all the GPU memory. I'm now working on getting it to pass all the
hydro tests again since it no longer passes all of them. Once that's done I'm
going to implement some analytical MHD tests so that I know when I have exactly
correct results, also, the analytical cases are much simplier.

## Other

- Consulted on the refactoring of the I/O routines.