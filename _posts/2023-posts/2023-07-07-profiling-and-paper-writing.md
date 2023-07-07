---
title:      Profiling & Paper Writing                 # Title
author:     Robert Caddy               # Author Name
date:       2023-07-07 16:28:04 -0400   # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Writing, Profiling, Dotfiles]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## Cholla Profiling

I wanted to start profiling Cholla so I got HPCToolkit and Omniperf running with
Cholla. HPCToolkit showed which kernels are eating up time and Omniperf should
help me optimize those kernels. I've not been able to get the GUI working for
Omniperf though; the documentation is confusing and not quite complete. I'll
work on that more next week with help from the OLCF.

To make sure the group knows how to run these things and have a knowledge base
for it I started a GitHub discussion on the topic
[here](https://github.com/cholla-hydro/cholla/discussions/307).

## MHD Paper

I finished the Orszag-Tang vortex plot and the circularly polarized Alfvén wave
convergence plots. In addition I refactored the plotting scripts to share a lot
more functions. They're much simplier now and it's faster to write new plotting
scripts.

## Dotfiles

Remove unused code and fix some issues setting the prompt properly. The prompt
was set in a different places for each machine and several of them had small
bugs. Now you set the colors you want and that is plugged into a single place
where `PS1` is set.

## Other

- Review [PR #299](https://github.com/cholla-hydro/cholla/pull/299)
- Hack day, [PR #309](https://github.com/cholla-hydro/cholla/pull/309)
- Update website to v6.1
