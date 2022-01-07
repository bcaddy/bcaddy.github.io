---
title:      HLLD Debugging       # Title
author:     Robert Caddy               # Author Name
date:       2022-01-07 15:00:00 -0400  # Date
categories: [MHD, HLLD]     # Catagories, no more than 2
tags:       [Debugging, HLLD] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## HLLD Debugging

This week I was mostly working on debugging the HLLD solver I wrote for Cholla.
I found a handful of bugs in the \\( L/R \\) and \\( L^\* / R^\* \\) states and
both of those states appear to be bug free now; they're passing all their tests
anyway. The double star state still has bugs but preliminarily it looks like
there are just bugs in a couple values so they will hopefully be easy to find
next week.

## Dual Energy

I ran into some issues due to not fully understanding how dual energy works. I
believe I've resolved those issues. However, for now I've disabled dual energy
by default in MHD builds and will return to it once I have the non-dual energy
HLLD solver finished.
[Bryan et al. 2014](https://ui.adsabs.harvard.edu/abs/2014ApJS..211...19B/abstract)
(the ENZO paper) has details on how and why dual energy is implemented.

## Other

- Updated this website to Chirpy v5.0.1
- Found a tool ([gtest2html](https://gitlab.uni-koblenz.de/agrt/gtest2html))to
  convert GoogleTest XML reports to HTML. It's basic but is good enough for now
- Minor updates to resume and CV

## Useful links

Original HLLD paper: [Miyoshi & Kusano 2005](https://www.sciencedirect.com/science/article/pii/S0021999105001142?via%3Dihub)

Blog post on the HLLD Algorithm: [HLLD Algorithm]({% post_url 2020-posts/2020-10-23-HLLD-Algorithm%})
