---
title:      Reconstruction Refactor                 # Title
author:     Robert Caddy               # Author Name
date:       2024-02-16 14:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Reconstruction, Refactor]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

- reconstruction, new functions, pr 375
- pcm fusion debug

## Reconstruction Refactor

I finished adding the new loading and conversion functions and integrated them into the PLMC and PPMC kernels ([PR #375](https://github.com/cholla-hydro/cholla/pull/375)). The templating used for this resulted in a 6% improvement in overall performance of Cholla.

The next step is to convert PCM into a device function that can be called from within the Riemann solvers. I have a first draft of this but it currently has bugs that I've been having trouble finding.

## Removing PLMC Monotonization

Evan pointed out that the fixed version of PLMC (see [PR #361](https://github.com/cholla-hydro/cholla/pull/361)) was more diffusive than expected. After some investigating, with the bug fix to the utility functions the monotonization step is no longer required and having it too often lowers the effective order of the method to first order. I removed it and added a test to check for that kind of issue in the future ([PR #376](https://github.com/cholla-hydro/cholla/pull/376)).

Here's the Kelvin–Helmholtz instability test with the monotonization. Note how fuzzy and indistinct the "arms" of the vortices are.

![Monotonized version](/assets/img/2024-post-assets/2024-02-16-plmc-with-monotonization.png)

Here's that same test without the monotonization. The vortices are much crisper and don't show the dissipation from the above image.

![Un-monotonized version](/assets/img/2024-post-assets/2024-02-16-plmc-without-monotonization.png)
