---
title:      Boundaries & Shock Tubes                 # Title
author:     Robert Caddy               # Author Name
date:       2022-12-05 11:25:04 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Shock Tubes, Boundary Conditions]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---
## MHD Boundary Conditions (BC)

I fixed several bugs in the MHD boundary conditions and so transmissive and
periodic boundaries appear to be working now. This also allowed me to remove
almost all the MHD specific code in the boundaries so the code is much simplier.

## MHD Debugging

After the BC fixes the MHD Einfeldt Strong Rarefaction is working so I've moved
on to shock tubes. The shock tubes I've been using (Brio & Wu, Dai & Woodward,
and Ryu & Jones 4d) have very complex wave structures and are hard to visually
interpret when looking for bugs. I found some simplier shock tubes and have
started debugging with them. The tubes on question are Ryu & Jones 1A and 2A and
are detailed [here]({% post_url guides/2021-11-19-MHD-Riemann-Problems %}). RJ1A
has revealed an issue in the Z magnetic field at the initial discontinuity but I
haven't found the root cause yet.

## Other

- APS MAS Meeting + poster presentation
