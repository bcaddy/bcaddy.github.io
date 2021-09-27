---
title:      Testing Prototype                   # Title
author:     Robert Caddy               # Author Name
date:       2021-07-30 17:00 00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing Frameworks & Continuous Integration
This week I settled on learning and using GoogleTest since it has death tests
and is threadsafe and then I started implementing it in my
[hydro-sandbox](https://github.com/bcaddy/hydro-sandbox) code. I've got some
basic unit tests and system tests running that are testing for equality,
exceptions, etc. The system test even runs the hydro code asynchronously with
`std::async` while it's loading the fiducial data to save time. All current work
is in the `testing-prototype` branch though that will be merged into main
eventually.

I spent a lot of time reading up on testing strategies and started writing [this
gist](https://gist.github.com/bcaddy/11ff846461d3234ca8971a4d517186ef) as a
place to put testing knowledge and act as a prototype for the documention I'll
have to  write on Cholla's testing system eventually. I found this blog post
([Comparing Floating Point
Numbers](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/))
to be especially interesting and there's an entire series on floating point
numbers written by the same person. I highly recommend it.

I spent some time trying to get `gcov` and `lcov` working to show code coverage
but I ran into some difficulties getting it to give me useful results. I'll work
on that more.