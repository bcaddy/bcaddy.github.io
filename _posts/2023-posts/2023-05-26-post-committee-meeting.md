---
title:      Post Committee Meeting                 # Title
author:     Robert Caddy               # Author Name
date:       2023-05-26 15:14:08 -0400  # Date
categories: [MHD, Job Hunting]     # Catagories, no more than 2
tags:       [MHD, Bug Fixing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Committee Meeting

In the last two weeks I've had my committee meeting and been working on a variety of tasks. My committee meeting went and and per my committee's suggestion I've started the early stages of job hunting, mostly looking for talks to give and conferences to attend at this point and playing around on leetcode. I've got a couple of each lined up so far an am continuing to work on that.

## Piecewise Parabolic Method

PPM is done, cleaned up, and the pull request is up ([PR #300](https://github.com/cholla-hydro/cholla/pull/300)).

## Fast Wave Scaling

I fixed the issue with the fast wave scaling from my last post. It turns out that I was initializing the energy slightly wrong and that let to the waves "breathing" in amplitude, it just happened to be most noticeable in the fast wave. The new method, which is based of of Athena++, doesn't produce that issue but when I instantiate the magnetic field from the vector potential rather than directly I get small oscillations. I'm working on fixing that next week.

## Code Paper Draft

I drafted another section of the code paper this week and got the git repo/overleaf/etc all set up for it.

## Other

- Presented on data structures at the [departmental python bootcamp](https://astropgh.github.io/python-boot-camp-2023/)
- Presented on [*The effect of magnetic fields on properties of the circumgalactic medium* by van de Voort et al.](https://ui.adsabs.harvard.edu/abs/2021MNRAS.501.4888V/abstract)
