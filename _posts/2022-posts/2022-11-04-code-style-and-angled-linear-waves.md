---
title:      Code Style & Angled Linear Waves                 # Title
author:     Robert Caddy               # Author Name
date:       2022-11-04 15:10:47 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Debugging, Best Practices, Scientific Software]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Code Style in Cholla

We spent quite a bit of time this week discussing what
[format](https://github.com/cholla-hydro/cholla/discussions/207) and
[naming](https://github.com/cholla-hydro/cholla/discussions/206) scheme we want
to adopt for Cholla. This is part of our broader effort to adopt more
[scientific software best
practices](https://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.1001745&type=printable).
The naming scheme we will enforce with `clang-tidy` and the format with
`clang-format`.

## MHD Linear Waves

The slow magnetosonic waves are now passing! There was a typo in the
eigenvectors for it but now all four linear waves are passing in the \\( x
\\)-direction.

I updated the linear wave eigenvectors to use the simplier ones from [Gardiner &
Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract).

I generalized the linear wave initial conditions to any ange. Currently the
waves are not passing in the non \\( x \\)-direction. This is in part due to a
bug in the rotated initial conditions that I haven't sorted out yet. I think
there's also a bug in the boundary conditions but I'm not positive.
