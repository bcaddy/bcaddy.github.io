---
title:      MHD Piecewise Linear Reconstruction 2                # Title
author:     Robert Caddy               # Author Name
date:       2023-04-07 09:49:16 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PLMC, Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Linear Reconstruction

PLMC is pretty much done. I spent the week debugging it and making some other tweaks. There's some cleaning up to do and final verification but that should be done early next week. Pretty much all the code I've written for it so far can be used in PPMC, including the most complex parts, so I'm hoping that PPMC will be reasonably easy.

## Automated Testing

Automated testing got fixed and then broke again. Manually triggering builds works though.

## Other

- Fixed [issue #280](https://github.com/cholla-hydro/cholla/issues/280) with [PR #273](https://github.com/cholla-hydro/cholla/pull/273)
- Fixed [issue #281](https://github.com/cholla-hydro/cholla/issues/281) with [PR #283](https://github.com/cholla-hydro/cholla/pull/283)
- Submitted [Orszag-Tang Vortex test PR](https://github.com/cholla-hydro/cholla/pull/284)
