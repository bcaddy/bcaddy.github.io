---
title:      MHD Sod Debugging & Clang Tools PR                 # Title
author:     Robert Caddy               # Author Name
date:       2023-01-13 17:47:36 -0400  # Date
categories: [MHD, Cholla]     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Sod Bug

The 4 rank MHD Sod test isn't passing. I've been trying to figure out why and, after a lot of digging, it looks like there's an issue in the HLLD solver near the boundaries. 32 time steps in some erroneous values show up near the x=0 boundary. I'm not sure why at this point but it's definitely in the HLLD solver since when I replace it with the HLLC solver everything works fine.

## Clang Tools

Now that all the code is in I ran formatting and rebased the [clang tools PR](https://github.com/cholla-hydro/cholla/pull/211). I ran into some issues merging the contents of [PR #222](https://github.com/cholla-hydro/cholla/pull/222). I think C-3PO is missing OpenMP in its install of LLVM 15 and there were some merge artifacts I need to deal with next week. Once those are done it should be ready to merge.

## Other

- Updated this website to v5.4.0
- MHD PR merged in. [PR #220](https://github.com/cholla-hydro/cholla/pull/220)
- Integrated clang-format and tidy into VSC
- git hook to autoformat code
