---
title:      Reconstruction Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2024-01-12 16:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Reconstruction, Debugging]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Debugging Reconstructions

I spent most of the week debugging the issues that we've been having with the PLMC and PPMC reconstructors. I found the two bugs, the monotonization was missing from PLMC and the function for computing kinetic energy had a small bug. Both have been fixe in [PR #361](https://github.com/cholla-hydro/cholla/pull/361).

## Other

- submit dissertation
