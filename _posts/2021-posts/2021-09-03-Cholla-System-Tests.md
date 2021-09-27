---
title:      Cholla System Tests       # Title
author:     Robert Caddy               # Author Name
date:       2021-09-03 15:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Code Coverage] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# System Testing in [Cholla](https://github.com/cholla-hydro/cholla)

My main project this week is writing a function to perform system tests in
Cholla. I'm at the point where it can check if all the relevant files exist and
asynchronously launch Cholla. The next step is to read in both the fiducial and
test files. This requires learning how to use the HDF5 C++ API which I spent
most of a day on.

# Cholla Source Reorganization
Currently the `src` directory in Cholla has 102 files in it that aren't sorted
into subdirectories. Evan and I sorted them and then I spent half a day fixing
all the `#include` statements. I was able to largely automate this and in the
future any changes should be easy as all the included statements have a common
format; details can be found in [Cholla PR #85](https://github.com/cholla-hydro/cholla/pull/85).
I also stripped out all the trailing whitespace in the files withing `src` to
avoid future conflicts with the
[Trailing Spaces](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
VS Code extension([Cholla PR #86](https://github.com/cholla-hydro/cholla/pull/86)).

## Other
- Cleaned up some extra extensions in VS Code and made sure all my extensions
  were consistent across hosts
- Experimented with GitHub Copilot