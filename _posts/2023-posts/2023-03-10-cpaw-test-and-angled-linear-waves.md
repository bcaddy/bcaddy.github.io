---
title:      CPAW Test & Angled Linear Waves                 # Title
author:     Robert Caddy               # Author Name
date:       2023-03-10 12:58:57 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Tests, MHD Tests, clang-tidy]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Circularly Polarized Alfvên Wave Test (CPAW)

I finished the CPAW test. There were a few other bugs in the initial conditions but I got those sorted and cleaned up the code, wrote the tests, and submitted the PR ([PR #261](https://github.com/cholla-hydro/cholla/pull/261)).

## Angled Linear Waves

Since the method to add angled linear waves are almost exactly the same as the CPAW test I decided to add those as well. After some debugging of the initial conditions I got it to reproduce and pass all the grid aligned wave tests and all the angled test except the slow magnetosonic wave. That wave appears to have highlighted a bug that I'm working on solving and you can find more info on that [here](https://github.com/orgs/cholla-hydro/projects/5/views/1?pane=issue&itemId=22506930).

## Automated Testing

Automated testing is mostly ready. I got pretty much all of the stuff on our end sorted out and now we're just waiting for the CRC folks to sort out some last details. ([PR #229](https://github.com/cholla-hydro/cholla/pull/229))

## Clang-tidy Check Enabling

During our hack session I was able to fix the warnings and enable 5 of the `bugprone` clang-tidy checks. See [PR #267](https://github.com/cholla-hydro/cholla/pull/267) for details.

- bugprone-assignment-in-if-condition
- bugprone-branch-clone
- bugprone-integer-division
- bugprone-string-integer-assignment
- bugprone-macro-parentheses

## Other

- Some minor bugfixes in [PR #262](https://github.com/cholla-hydro/cholla/pull/262)
