---
title:      DeviceVector & Fixes for moving the CAAR branch to main                 # Title
author:     Robert Caddy               # Author Name
date:       2022-07-15 16:50:55 -0400  # Date
categories: [Cholla]     # Catagories, no more than 2
tags:       [C++11, C++14, C++17, Reductions, DeviceVector]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Fixes

This week our long term development branch, `CAAR`, got merged into `main`.
Before that could happen I needed to submit a couple of fixes for outstanding
issues.

### GoogleTest Version

Our automated builds and scripts for building GoogleTest from scratch all build
GoogleTest main. However, after v1.12.1 GoogleTest will no longer support C++11
which [Cholla](https://github.com/cholla-hydro/cholla) uses. I updated the build
scripts to instead pull a specific release of GoogleTest ([PR
\#162](https://github.com/cholla-hydro/cholla/pull/162)). Since future version of
Cholla will be using C++14 or newer I submitted a second PR to switch back to
GoogleTest main when the C++14 version of Cholla is ready ([PR
\#171](https://github.com/cholla-hydro/cholla/pull/171/files)).

### GPU Resident Reductions

The GPU resident reduction utilities I wrote awhile ago had a race condition
that occasionally caused issues. I fixed it and added a function for easily
setting GPU memory. I also cleaned up some misleading documentation and
implementation. [PR \#163](https://github.com/cholla-hydro/cholla/pull/163)

## DeviceVector

Device side pointers can be annoying and difficult to work with, plus they don't
conform well with the C++ principle of Scope-Bound Resource Management or RAII.
I implemented a simple class that has an interface similar to `std::vector` for
handling resource allocation and deallocation, copying to and from the device,
and allowing easy host side access to values in the array. [PR
\#170](https://github.com/cholla-hydro/cholla/pull/170/files)

## Reading

- [Yuankang et al. 2022](https://arxiv.org/abs/2110.14246)
- [Di Teodor et al. 2022](https://arxiv.org/abs/2008.09121)
