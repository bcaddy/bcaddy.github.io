---
title:      PLMC Fusion                 # Title
author:     Robert Caddy               # Author Name
date:       2024-03-08 16:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Reconstruction, Refactor, Hack Day]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---
## PLMC/Riemann Solver Fusion

I spent most of this week working on fusing the PLMC interface reconstructor with the Riemann solvers. It's mostly done. I have it working with some optimizations for the new structure and it's passing all the tests. Next week I'll add some comments, documentation, and do performance and memory usage testing. Next week I'll also run some scaling tests with the new version to test large scale performance.

## Hack Day

Had another hack day this week. I made [PR #378](https://github.com/cholla-hydro/cholla/pull/378) which converts the `N_STEPS_LIMIT` compile time macro into a runtime argument.

## Other

- Updated website to v6.5.3