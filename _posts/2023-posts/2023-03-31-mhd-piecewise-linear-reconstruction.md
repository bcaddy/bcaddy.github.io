---
title:      MHD Piecewise Linear Reconstruction                 # Title
author:     Robert Caddy               # Author Name
date:       2023-03-31 09:49:16 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PLMC, Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Linear Reconstruction

This week I started on the MHD piecewise linear reconstruction in the characteristic variables (PLMC). The steps I've completed are as follows:

- Do some research on PLMC. See [Stone et al. 2008](https://ui.adsabs.harvard.edu/abs/2008ApJS..178..137S/abstract) and [*Introduction to Computational
Astrophysical Hydrodynamics* by Michael Zingale](http://bender.astro.sunysb.edu/hydro_by_example/CompHydroTutorial.pdf).
- Write a test for the current PLMC implementation
- Refactor the PLMC kernel to use device functions and structs. It was originally written before CUDA supported device functions and so is a bit of a monolith. Now it's much shorter and more modular. This potentially allows some code reuse with piecewise parabolic reconstruction.
- Add MHD support. MHD support is a fairly simple extension is most places but the projection into and out of the characteristic variables is quite complex, much more so than in pure hydro.

Additionally I consolodated all the basic utility functions for energy, pressure, etc into the hydro_utilities.h file. Now there are a series of functions there that work for hydro or MHD instead of having different versions in different headers.

Next week I plan on verifying correctness of PLMC and (hopefully) starting on parabolic reconstruction.

## Automated Testing

Automated testing got merged in this week ([PR #229](https://github.com/cholla-hydro/cholla/pull/229)) and promptly decided to not trigger builds on PRs from forks. I've contacted the CRC and hopefully they can resolve it soon.

## Other

- Miscellaneous post MHD tweaks/fixes. See [PR #277](https://github.com/cholla-hydro/cholla/pull/277) for details
- Update website to v5.6.1
