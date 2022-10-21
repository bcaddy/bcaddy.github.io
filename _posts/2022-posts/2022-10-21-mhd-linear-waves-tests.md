---
title:      MHD Linear Waves Tests     # Title
author:     Robert Caddy               # Author Name
date:       2022-10-21 16:21:30 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Linear Waves

I need to add MHD linear wave tests and initial conditions at some point so I
decided to do it this week to help with debugging. I already added support for
generalized linear wave initial conditions but the support in the system testing
class was lacking. I added a new method for running the waves that computes the
L1 error comparing the final and initial conditions. I also added linear wave
tests for the fast, slow, Alfven, and contact waves.

## AMD Software vs. Hardware Atomics

Compared hardware vs software performance atomics on AMD MI250X in Cholla.
There's no difference for us, probably since the kernel is bandwidth bound with
relatively few atomics.

In the process of testing this I also modified our atomics to work with AMD and found an issue with the ROCm occupancy API, the issue is detailed in [ROCm issue \#1842](https://github.com/RadeonOpenCompute/ROCm/issues/1842)

## Alfven Wave Debugging

Now that I've got linear waves set up I started debugging the Alfven wave. I've
confirmed that there are issues by the end of the first timestep update but I
haven't exactly figured out where yet. Possibly in the HLLD solver as the
interface states look ok. Next week I plan on setting up pure hydro linear waves
to make sure they pass when run under MHD.

## Other

- Attended OLCF User Meeting
