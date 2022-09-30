---
title:      Compute Sanitizer & Device Atomics # Title
author:     Robert Caddy               # Author Name
date:       2022-09-30 12:13:54 -0400  # Date
categories: [Atomics]     # Catagories, no more than 2
tags:       [Atomics, Compute Sanitizer, Dynamic Analyzer] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## NVIDIA Compute Sanitizer

[PR \#196](https://github.com/cholla-hydro/cholla/pull/196)

I got the NVIDIA Compute Sanitizer working with Cholla this week to help
diagnose any issues in my code or Cholla in general. It found some problems that
I think are not critical but I noted in
[Issue \#197](https://github.com/cholla-hydro/cholla/issues/197).

## New Atomics

I updated our `atomicMax(double *, double)` to use the same method as the
[RapidsAI](https://github.com/rapidsai/cuml/blob/branch-21.10/cpp/src_prims/stats/minmax.cuh)
folks. Their method is simplier and more correct than ours. A PR for this is
forthcoming.

## Other

- [PR \#195](https://github.com/cholla-hydro/cholla/pull/195)
