---
title:      GPU Reduction & MHD Plotting     # Title
author:     Robert Caddy               # Author Name
date:       2022-04-22 14:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Reductions, matplotlib, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## GPU Resident Reduction

I finished the GPU resident reduction and submitted a
[pull request](https://github.com/cholla-hydro/cholla/pull/147) for it. The
issue with slightly different results from last week turned out to be because I
had forgotten to set the value in global memory before comparing against it
using atomics. As such it was actually always using the highest crossing time in
the history of the simulation, not the highest in this time step. Assigning the
global memory value to `-DBL_MAX` fixed this problem and I added an optional
argument to set it to whatever value the user requires.

# MHD Plotting

I adapted my [previous MHD plotting
code](https://github.com/bcaddy/hydro-sandbox/blob/main/visualization/mhd-plotter.py)
to work with Cholla. Previously this code took an extremely long time (5-10
minutes) to produce the roughly 200 frames required for a ~10 second long
animation. This is too long for rapid testing and so after modifying the code to
work with Cholla I set about optimizing it. There were three things that made
large differences from the initial runtime of ~500s:

1. Not running the code in VS Code. Running the code in its own terminal reduced
   the time to around 200s, a 2.5x speedup.
2. Removing
   [`matplotlib.pyplot.minorticks_on()`](https://matplotlib.org/3.5.0/api/_as_gen/matplotlib.pyplot.minorticks_on.html).
   Disabling minor ticks roughly doubled performance getting me down to ~97s, a 2.06x speedup.
3. Enabling blitting. I had to refactor the code significantly to enable
   blitting; unfortunately if you set `blit=True` and it can't do the blitting
   it fails silently rather than raise a warning. Refactoring to enable it did
   result in much cleaner code and I learned about named tuples and partial
   functions while I was at it which was very helpful. Reduced execution time
   down to ~85s, a 1.14x speedup.

At this point the animations are generated quickly enough that I'm not going to
bother trying more optimization, especially because I believe the performace
issues are largely withing matplotlib itself. Just generating the frames and
saving them takes a similar amount of time to making the entire animation so the
slowdown is primarily in simply generating each frame. While matplotlib is very
useful it appears to have fairly poor performance if I can only get 2.5 frames
per second out of it. Reducing the number of subplots does help commensurately,
however, only nine simple plots should run much faster than 2.5 FPS on modern
hardware.

## MHD Debugging

Now that I have the tools I've started debugging my MHD code. As of now it's not
updating the grid and the issue persists when running with MHD or a pure hydro
problem using the MHD solver. Figuring that out is going to be my first task for
next week. It also appears that when the y and z dimension is set to be low the
time step is always computed to be zero. I've tried a 32x32x32, 512x3x3, and
512x512x512 simulations of the Brio & Wu shock tube and the first two both had
zero time steps where the last had a time step of about 1E-4. This may or may
not be related to the issue of the grid not updating so I'm going to focus on
that issue first.

## Other

- Read [Beck et al. 1996](https://www.annualreviews.org/doi/10.1146/annurev.astro.34.1.155)
- Read [Gent et al. 2021](https://iopscience.iop.org/article/10.3847/2041-8213/abed59)
