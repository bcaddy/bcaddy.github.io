---
title:     Testing Data & Time Step Refactor  # Title
author:     Robert Caddy               # Author Name
date:       2022-03-04 10:46:42 -0400  # Date
categories: [Cholla, MHD]               # Catagories, no more than 2
tags:       [Testing, GPGPU]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Cholla Testing Data

The separate repo for testing data has been implemented and tested and is
connected to the main Cholla repo as a submodule. Everything seems to work fine,
I'm just waiting for Git LFS to be installed on the Pitt CRC machines before I
submit a PR.

## Time Step Refactor

I started on implementing the MHD time step calculations but partway through
discovered some inconsistencies with how the time step is calculated. On the
first time step it was done entirely on the CPU and on subsequent time steps
there were both global host and device arrays being allocated and deallocated
each time step by the integrator, plus the GPU reduction is only done partially
on the GPU.

I removed the CPU time step calculation in the first time step and replaced it
with the GPU calculation. I also removed the global time step arrays and
replaced them with arrays that are allocated and deallocated each time step
within the time step function. My next step is to write a GPU reduction function
so that the entire reduction can be done on the GPU rather than on both GPU and
CPU. I'm basing my reduction code off of [this
presentation](https://developer.download.nvidia.com/assets/cuda/files/reduction.pdf)
by Mark Harris at NVIDIA and [this blog
post](http://seanbone.ch/cuda-efficient-parallel-reduction/) by Sean Bone, which
is basically just an easier to read version of Mark Harris' slides.

## Testing Ongoing Development

- Implemented a basic, single rank, particle test now that the [duplicate ID
  issue](https://github.com/cholla-hydro/cholla/issues/98) has been resolved
- Fixed an issue where the systemTestRunner class assumed that a fiducial HDF5
  file was present even if the user indicated otherwise
- Added an assertion in the systemTestRunner class to make sure cholla launched
  properly

## Other

- Prepped for and led a git workshop
