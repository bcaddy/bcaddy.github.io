---
title:      Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2022-05-27 16:31:59 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

With some help I found a major bug. Several indices had a `*` instead of `+`
when calculating the shift based on the number of passive scalars. After fixing
that the constant, no magnetic fields, case will run without producing a
non-zero magnetic divergence. The time step does slowly diverge to zero due to
some error in (I think) the density/energy interface states. Values of zero are
being passed to the HLLD solver which is corrrecting them to 1E-20 as expected
but those fields shouldn't be zero in the first place.
