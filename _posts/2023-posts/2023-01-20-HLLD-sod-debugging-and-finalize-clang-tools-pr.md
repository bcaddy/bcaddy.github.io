---
title:      HLLD Sod Debugging & Finalize Clang Tools PR                 # Title
author:     Robert Caddy               # Author Name
date:       2023-01-13 17:47:36 -0400  # Date
categories: [MHD, Cholla]     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Clang Tools

The clang tools PR ([PR #211](https://github.com/cholla-hydro/cholla/pull/211))
has been merged! At the beginning of this week I rebased it for the other PRs
that have been added and I wrote a script to help summarize the output of
clang-tidy (`tools/analyze_tidy_checks.py`).

## HLLD Debugging

I think I've narrowed the issue with the Sod shock tube in MHD to the HLLD solver. The issues I'm seeing go away when I replace the HLLD solver with the HLLC solver as you can see in this plot.

![sod heat map](/assets/img/2023-post-assets/2023-01-20-sod-heatmap.tiff)

The left four figures are heatmaps of the x=0 face of the density at time step 34 running with 1, 2, 4, and 1 MPI ranks respectively. The rightmost figure is the same time in the hydro simulation. You can see a clear pattern around the edge where the HLLD solver is generating different values than the rest o the slice when it shouldn't. I haven't found the issue yet but I'm working on it

## Automated Testing

The Pitt CRC has finished their Jenkins setup so we met with them this week about getting it setup. I think it's setup to run and I just need to get the Jenkinsfile working.