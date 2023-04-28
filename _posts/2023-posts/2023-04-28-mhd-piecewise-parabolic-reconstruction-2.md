---
title:      MHD Piecewise Parabolic Reconstruction                # Title
author:     Robert Caddy               # Author Name
date:       2023-04-14 09:49:16 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PLMC, Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Parabolic Reconstruction (PPMC)

I'm still stuck on the oscillation in the Brio & Wu shock tube. It seems like it might be an issue with the method/limiters not working for MHD rather than them having a bug since [this page](https://flash.rochester.edu/site/flashcode/user_support/flash_ug_devel/node188.html#fig:BrioWu_standardPPM_a) in the FLASH user guide mentions something similar. However, a new limiter didn't solve the issue. I'm going to try a more comprehensive rewrite soon to match Athena++ and see if that fixes the issue.

## Hack Day/Clang-Tidy Checks

Addressed 7 clang-tidy checks in [PR #293](https://github.com/cholla-hydro/cholla/pull/293).
