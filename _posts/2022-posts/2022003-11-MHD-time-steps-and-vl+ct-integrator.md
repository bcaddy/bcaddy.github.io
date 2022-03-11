---
title:      MHD Time Steps & VL+CT Integrator  # Title
author:     Robert Caddy               # Author Name
date:       2022-03-11 15:59:03 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [bugs, Constrained Transport, VL+CT, Van Leer]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Time Steps & Refactor

I implemented MHD time steps for the 3D case and refactored the hydro time steps
to move the time step calculations into their own "crossing time" function to
bring the hydro builds to parity with the MHD builds, reduce code duplication,
and improve readability. I also wrote tests for the two crossing time functions
and the function that they call to compute the cell centered magnetic field.

## VL+CT Integrator

I started on implementing the VL+CT (Van Leer + Constrained Transport)
integrator by modifying the current 3D Van Leer integrator. So far I understand
how the integrator works and I've gotten all the required arrays allocated and
deallocated. My next step is to work on modifying the interface reconstruction
kernels to work with MHD. I need to do some re-reading on exactly what kind of
reconstruction the VL+CT integrator expects next week before I can move forward
on modify the reconstruction kernels.

## Pull Requests

- [PR #133](https://github.com/cholla-hydro/cholla/pull/133) GPU time steps
- [PR #134](https://github.com/cholla-hydro/cholla/pull/134) testing data module and fixes
- [PR #136](https://github.com/cholla-hydro/cholla/pull/136) preliminary MHD support

## Other

- Read [Wibking & Krumholz 2021](https://arxiv.org/abs/2105.04136)
- Fixed a bug in MHD initial conditions where only one cell was being set
  instead of an entire face
