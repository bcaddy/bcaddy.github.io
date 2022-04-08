---
title:      Finalizing VL+CT Integrator   # Title
author:     Robert Caddy               # Author Name
date:       2022-04-08 16:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Reductions]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Constrained Transport Electric Fields

I fixed some bugs in the CT electric fields kernel, added documentation to
everything I've added over the last few weeks, and wrote tests for the CT
electric fields kernel. While writing those tests I discovered an issue with
which flags are used to compile the tests.

## Tests Compilation Issue

The tests were being compiled with the `-Ofast` flag which in turn uses the
`--ffinite-math-only`. This flag caused all calls to `std::isnan` and
`std::isinf` to be undefined. In practice they always returned false which
effectively broke the handling of `Nans` and `infs` in
`testingUtilities::ulpsDistanceDblwhich` in turn is call by all of our FP64
comparison utilities. This has been fixed by settting `BUILD = DEBUG` when
building the tests.

Also, I refactored the `testingUtilities::nearlyEqualDbl` function so that it
always returns proper values of of `absoluteDiff` and `ulpsDiff`. Before it
would only compute some of those values and then exit early if they were found
to be passing. This could cause `ulpsDiff` to be undefined when comparing small
numbers. Now both `absoluteDiff` and `ulpsDiff` are computed first and then the
results are checked. This is somewhat less efficient but will lead to more
correct and expected behavior. This issue has been resolved with
[PR #144](https://github.com/cholla-hydro/cholla/pull/144)

## VL+CT Integrator

I finished the Van Leer + Constrained Transport integrator. Currently it only
supports first order reconstruction of the conserved variables but with this
done I should be able to run a fully functional MHD simulation. I'll start on
fixing bugs once I get finish the kernel for tracking magnetic field divergence.

## Magnetic Field Divergence Tracking & GPU Reductions

While Constrained Transport should be entirely divergence free the numerical
approximations are not perfect and so we should regularly compute the divergence
and check that it hasn't risen above some negligible amount. The divergene is
calculated with this equation

$$
    \begin{aligned}
        \left( \nabla \cdot B \right)^{n}_{i,j,k} =
            \frac{B^{n}_{x,i+1/2,j,k} - B^{n}_{x,i-1/2,j,k}}{\delta x} \\
            + \frac{B^{n}_{y,i,j+1/2,k} - B^{n}_{y,i,j-1/2,k}}{\delta y} \\
            + \frac{B^{n}_{z,i,j,k+1/2} - B^{n}_{z,i,j,k-1/2}}{\delta z}.
    \end{aligned}
$$

This is easy to calculate however the real value we need is the maximum
divergence in the entire grid. MPI has a function for this and Cholla has a
suitable wrapper to use once we've reduced the local grid to a single value.
However, reducing the local grid to a single value isn't easy. Next week I'm
going to work on a parallel GPU reduction kernel/tools based off of [this NVIDIA
blog post](https://developer.nvidia.com/blog/faster-parallel-reductions-kepler/).
I should be able to write a couple of device functions that make it trivial to
do a parallel reduction either on its own or at the end of a transform-reduce
kernel.

## Other

- I added some utility functions for computing indices along with tests for those
  functions. [PR #143](https://github.com/cholla-hydro/cholla/pull/143)
- Finished [Beck 2015](https://ui.adsabs.harvard.edu/abs/2015A%26ARv..24....4B/abstract)
- Read [Morton et al. 2022](https://arxiv.org/abs/2204.01757)

## Links

- [VL+CT Algorithm]({% post_url 2021-posts/2021-01-06-VL+CT-Algorithm%})
- [HLLD Algorithm]({% post_url 2020-posts/2020-10-23-HLLD-Algorithm%})
