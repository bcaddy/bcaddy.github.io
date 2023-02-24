---
title:      Finished MHD Debugging (Hopefully)                 # Title
author:     Robert Caddy               # Author Name
date:       2023-02-24 14:20:40 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Debugging, MHD, HLLD]
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

I'm pretty sure that MHD is finally debugged! I found a couple of bugs and typos
in initial conditions in the shock tubes. There were typos in the papers I was
referencing, the fixed initial conditions now agree with the plots in those
papers and the actual values used in Athena++. The corrected initial conditions
can be found in my
[MHD Riemann Problems]({% post_url guides/2021-11-19-MHD-Riemann-Problems %}) post.

There were a couple of other bugs which can find detailed in
[PR #255](https://github.com/cholla-hydro/cholla/pull/255). There are still some
fully 3D tests to run but I've run five different MHD shock tubes in X, Y, Z,
and both left and right orientations so I doubt there are any significant bugs
remaining. I've also added system tests for those shock tubes and a test to
reproduce the other bug I found.

Next week I'll setup the fully 3D tests to verify correctness.

## Configuration Function

MHD has a pretty limited set of compatibility with other Cholla options so I
wrote a function to check that all the compile time and run time configuration
options are correct and nothing conflicts. There's also some general correctness
checks and it's designed to be easily extensible to other modules and make
types. [PR #256](https://github.com/cholla-hydro/cholla/pull/256).
