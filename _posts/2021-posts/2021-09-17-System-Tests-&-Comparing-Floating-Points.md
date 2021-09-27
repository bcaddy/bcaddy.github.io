---
title:      System Tests & Comparing Floating Point Numbers                 # Title
author:     Robert Caddy               # Author Name
date:       2021-09-17 16:49:06 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Floating Point Numbers, Comparing Floats] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# System Test Function
The function for running system tests is almost done! Through the first few days
this week I figured out the HDF5 C++ API well enough to open the files, read in
attributes, datasets, dataset names, sizes etc. everything I need to compare
values between two HDF5 files. That's where I ran into a major issues.
Googletest's default macro for comparing double precision, i.e. 64 bit, floating
point numbers operates by saying the numbers are the same if they're within 4
[ULPs](https://en.wikipedia.org/wiki/Unit_in_the_last_place) of each other. This
works pretty well for pairs of numbers with differences greater than 1 but when
the difference is very small it can catastrophically fail due to the density of
floating point numbers near 0. As it turns out, running the
[Sod Shock Tube](https://en.wikipedia.org/wiki/Sod_shock_tube) test when Cholla
was compiled with GCC 9.3.0 vs. XL 16.1.1-10 on Summit lead to absolute
differences in the results up to 1.77636E-15 and ULP distances measuring in the
millions. To combat this issue I wrote a pair of functions that implement a
hybrid comparison based off of these two blog posts:

1. [*Comparing Floating Point Numbers, 2012 Edition by Bruce Dawson*](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
  - This is the comparing floating point numbers bible as far as I can tell.
    Google cites it and every other article I found on the topic either cited
    this or an older version of it. The discussion is really good and there’s a
    ton of related posts linked at the top if you’re interested. The only issue
    is that the implementation of the ULP calculator in this article is written
    basically in C and uses some C features that conflict with modern C++.
2. [*Comparing Floating-Point Numbers Is Tricky by Matt Kline*](https://bitbashing.io/comparing-floats.html)
  - This is where I copied most of the implementation details from (it’s cited
    in my documentation and will be a reference in a paper at some point).
    However, this article is mostly just a reimplementation of Bruce Dawson’s
    work, just in a more readable and C++ friendly way.

The first article is just one in a fantastic series discussing issues with
floating point numbers and I highly recommend it to everyone working in a field
where floating point numbers matter.

The new `nearlyEqualDbl` function I wrote, which is mostly a modified version of
the functions in article 2 above, essentially checks if the absolute difference
between the two doubles being compared is less than a small number, in this case
1E-14. A priori we chose that a difference between two numbers that was less
than one order of magnitude greater than the difference between compilers would
be considered "equal". I.e. since the maximum absolute error between the GCC and
XL compilers was ~1.7E-15 our allowed margin of error should be ~1E-14, this
value can be changed by the user but 1E-14 is the default. If the absolute
difference is greater than the allowed margin then the functions compute the
ULPs (while dealing with a bunch of edge cases), return the ULP distance between
the numbers, and checks if that's less than the user defined allowed distance;
it defaults to 4 since that's Googletest's default.

As of now I have the system tes function working well for hydro tests but it
segfaults when I try to compare data from particle tests. I think I know the
issue, I just need to fix it but I didn't have time this week.

# Other
- Met with a representative from CircleCI to discuss using their service for our
  automated testing. Nothing firm yet