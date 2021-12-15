---
title:      HLLD Implementation 2       # Title
author:     Robert Caddy               # Author Name
date:       2021-12-15 13:00:00 -0400  # Date
categories: [MHD, HLLD]     # Catagories, no more than 2
tags:       [HLLD, Athena++] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---
## HLLD Implementation

After finishign the HLLD solver through the L/R states last week I spent this
week implementing the star and double star states. I used a similar pattern to
the L/R states. This first draft of the HLLD solver is rough. It's about 1000
lines, around half of which are just function definitions and calls. Each step
requires so many different variables that the functions have dozens of
arguments; this really bites into readability. I'm considering replacing a lot
of it with some structs, arrays, or file scope variables but I want to get it
tested and working first. Also, however I end up refactoring it I will need to
take performance into great consideration and profiling can only be done one I
have an HLLD solver that produces correct output.

I'm also not 100% sure about my implementation of passive scalars and dual
energy. That is something I will need to thoroughly test.

## Other

- Continued working on my application to the 2022 Internation HPC Summer School

## Useful links

Original HLLD paper: [Miyoshi & Kusano 2005](https://www.sciencedirect.com/science/article/pii/S0021999105001142?via%3Dihub)

Blog post on the HLLD Algorithm: [HLLD Algorithm]({% post_url 2020-posts/2020-10-23-HLLD-Algorithm%})
