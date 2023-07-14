---
title:      Paper Writing & PRs                 # Title
author:     Robert Caddy               # Author Name
date:       2023-07-14 16:42:59 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Writing, Profiling, clang-tidy]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---
## PPMC PR

After cleaning up a few things based on the review this PR ([#300](https://github.com/cholla-hydro/cholla/pull/300)) is merged!

## Hack Session

I enabled a handful of checks, including some of the naming checks, in [PR #309](https://github.com/cholla-hydro/cholla/pull/309). With Helena's help this led to a bit of a rabbit hole where I discovered that our `HeaderFilterRegex` for clang-tidy was wrong and was excluding some of our headers and not just system+library headers. This in turn led me to discovering that the cluster that runs our automated testing doesn't have support for OpenMP on their clang installation. They've been very helpful and that should be fixed soon.

## Orszag-Tang Vortex

I found a small bug in the initial conditions for the Orszag-Tang vortex and fixed it in [PR #311](https://github.com/cholla-hydro/cholla/pull/311).

## Profiling

After some more digging I discovered that the Grafana GUI for Omniperf is currently broken, or at least the docker container I need for it is, and OLCF doesn't support the built in GUI. CLI interface is the only option at the moment.

## Paper Writing

The advecting field loop plots are done. I've also added a first draft for the text for the advecting field loop, circularly polarized Alfvén wave, MHD blast wave, and Orszag-Tang vortex.
