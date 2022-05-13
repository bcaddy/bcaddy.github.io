---
title:      Committee Meeting Prep & MHD Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2022-05-13 13:53:31 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## Second Committee Meeting Prep

I made the presentation, practiced it with observers, and iterated it from there.\

## MHD Debugging

I decided to start debugging with just a constant set of initial conditions with
zero magnetic field. So far this has shown that there's an issue on the Y faces
of the Z magnetic field. I'm working on tracing that back and currently it looks
like there's some issues with the fluxes or the grid after the half time-step
update.

## Reading

- [Pakmor et al. 2021](https://www.aanda.org/10.1051/0004-6361/202037835)
