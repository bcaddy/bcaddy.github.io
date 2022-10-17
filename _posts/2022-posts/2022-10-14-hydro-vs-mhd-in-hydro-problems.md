---
title:      Hydro vs. MHD in Hydro Problems                  # Title
author:     Robert Caddy               # Author Name
date:       2022-10-14 15:20:32 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Debugging

The hydro tests weren't working anymore in MHD so I set about working on fixing
them. I started with the simplier sound wave test. After some digging, the new
Arm debugger was very helpful, I found that the issue was in how I refactored
the sound wave initial conditions. Since the values of each element of the right
eigenvectors defaulted to 1 it was giving me tiny magnetic waves even when there
was no magnetic field. Changing the default to zero fixed it and I added the
sound wave test to the list of MHD tests, with some small tweaks to fix some
bugs in the testing tools for those tests.

The Sod tests appear to not pass mostly becaus the hydro version uses the
piecewise parabolic method in primitive variables (PPMP) and the MHD version
currently only has piecewise constant in primitive variables (PCM) implemented.
I've temporarily created an MHD only Sod test that uses PCM; that test currently
passes with 1 or 2 ranks but not 4, I'll figure that out next week.

To help with finding the issues I wrote a simple notebook to compare the hydro
and MHD results which is available upon request.

## Other

- Read [Tacconi et al. 2020](https://www.annualreviews.org/doi/10.1146/annurev-astro-082812-141034)
