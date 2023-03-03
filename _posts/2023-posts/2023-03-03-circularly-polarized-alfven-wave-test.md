---
title:      Circularly Polarized Alfven Wave Test                 # Title
author:     Robert Caddy               # Author Name
date:       2023-03-03 16:58:57 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Tests, MHD Tests, clang-tidy]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Circularly Polarized Alfvên Wave Test (CPAW)

I worked this week to add the CPAW initial conditions and test based on the CPAW test in [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract) and the [Athena++ source code](https://github.com/PrincetonUniversity/athena/blob/master/src/pgen/cpaw.cpp). The implementation of the initial conditions differs from previous MHD initial conditions primarily in that the magnetic field is initialized from the magnetic vector potential. This was fairly quick to implement but I quickly ran into issues with the initial conditions having significant non-zero divergence. After a lot of debugging I found that the issue is in the initial conditions. You can clearly see the issue in the figures below. The first figure shows the \\( B_x \\) field initial conditions before the boundary conditions are applied and the second shows the \\( B_x \\) field after the reflective boundary conditions are applied to the \\( -X \\) side. Clearly the ghost cells shouldn't spike like that.

![Pre BC plot](/assets/img/2023-post-assets/2023-03-03-pre-BC.png)

![Post BC plot](/assets/img/2023-post-assets/2023-03-03-post-BC.png)

I'm not certain how to fix it at this time but I will be working on it next week. Shout out to [Alwin Mao](https://scholar.google.com/citations?user=MAm7BIcAAAAJ&hl=en) and [Chris White](https://web.astro.princeton.edu/people/chris-white) for helping me debug this issue.

## Clang-tidy Check Enabling

When looking at the clang-tidy checks I found that the `bugprone-signed-char-misuse` check only appeared in our singular C language file and the contents of that file aren't actually used. So, during our biweekly hack session, I removed that file, enabled the check, and stripped out all C language support from our build system. ([Issue #253](https://github.com/cholla-hydro/cholla/issues/253), [PR #259](https://github.com/cholla-hydro/cholla/pull/259))
