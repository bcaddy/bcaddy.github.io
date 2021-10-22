---
title:      Automated Testing Groundwork      # Title
author:     Robert Caddy               # Author Name
date:       2021-10-22 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [GitHub Actions, Automated Testing, Continuous Integration (CI)] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Automated Testing

I finally got GoogleTest to build and link properly on all the different
machines after running down some module and `LD_LIBRARY_PATH` issues on CRC
systems. So I started looking into full automated testing. GitHub Actions with a
self hosted runner on a public repo is a security nightmare I discovered. After
discussing it with the CRC for a bit they said that they're looking into adding
CI runners as a service they offer so I will wait until I hear back from them.
In the meantime I set up a GitHub Actions matrix job that builds Cholla with all
the different make types and with both HIP and CUDA. As part of this I
refactored the script that runs tests to play more nicely with a CI pipeline.