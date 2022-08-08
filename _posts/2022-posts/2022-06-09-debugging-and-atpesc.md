---
title:      Debugging & ATPESC                 # Title
author:     Robert Caddy               # Author Name
date:       2022-06-09 11:37:37 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Debugging, Summer School]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

I found and fixed the last hydro but in my MHD code this week. There was a
`yid-1` when it should have been `zid-1` in the PCM reconstruction function.
After that fix, and thorough testing, hydro problems now work fine when run with
the MHD algorithms. There's still bug(s) in the magnetic field part but since
it's only when magnetic fields are on and the HLLD solver has been fully tested
the bug is likely in the CT electric fields kernel, which isn't a suprise due to
its complexity. I'm working on tracking that bug down.

I also modified the 3D constant test case to include magnetic fields and tested
that it's actually constant using Athena++. The MHD constant test case is the
same as the hydro one but with \\( \vec{B} = \left[ 1e-5, 2e-5, 3e-5 \right] \\).

I found a second bug that now makes the constant MHD case work. The [VL+CT
Algorithm]({% post_url guides/2021-01-06-VL+CT-Algorithm%}) requires at
least 2 fully working ghost cells that have magnetic fields on both sides. That
requires that we have at least 3 ghost cells in Cholla so that both edges have
two fully working ghost cells. I added some logic to double check and set that
and now the constant MHD case works. Compared to Athena++ it computes exactly
the same time step and runs in exactly the same number of time steps. I then
tested the Brio & Wu shock tube and that isn't working yet. However, it looks
like that is mostly due to a large oscillation in the \\( B_z \\) field so
hopefully that is a simple sign error that I need to track down.

## Argonne Training Program for Extreme Scale Computing (ATPESC)

I found out this week that I got into the Argonne Training Program for Extreme
Scale Computing (ATPESC) which is a summer school for HPC that is in August. I
spent some time this week getting paperwork sorted out for that.
