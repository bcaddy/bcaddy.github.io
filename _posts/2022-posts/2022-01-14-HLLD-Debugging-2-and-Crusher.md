---
title:      HLLD Debugging 2 and Crusher       # Title
author:     Robert Caddy               # Author Name
date:       2022-01-14 15:00:00 -0400  # Date
categories: [MHD, HLLD]     # Catagories, no more than 2
tags:       [Debugging, HLLD, Crusher, Testing, Continuous Integration] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## HLLD Debugging

I found the last few bugs in the double star state and so now the HLLD solver
passes all tests when operating in the primary (x) direction! The bugs were
mostly typos but one test input parameters had to be redone since the HLLD
solver doesn't handle small numbers (1e-9) identically to Athena's solver where
my test data comes from. The new tests for testing the Y and Z directions in the
solver, which are really just the old tests rotated 90 degrees, don't currently
pass but that is likely an indexing error that should be easy to resolve. I've
been developing this solver with test driven development and it's been a
fantastic success. The tests immediately tells me where issues show up and make
it really easy to trace backwards from there to find the culprit. Overall it's
been a great success and I will be using test driven development where I can in
the future.

## Crusher

The new Frontier testbed, Crusher, became available this week and is the first
publid testbed to use Frontier hardware. We had a day long training on the
system and I got tests, and cholla in general, running on Crusher with only
minimal changes. I did find a "bug" that the margin we had for "equal" small
floating point numbers wasn't large enough. I originally set it to \\( 10^{-14}
\\) since that is an order of magnitude larger than the difference between
compiling with the XL vs GCC compilers on NVIDIA hardware. It turns out the
difference between XL/GCC on NVIDIA and Clang on AMD is more like \\( 10^{-12}
\\) for system tests so I set the margin on system tests to \\( 5 \times
10^{-12} \\), elsewhere the margin is still \\( 10^{-14} \\). I'm not worried
about the larger errors because the differences are still only about one ten
billionth of a percent.

## Other

- Updated this website to Chirpy v5.0.2
- Jenkins will be available for CI soon using Pitt CRC hardware so I can
  hopefully set up automated testing for Cholla soon
- I had an inspiration to help my dotfiles system deal with the multiple login
  and compute nodes on various systems so I made some significant changes to
  them and ported those changes over to the
  [public version](https://github.com/bcaddy/dotfiles-skeleton)

## Useful links

Original HLLD paper: [Miyoshi & Kusano 2005](https://www.sciencedirect.com/science/article/pii/S0021999105001142?via%3Dihub)

Blog post on the HLLD Algorithm: [HLLD Algorithm]({% post_url guides/2020-10-23-HLLD-Algorithm%})
