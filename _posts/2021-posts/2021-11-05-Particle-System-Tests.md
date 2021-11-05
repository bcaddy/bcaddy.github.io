---
title:      Particle System Tests      # Title
author:     Robert Caddy               # Author Name
date:       2021-11-05 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Testing, Particles, GitHub Actions] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Particle System Tests
This week I planned to add support for particles to the system test function and
I got most of the way there before running into some snags. I was initially
using disk initial conditions to test with, however that only has particles in
it, no hydro fields, so I didn't realize that when run with both hydro and
particles Cholla produces two output files per time step instead of just one.
I'm working on adding that support, and it should be done, but I ran into some
issues with how the particles part of Cholla generates random numbers.

# Random Number Generator Hell
Cholla generates some particle properties randomly and this of course makes it
non-deterministic and almost impossible to test. To enable us to perform
deterministic tests I set up a new input parameter to cholla, `prng_seed`, which
sets the seed for the pseudo random number generator (PRNG). While I was doing
this I improved the quality of the default random seed generation. Previously it
just used `std::random_device` but `std::random_device` isn't required to be
actually random by the C++ standard and so isn't a reliable source of
randomness, plus it only provides 32 bits of randomness and our generator,
`std::mt19937_64`, can take up to 64 bits. I instead now convert the result of
`std::random_device` to a string, then concatenate the string version of the MPI
process ID and the `std::chrono::high_resolution_clock` time, then use
`std::hash` to hash the resultant string. This should provide a robust source of
64 bit randomness across machines, time, and for every MPI rank, even if
`std::random_device` just returns a constant or
`std::chrono::high_resolution_clock` returns the same time for multiple process.

At the last minute this week I discovered that there are two different pseudo
random number generators used in Cholla. I've asked the people involved if I can
combine them into one but I haven't heard back from everyone yet.

# GitHub Actions
I noticed that the GitHub Actions badge in Cholla isn't showing the proper
status. I couldn't figure out why so I contacted GitHub support but haven't head
back. I think the issue is that all the current builds are triggered by PRs from
forks of Cholla. If that's the issue, or if I don't hear back from GitHub
support, I'll just set up a weekly or nightly build.

# Other
- Found a bug in how particle IDs were assigned that resulted in duplication
- Wrote a python script to concatenate the particle and field data sets to
  facilitate making fiducial data files.
- Created a particle based system test
- Refactored system tests as parameterized tests and added support for them in
  `SystemTestRunner`
