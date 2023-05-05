---
title:      PPM 3 & Frontier Scaling Tests                 # Title
author:     Robert Caddy               # Author Name
date:       2023-05-05 16:46:31 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PPMC, Reconstruction, Scaling Tests, Frontier]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Parabolic Reconstruction (PPMC)

I set this aside for most of the week but got back to it Friday. I replaced the current PPMC algorithm with the one that Athena++ uses and it seems to be working. All the linear waves look right and the Sod shock tube at least passes. The Einfeldt Strong Rarefaction doesn't, after a handful of time steps it has negative pressure and divergence issues. In the first time step the Y magnetic field is wrong so I've been chasing that down and have narrowed it down to one of the electric fields, I'll figure that out next week.

Once I've got it working 100% I need to do some cleanup on the current method as it's pretty much just copied and pasted from Athena++ and doesn't really work well with Cholla.

## Committee Meeting Prep

I have a committee meeting soon so I spent part of the week prepping for that; writing reports, getting paperwork, etc.

## Scaling Tests

Now that I have working MHD code with PLMC and access to Frontier it's time to run some scaling tests! I'm still waiting on the largest two tests to run but the results from the rest are very promising and show excellent performance. You can find the repo with all my scaling tests stuff [here](https://github.com/bcaddy/scaling-tests).

![cells_per_second](/assets/img/2023-post-assets/2023-05-05-cells_per_second.png)
![ms_per_gpu](/assets/img/2023-post-assets/2023-05-05-ms_per_gpu.png)

## Other

- Automated testing fix. Turns out that the webhook settings weren't right. No idea why it was working before
- Get tests working on Frontier. [PR #295](https://github.com/cholla-hydro/cholla/pull/295)
