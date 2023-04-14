---
title:      MHD Piecewise Linear Reconstruction 2                # Title
author:     Robert Caddy               # Author Name
date:       2023-04-14 09:49:16 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PLMC, Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Linear Reconstruction

PLMC is done and in [PR #288](https://github.com/cholla-hydro/cholla/pull/288). I ran into some issues with the verification of the blast wave and Orszag-Tang vortex but both turned out to be initial condition issues not issues with PLMC.

Here's what else I did:

- Updated all the MHD test date for PLMC
- Moved all the new reconstruction device functions into a new `reconstruction` namespace and file so they can be used with PPMC easily
- Added tests for all the new `reconstruction` functions

## Other

- Starting on PPMC
