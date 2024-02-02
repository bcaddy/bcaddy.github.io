---
title:      Cholla 3.0 & Reconstruction Refactor                 # Title
author:     Robert Caddy               # Author Name
date:       2024-02-02 16:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Release, Reconstruction, Refactor]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Cholla Hack Day/v3.0

We've been working on our release of v3.0 of Cholla so we spent our hack day this week finalizing that and the official release should be early next week. In addition, I tried using CUDA streams to run multiple kernels concurrently on the GPU. This didn't lead to any performance increase so I scrapped it. Per the suggestion of some other members of the group I also made PRs [#368](https://github.com/cholla-hydro/cholla/pull/368) and [#369](https://github.com/cholla-hydro/cholla/pull/369) to make some member variables private and add automatic retries of the testing step in our Jenkins pipeline; sometimes tests fails for external reasons and we don't want that to require as much manual intervention.

## Reconstruction Refactor

I started on the reconstruction refactor we've been planning. This will convert all the reconstruction kernels in to device functions that are called in the Riemann solvers which should dramatically reduce memory bandwidth and capacity usage and improve performance. I tried a simplier version of PLMC, which turned out to not work, and started on some of the prep work I need to do for the refactor.

## Other

- More paperwork for my defense/graduation
- Reviewed [PR #367](https://github.com/cholla-hydro/cholla/pull/367)
