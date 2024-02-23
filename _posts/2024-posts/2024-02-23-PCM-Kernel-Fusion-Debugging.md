---
title:      PCM Kernel Fusion Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2024-02-23 13:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Debugging, Reconstruction, Refactor]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## PCM/Riemann Solver Fusion Debugging

I spent this week debugging the fusion of the Piecewise Constant Method (PCM) and Riemann solver kernels. There were a handful of bugs, mostly related to the more complex thread guards needed for reconstruction kernels that now need to be integrated into the Riemann solvers as well. PCM is now fused into the HLLD and HLLC Riemann solvers and verified for all the integrators and dimensionality that those solvers support. Next week I'll work on integrating the PCM changes into the Roe, Exact, and HLL Riemann solvers.