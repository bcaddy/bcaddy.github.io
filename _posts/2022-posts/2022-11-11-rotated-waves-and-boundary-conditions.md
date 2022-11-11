---
title:      Rotated Waves & Boundary Conditions                 # Title
author:     Robert Caddy               # Author Name
date:       2022-11-11 13:54:14 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Linear Waves, Boundary Conditions]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Rotated Waves

I fixed the bug in the rotation when generating rotated waves and now I believe
grid aligned waves in any direction are working. Non-grid aligned waves are
trickier. Since the initial conditions aren't lined up as neatly it gives a
non-zero divergence unless you initialize with the magnetic vector potential or
perform divergence cleaning. I've set this issue aside for now and am just doing
grid aligned waves but will likely implement one or the other in the future. For
some reason I get slightly different timesteps when running in the different
directions. The results are still correct though so I'm not worried about it at
this time.

I added a test for MPI versions of the slow wave and it is working correctly.

## Boundary Conditions

I have been using periodic boundary conditions for the linear waves. I tried the
linear waves with reflecting and transmissive boundaries and both led to
non-zero divergence's before the first timestep. I'll work on this next week.

## Other

- Present on [Shankar et al. 2022](https://arxiv.org/abs/2210.17509)
