---
title:      Advecting Field Loop                 # Title
author:     Robert Caddy               # Author Name
date:       2023-03-17 17:06:46 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Tests, MHD Tests]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Angled Linear Waves

After a lot more work this week I discovered that my implementation of linear waves from the vector potential did not in fact pass with grid aligned or angled waves. Since this is not a required test, and will likely take a lot of work to debug the initial conditions with minimal benefit, I've decided to set it aside for now. The issue is definitely in the ICs not the code itself.

## Advecting Field Loop

I added the initial conditions for an advection field loop as described in [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract). After some work I've verified that the code is producing the correct result and now I just need to write the regression test for it, probably with a check that the magnetic pressure is conserved as it should be in this test.

This test did highlight some issues with the MHD I/O routines so I will sort that out next week.

## Other

I fixed [Issue #266](https://github.com/cholla-hydro/cholla/issues/266) with [PR #269](https://github.com/cholla-hydro/cholla/pull/269). It turns out the C code I removed a few weeks ago had unintended side effects that were required. I refactored the code to make it clearer what it was actually doing and added it to the appropriate C++ file so we still have no C code.
