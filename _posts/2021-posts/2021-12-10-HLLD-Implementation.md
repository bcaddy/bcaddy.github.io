---
title:      HLLD Implementation        # Title
author:     Robert Caddy               # Author Name
date:       2021-12-10 16:00:00 -0400  # Date
categories: [MHD, HLLD]     # Catagories, no more than 2
tags:       [HLLD, Athena++] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## HLLD Prep

I found the issue with \\( \gamma \\) from last week. It turns out I had made a
mistake when extracting Athena's HLLD solver and had turned their \\( \gamma - 1
\\) variable into just \\( \gamma \\); it's fixed now. After that I implemented
the rest of the HLLD tests and hammered out some bugs.

My next step was to write some utility functions for MHD. I wrote functions for
computing the energy, gas pressure, total MHD pressure, Alfvên wave speed, and
the fast & slow magnetosonic wave speeds along with tests for all those
functions. They were implemented as `__host__ __device__` functions so they can
be used on either the GPU or CPU

## HLLD Implementation

I started on writing the HLLD solver this week. So far I've finished the setup
and gathering of conserved and primitive variables section, the section for
computing wave speeds, and calculating then returning the non-star state flux.
As it stands it computes the left state flux, checks if thats the correct state
and if it is then the solver assigns those flux values to the flux array and
returns, if not then it repeats the process with the right state. My plan for
next week is to implement the star and double star states.

## Other

- Started my application to the 2022 Internation HPC Summer School

## Useful links

Original HLLD paper: [Miyoshi & Kusano 2005](https://www.sciencedirect.com/science/article/pii/S0021999105001142?via%3Dihub)

Blog post on the HLLD Algorithm: [HLLD Algorithm]({% post_url 2020-posts/2020-10-23-HLLD-Algorithm%})
