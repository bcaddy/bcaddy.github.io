---
title:      CT Slope Rewrite & MHD Linear Waves                # Title
author:     Robert Caddy               # Author Name
date:       2022-07-08 15:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Constrained Transport Slopes

I figured out how to implement the CT slopes function this week. I was thinking
about it too hard, instead of passing information like whether or not we're
upwinding, slope side, etc. I just passed in which indices should have 1
subtracted from them to get the right value. It took awhile to implement but it
not reproduces what I had before, complete with identical bugs

## MHD Linear Waves

To help debug I implemented initial conditions for MHD linear waves. This
required refactoring parts of the `Grid3D::Sound_Wave` function to use magnetic
fields and to use a wave's right eigenvector to set the wave. All of that went
reasonably well and is now working.

After getting that working I started with the contact wave. It appears to work
perfectly for MHD, though there is some noise in the velocities at the level of
 \\( \sim10^{-15} \\). The same noise appears when running with the hydro build,
though there it's only in the x velocity, not all three velocities. The other 3
MHD waves all give significant divergences though after a single time step. The
issue appears to be on the edges, possibly only on the X magnetic field on the Y
and Z edges since those location are giving most of the non-zero divergences;
I'll look into this next week.
