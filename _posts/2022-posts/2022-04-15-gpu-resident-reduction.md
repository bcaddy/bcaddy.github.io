---
title:      GPU Resident Reduction     # Title
author:     Robert Caddy               # Author Name
date:       2022-04-15 15:54:19 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Reductions]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## GPU Resident Reduction

This week I implemented a GPU resident parallel reduction for Cholla as
described in [this NVIDIA blog
post](https://developer.nvidia.com/blog/faster-parallel-reductions-kepler/).
Performance is similar to current reductions that we use but instead of a
complicated chunk of code required and finishing the reduction on CPU it's
entirely GPU resident and can be done with a single device function call at the
end of a transform/reduce kernel. I've implemented it for the time step
calculations but currently it's returning slightly different values than the old
version. The end result still appears to be correct but I'm working on finding
out where exactly the differences lay.

## Magnetic Divergence

I've finished implementing a kernel and series of functions for determining the
divergence of the magnetic field, reducing it both at the local and global
level, checking the result, and then either exiting if it's too high or just
reporting it if the value is small enough to be acceptable.

## Other

- Read and presented on [Morton et al. 2022](https://arxiv.org/abs/2204.01757)