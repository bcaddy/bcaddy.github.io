---
title:      Testing Prototype 2        # Title
author:     Robert Caddy               # Author Name
date:       2021-08-13 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, GitHub Actions]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing Details
This week I got my tests up and running on the H2P cluster at Pitt and Summit at
ORNL. This was mostly a game of figuring out exactly how the Googletest library
should be linked and included into my project, getting the admins to install
gtest on H2P and Summit, and hammering out a few other minor issues. I also
refactored some of the test utility code to avoid some multiple definition
errors.

I got the testing with conditional compilation working. The tests that test a
function that might not exist depending on the set of defines have to either be
hidden with an `#ifdef` or the function they’re testing has to have a null
return option. Tests that might return different results depending on the
combination of `#ifdefs` also either have to be conditionally compiled OR
somehow gather the ifdef values and then choose the correct value to compare
against.

I found an issue with the system test I wrote last week. If it fails it prints
out the entirety of both strings it's comparing which is many thousands of
lines. Instead I'm now comparing the strings in C++ and simply testing whether
the result of that is true or false and then providing a custom failure message.
It's a little hacky but it's just as readable and doesn't result in thousands of
lines of useless output.

I spent some more time looking into determining code coverage but all the tools
I want to use for that assume you have some form of automated testing set up
so...

# Automated Testing
I set up a very basic automated build and testing workflow with GitHub Actions.
It was largely painless, though figuring out the syntax was confusing at first
as I've never worked with YAML files before. Figuring it out took about a day
but I've got it working and even have a status badge on the repo readme. It
should be relatively easy to extend it to Cholla and maybe even get some easy
parallelization for the tests.