---
title:      Orszag-Tang Vortex                 # Title
author:     Robert Caddy               # Author Name
date:       2025-03-25 13:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Orszag-Tang Vortex, MHD, Simulations]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Orszag-Tang Vortex Simulation

Below are videos of the Orszag-Tang Vortex simulation I ran with [Cholla](https://github.com/cholla-hydro/cholla) in late 2023. I ran the problem with the initial conditions detailed in [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract) and at 19,278 voxels on a side; the maximum size that could be run in 3D on Frontier. The thickness was only a handful of voxels since every Z slice in this problem is identical and I didn't want to waste a lot of computing power. As it stands, this simulation took about 12 hours to run on 25 GPUs and produced about 36TB of raw data. Nearly all the execution time was spent in I/O since I needed to output at a very high cadence to make videos like the ones below. The reduced data required for these videos is about 6TB and took ~750 CPU hours to animate.

Each video goes through the entire simulation time from initial to final state then slowly zoom in until you can see individual voxels, a comparison to indicate scale is at the end.

## Density

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-d_xy.mp4">
</video>

## X Component of the Momentum

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-mx_xy.mp4">
</video>

## Y Component of the Momentum

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-my_xy.mp4">
</video>

## Energy

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-E_xy.mp4">
</video>

## X Component of the Magnetic Field

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-magnetic_x_xy.mp4">
</video>

## Y Component of the Magnetic Field

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2025-post-assets/2025-03-25-magnetic_y_xy.mp4">
</video>

## Zoom Comparison

The image below shows the region covered by the final, most zoomed in, state of the visualization and has the voxels outlined. Note that there is a box to indicate the area of the zoomed image in the full image but that it is smaller than a single pixel.

![show voxels](/assets/img/2025-post-assets/2025-03-25-show-voxels.png)
