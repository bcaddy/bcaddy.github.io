---
title:      MHD Debugging & Compute Sanitizer                 # Title
author:     Robert Caddy               # Author Name
date:       2023-02-10 16:47:23 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Debugging, MHD, HLLD, Boundary Conditions, Compute Sanitizer]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

It looks like the weird edge effect issues I was seeing might just be
oscillations due to the higher order Van Leer method as it's present in hydro
builds as well.

It turns out that the issues I was having with the Sod shock tube under MHD were
actually fixed in [PR #238](https://github.com/cholla-hydro/cholla/pull/238)
when I fixed the missing boundary conditions in the parameters file, I just
forgot to update the data to do a proper comparison. This has been fixed as of
[PR #249](https://github.com/cholla-hydro/cholla/pull/249).

I've been working now on debugging the Ryu & Jones 1a shock tube ([details
here]({% post_url guides/2021-11-19-MHD-Riemann-Problems %}) as it has a
visually simple structure with no sharp spikes. It's still throwing a non-zero
divergence errors after the first time step. I think I've narrowed this issue
(or at least one issue) down to something weird going on at the X boundary
conditions, though I'm not sure yet what exactly is causing the issue.

## NVIDIA Compute Sanitizer

I raised [Issue #247](https://github.com/cholla-hydro/cholla/issues/247) on how
we're using the CUDA compute sanitizer and if we should add it to the automated
tests. I spent some time experimenting with it and believe that we can eliminate
the uninitialized memory warnings by clever changes to our thread guards. That
might also let us reduce GPU memory usage if we do some clever indexing.

## Other

- Finalize [PR #245](https://github.com/cholla-hydro/cholla/pull/245)
