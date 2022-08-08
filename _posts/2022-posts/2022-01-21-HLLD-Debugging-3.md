---
title:      HLLD Debugging 3       # Title
author:     Robert Caddy               # Author Name
date:       2022-01-21 16:00:00 -0400  # Date
categories: [MHD, HLLD]     # Catagories, no more than 2
tags:       [Debugging, HLLD, Testing, Continuous Integration] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## CUDA Debugger

I spent most of a day playing with the `cuda-gdb` debugger for CUDA code and
it's integration with VS Code. Currently it's got some pretty significant
limitations, it can't show the contents of STL containers in host code or the
values of variables in `__device__` functions plus it looks like the VS Code
integration extension is dead.

## HLLD Debugging

The HLLD solver is DONE! All the tests pass, dual energy and passive scalars are
supported and tested! I had to hammer out a handful of bugs, several of which
were in the tests not the solver, and I completely redid how the solver handles
dual energy and passive scalars now that I understand how they work better. I
might have also found a bug in Enzo so I raised an issue on their github page.
Next week I want to write some quick unit tests for the individual functions
that the HLLD solver calls but then I'm off to work on the integrator.

## Other

- Read [Minoshima & Miyoshi 2021](https://www.sciencedirect.com/science/article/pii/S0021999121005349)
  which is about a new, low dissipation, HLLD solver

## Useful links

Original HLLD paper: [Miyoshi & Kusano 2005](https://www.sciencedirect.com/science/article/pii/S0021999105001142?via%3Dihub)

Blog post on the HLLD Algorithm: [HLLD Algorithm]({% post_url guides/2020-10-23-HLLD-Algorithm%})
