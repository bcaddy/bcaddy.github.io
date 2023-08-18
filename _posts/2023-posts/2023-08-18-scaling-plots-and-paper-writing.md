---
title:      Scaling Plots & Paper Writing                 # Title
author:     Robert Caddy               # Author Name
date:       2023-08-18 13:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Scaling Tests, Paper Writing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## Scaling Tests

I finished running the scaling tests this week and ran another set of them to see if the degraded performance at scale was real or a just a fluke. The second run confirmed it to be real but also showed degraded performance at a different number or ranks. There's also sometimes a ~17ms difference between the min and max time step time in the "slow" runs. We're not sure exactly what's going on, it might be network congestion, a slow GPU, an issue on the code, or just that running at scale is slow sometimes.

### First Run

![ms_per_gpu_run_1](/assets/img/2023-post-assets/08-August/scaling_tests_ms_per_gpu_first_run.pdf)
![cells_per_second_run_1](/assets/img/2023-post-assets/08-August/scaling_tests_cells_per_second_first_run.pdf)

### Second Run

![ms_per_gpu_run_2](/assets/img/2023-post-assets/08-August/scaling_tests_ms_per_gpu_second_run.pdf)
![cells_per_second_run_2](/assets/img/2023-post-assets/08-August/scaling_tests_cells_per_second_second_run.pdf)

## Paper Writing

I wrote the section on the scaling plots and did some general revisions.

## Testing

I wrote up a test for the `_ctSlope` function. Given that I'm thinking about rewriting that function to utilize templates I'm holding off on merging the test until I decide what I actually want to test.

## Other

- Finalized and submitted PR for test coverage stuff ([PR #318](https://github.com/cholla-hydro/cholla/pull/318))
- Fixed some issues with the function that checks the configuration of Cholla. [PR #319](https://github.com/cholla-hydro/cholla/pull/319)
