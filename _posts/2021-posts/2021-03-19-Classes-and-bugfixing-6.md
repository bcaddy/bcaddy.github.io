---
title:      Classes and Bugfixing 6    # Title
author:     Robert Caddy               # Author Name
date:       2021-03-19 16:00:00 -0400  # Date
categories: [MHD, Coursework]          # Catagories, no more than 2
tags:       [Constrained Transport, Astronomical Techniques, Bugs]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                       # Does this post contain math?
# image:      /assets/img/...            # Header image path
---

# Astronomical Techniques

More discussion of error propagation. Started planning class projects and
discussed hypothesis testing.

# Numerical MHD

Still working on bug hunting. I tested a bunch of different things and finally
found the bug that was causing the \\( B_x \\) field to update. There was a
copy/paste error in the CT field calculations and I was using the wrong velocity
for one of the upwinding steps. My next step is going to be trying out simple
waves. I'll be using the wave tests from ATHENA++ which are detailed in
[Gardiner & Stone 2005](https://arxiv.org/abs/astro-ph/0501557). The discussion
of linear waves has been moved to [MHD Test Problems]({% post_url
guides/2022-10-17-mhd-test-problems %})

# Other

- Attended the [XSEDE webinar on profiling tools](https://portal.xsede.org/user-news/-/news/item/12762)
