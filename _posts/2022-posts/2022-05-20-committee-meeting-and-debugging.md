---
title:      Committee Meeting & Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2022-05-20 16:31:59 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Committee Meeting

I had my second committee meeting this week and it went well. The committee had
good suggestions on what to do next and so I'm going to work on that.

## MHD Debugging

I started digging into bugs in MHD in Cholla. Starting with a simulation using
constant values and zero magnetic field I found an issue in the Y edges of the Z
magnetic field. I traced that issue back to the PCM (Piecewise Constant Method)
reconstruction and did find some off-by-one bugs there but fixing them didn't
fix the issue so I went back to the drawing board. Currently I think I'm getting
some weird synchronization issues between CPU and GPU because checking the CT
electric fields on GPU gives different answers than copying to CPU and printing
them. I'm also getting unexpected early termination when using the exit
function. The HLLD solver might be at fault but if so I would expect the issues
to show when I print the CT fields out on the half time step update but they're
only showing errors on the full time step update. More digging into this is
required.
