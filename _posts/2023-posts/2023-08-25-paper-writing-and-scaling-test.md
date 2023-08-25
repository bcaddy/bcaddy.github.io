---
title:      Paper Writing & Scaling Test                 # Title
author:     Robert Caddy               # Author Name
date:       2023-08-25 10:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Scaling Tests, Paper Writing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Methods Paper

This week I finished the first draft of the MHD methods paper and did some revisions. It's all coming together and I hope to submit in the next 4-8 weeks.

## `_ctSlope` Template and Test

I tried out making all the compile time literal arguments in the `_ctSlope` function into template arguments. Turns out the compiler was already doing that and it made no difference. I also added a test for that function in [PR #320](https://github.com/cholla-hydro/cholla/pull/320).

## Better Scaling Tests

I found a few issues with how I was do scaling tests, namely using the wrong timer and outputting data. After fixing those issues in my various scripts I started another round of scaling tests for both PLMC and PPMC; I'm still waiting for them to get through the queue. The changes I made for this are in [PR #321](https://github.com/cholla-hydro/cholla/pull/321).

After some more investigation it does appear that the lowered performance in large runs is due to a small number of poorly performing GPUs. The average timing for the integrator is almost identical to the minimum time but much less than the maximum, indicative of a small number of slow GPUs.

## Other

- Rebase various branches and PRs
- Get [PR #309](https://github.com/cholla-hydro/cholla/pull/309) ready for review
