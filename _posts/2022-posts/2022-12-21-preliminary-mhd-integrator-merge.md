---
title:      Preliminary MHD Integrator Merge                 # Title
author:     Robert Caddy               # Author Name
date:       2022-12-21 09:55:37 -0400  # Date
categories: [MHD, Cholla]     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Clang Tools

I made some tweaks to the clang tools PR
([#211](https://github.com/cholla-hydro/cholla/pull/211)) to get it ready. I
removed the clang-tidy run on ROCm since it's not working. If we figure out how
to get it working I'll add it back. I also figured out how to run `clang-tidy`
on some subset of files and added documentation for running the clang tools.

## Merging the MHD Integrator

I haven't found all the bugs in the integrator yet but to avoid a million merge
conflicts after we reformat all the code I got the MHD stuff I have ready to
merge in. There were quite a few modifications I also made to clean up the code
before the complex rebase. I reorganized all the MHD stuff so every major
component has it's own file and there's a unified MHD namespace with
sub-namespaces. I also used the new grid enums to index all the MHD stuff. The
PR can be found [here](https://github.com/cholla-hydro/cholla/pull/220).

## Other

- Finished my final project for classes
