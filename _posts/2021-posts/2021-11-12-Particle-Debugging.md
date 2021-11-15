---
title:      Particle Debugging         # Title
author:     Robert Caddy               # Author Name
date:       2021-11-12 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Testing, Particles, GitHub Actions, PRNG] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Particle System Tests
After some more work I discovered that particle IDs are only supported on CPUs
currently. I'm waiting for the GPU implementation which should be done next
week.

In the meantime, Orlando showed me the [`data`](https://www.cplusplus.com/reference/vector/vector/data/) method of `std::vector` and so I used that to refactor my testing code to avoid the usage of C-style arrays. Now instead I use vectors everywhere since they're easier to work with and simplify a lot of the logic, namely I no longer have to carry a length variable around with an array.

I've also been testing it with particle only data and found some bugs that I've been hunting. I found one where it appears that my sorting method can be reset in some strange way so next week I'm going to refactor that to use static const variables instead of a private member variable.

Documentation for particle system tests is now written and posted on the Cholla wiki.


# PRNG (Pseudo Random Number Generator)
I refactored my PRNG from last week to work as a header only class and set it up
so that all the random numbers used in Cholla now use that PRNG.


# Other
- A bug in GCC 10.3 showed up in our automated builds so I changed the GCC
  version to 9
- Looked into why the readme badge isn't reporting correct results. GitHub help
  is working on the issue and in the meantime I'm just going to manually run a
  build every Monday morning, I wrote a bash function to make that easy.
- Read parts of the [decadal survey](https://www.nationalacademies.org/our-work/decadal-survey-on-astronomy-and-astrophysics-2020-astro2020)