---
title:      MHD Interface Reconstruction & Data Format Refactor  # Title
author:     Robert Caddy               # Author Name
date:       2022-03-18 15:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Bugs, Constrained Transport, VL+CT, Van Leer, Macros]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## VL+CT Integrator

I read up on where we need primitive vs characteristic reconstruction with
VL+CT. We can use either but unlike CTU+CT we don't need to characteristic
tracing step to update the hydro variables a half time step before running them
through the Riemann solver. So the plan is to implement all the Cholla
reconstruction methods for MHD but for now I'm just doing Piecewise Constant
Method (PCM) and once everything else works I'll add linear and parabolic
methods.

I added MHD support to PCM and refactored the current PCM kernel to achieve
roughly an 60% performance improvement by reducing the number of reads from
device memory. Now the 3D Van Leer integrator has MHD support up through the
first Riemann solve. Now that I've actually been working in the integrator I
decided to format the interface state and fluxes differently than I had
originally intended when writing the HLLD solver. This required a minor refactor
and simplification of the HLLD solver which went pretty easily. The process of
updating the tests for the HLLD solver was a lot trickier. With the new data
format several of the things I was doing in the testing didn't really make sense
to do anymore but it took a lot of care, and fighting with `std::rotate` to
remove them cleanly and correctly. However, the testing code is much shorter and
clearer now and I found a few logical bugs and a minor memory leak while I was
at it.

## Git Hash & Compile Time Macros

I made it so that when Cholla knows what commit hash it was
compiled at and which preprocessor macros were passed at compile time with the
`-D` argument. I've got it working and writing that information out to the
terminal, log files, ASCII, and HDF5 output. [PR #138](https://github.com/cholla-hydro/cholla/pull/138)

## Other

- Started on [Beck 2015](https://ui.adsabs.harvard.edu/abs/2015A%26ARv..24....4B/abstract)
- Finished the [git
  introduction](https://gist.github.com/bcaddy/f822ba0786be8a1b8edcc7d74e6eca1b)
  I started two weeks ago
