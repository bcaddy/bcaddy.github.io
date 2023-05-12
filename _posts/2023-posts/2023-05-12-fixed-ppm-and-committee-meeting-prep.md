---
title:      Fixed PPM & Committee Meeting Prep                 # Title
author:     Robert Caddy               # Author Name
date:       2023-05-12 16:14:13 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PPMC, Reconstruction, Scaling Tests, Frontier] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## PPM Debugging

I think I found the issue in PPM that I was having last week. One of the variables in the characteristic projection was defaulting to zero instead of 1. This also looks like it might be a bug in Athena++ so I opened a PR there, [PR #497](https://github.com/PrincetonUniversity/athena/pull/497).

## Committee Meeting Prep and Plots

My advisor needed some plots for a talk and I needed them for my committee meeting next week so that's what I spent most of the week doing; you can find them below. I also prepped my committee meeting presentation except the "Science Goals" section which I will do next. These plots revealed that the accuracy fast magnetosonic wave is only scaling at first order with resolution, not second like it should since we're using a second order method. I'm not sure why that is yet and haven't had much luck narrowing down the issue.

![cells_per_second](/assets/img/2023-post-assets/05-May/2023-05-05-cells_per_second.png)
![ms_per_gpu](/assets/img/2023-post-assets/05-May/2023-05-05-ms_per_gpu.png)

![contact wave convergence](/assets/img/2023-post-assets/05-May/2023-05-12-mhd_contact_wave_linear_convergence.pdf)
![alfven wave convergence](/assets/img/2023-post-assets/05-May/2023-05-12-alfven_wave_linear_convergence.pdf)
![slow wave convergence](/assets/img/2023-post-assets/05-May/2023-05-12-slow_magnetosonic_linear_convergence.pdf)
![fast wave convergence](/assets/img/2023-post-assets/05-May/2023-05-12-fast_magnetosonic_linear_convergence.pdf)

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-brio-and-wu.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-density-contour.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-density.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-Energy.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-momentum_x.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-momentum_y.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-magnetic_x.mp4">
</video>

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/05-May/2023-05-12-OTV-magnetic_y.mp4">
</video>