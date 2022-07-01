---
title:      CT Slope Rewrite                 # Title
author:     Robert Caddy               # Author Name
date:       2022-07-01 16:41:38 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Constrained Transport Slopes

I'm pretty sure there's a bug somewhere in my calculations for the slopes used
to calculate the electric fields. I started trying to debug this and quickly
realized that my current "unrolled" implementation of the slope calculations is
just too unwieldy and difficult to debug. I started implementing a device
function to compute the slopes, going slope by slope and tweaking it to work
with each slope. I realized after working on this for awhile that it wasn't a
good way to go about it and my implementation was quickly becoming hacky. So
next week I'm going to work on it from first principles and hopefully that will
work better.

## Other

- Presented on my attending the International High Performance Computing Summer
  School
