---
title:      Paper Writing & Debugging PPMC Tests                 # Title
author:     Robert Caddy               # Author Name
date:       2023-06-23 16:14:42 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Writing, Debugging, PPMC]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## Paper Writing

This week I finished the shock tube figures, or at least the minimum viable product version of them. After that I spent a day writing up the sections on the linear wave convergence and Riemann problem tests.

## Concatenation Script

The file concatenation script we had required manual changes to work and I want to use it in some of my paper scripts so I added a CLI and python interface to it [PR #303](https://github.com/cholla-hydro/cholla/pull/303).

## PR Rebasing and Testing

This week my [PLMC PR](https://github.com/cholla-hydro/cholla/pull/288) was merged into dev so I needed to rebase my last [clang-tidy PR](https://github.com/cholla-hydro/cholla/pull/293) and my [PPMC PR](https://github.com/cholla-hydro/cholla/pull/300). This process required some changes for the clang-tidy checks that were enabled and revealed some issues with PPMC related tests. Several of the tests for PPMC components or things that depend on it had subtle bugs that were only present when I switched systems. Those are all fixed now and the clang-tidy PR is merged and the PPMC one should be in soon. I also wrote a test for checking the linear wave convergence rate but I haven't submitted a PR for that.
