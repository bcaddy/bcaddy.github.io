---
title:      MHD Piecewise Parabolic Reconstruction                # Title
author:     Robert Caddy               # Author Name
date:       2023-04-14 09:49:16 -0400  # Date
categories: [MHD, Reconstruction]     # Catagories, no more than 2
tags:       [PLMC, Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Piecewise Parabolic Reconstruction (PPMC)

This week I refactored PPMC and added MHD support to it. It was mostly using functions I wrote for PLMC with a couple small additions. Despite this simplicity there's some weird oscillations in the shock tube solutions and the linear waves sort of "breathe" in amplitude. I'm not sure of the exact cause and haven't yet had much luck finding it. All the projecting to and from characteristic variables seems well behaved and the new code that differs between hydro and MHD is extremely simple and appears correct.

Here's an example of the issue. You can see the odd oscillations especially in the velocity.

<video muted autoplay controls style="max-width:100%; height:auto">
    <source type="video/mp4" src="/assets/img/2023-post-assets/2023-04-21-brio-and-wu-with-oscillations.mp4">
</video>