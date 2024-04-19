---
title:      PLMP/C Merge and Cosmology Test                 # Title
author:     Robert Caddy               # Author Name
date:       2024-04-19 14:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Testing, Reconstruction]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---
## Cosmology Test

With the help of Bruno, who provided the initial conditions and parameter files ([PR #383](https://github.com/cholla-hydro/cholla/pull/383)), I added a cosmology test, [PR #390](https://github.com/cholla-hydro/cholla/pull/390) and added support for checking the gravity files in the system tests.

## PLMC and PLMP Merge

I merged our two PLM kernels into one with a switch to control if limiting is done in the characteristic or primitive variables. I was able to reuse some of my work from when I tried fusing the PLMC and Riemann solver kernels ([PR #382](https://github.com/cholla-hydro/cholla/pull/382)) and the new version is a single unified PLM kernel that can do limiting in either set of variables. Details are in [PR #391](https://github.com/cholla-hydro/cholla/pull/391).

## Other

- Responding to reviews and keeping PRs up to date, mostly [PR #371](https://github.com/cholla-hydro/cholla/pull/371)
