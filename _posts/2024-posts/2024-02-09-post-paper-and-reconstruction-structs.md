---
title:      Post Paper & Reconstruction Structs                 # Title
author:     Robert Caddy               # Author Name
date:       2024-02-09 14:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Reconstruction, Refactor]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Paper

My MHD paper is out on the [arXiv](https://arxiv.org/abs/2402.05240)!

## Reconstruction Refactor

I did a bunch of work on the reconstruction refactor to fuse the reconstruction and and Riemann solver kernels. This week I posted [PR #371](https://github.com/cholla-hydro/cholla/pull/371) which is converting the Riemann solvers to using structs for their interface states and centralizing the location of some structs. I'm partially done with another PR for some functions to load cells and convert between primitive and conserved variables.

## Other

- [PR #374](https://github.com/cholla-hydro/cholla/pull/374), fix a small bug in the slow rank warning code that caused it to print on the first time step.
