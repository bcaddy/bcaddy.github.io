---
title:      JSI Talk & Clang 17                 # Title
author:     Robert Caddy               # Author Name
date:       2023-09-22 16:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [LLVM, Talk]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## JSI Workshop Talk

I finished all but one plot this week, the big Orszag-Tang Vortex plot is still in the works, and practiced the talk for Astrosnacks. Overall I think it's going well and I'm only a little long at the moment

I'm running some new scaling tests for the talk with PLMC, the max number of cells per GPU, and some code to print out the ID of a GPU that is running slow ([PR #339](https://github.com/cholla-hydro/cholla/pull/339)).

I ran a 1/10th scale version of the big Orszag-Tang Vortex for plotting so that I can experiment with a smaller dataset. That went through on Crusher just fine so now I have the data to work with. To process that in parallel I'm working on learning Dask and trying to get it running on Andes. I'm getting some mixed luck there but it's going slow.

## HDF5 Compression

I tried out GZIP and LZF compression on Cholla datasets. If the data was heavily structured, like a 3D Orszag-Tang Vortex, it worked great but with any random noise added it of course failed to get any real compression. Later I will try on more realistic data and with better compression tools

## Clang 17

The Pitt CRC folks installed LLVM v17.0.1 on the cluster to fix our issues with the old install missing OMP. I updated all the relevant things in Cholla so that LLVM 17 tools work well with it and those changes are in [PR #330](https://github.com/cholla-hydro/cholla/pull/330).

## Other

- [PR #337](https://github.com/cholla-hydro/cholla/pull/337) add script for running clang-tidy on all builds in parallel
- [PR #343](https://github.com/cholla-hydro/cholla/pull/343) add cooling to the CI build matrices
