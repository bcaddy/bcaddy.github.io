---
title:      ROCm Builds and Clang Utilities                 # Title
author:     Robert Caddy               # Author Name
date:       2022-07-29 16:18:32 -0400  # Date
categories: [ROCm, GitHub Actions]     # Catagories, no more than 2
tags:       [Clang]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---


## GitHub Action HIP Builds

I ended up spending most of this week trying to get the automated HIP/ROCm
builds to work on GitHub Actions. The latest release of ROCm (v5.2.1) seems to
have broken some significant backwards compatibility and I haven't been able to
get Cholla to find the HIPFFT library no matter what I do. I still don't have a
fix for this but I've brought it up with our AMD rep.

## Style Guides and Automatic Formatting/enforcement

I spent some time digging into C++ style guides, conventions, and enforcement of
them. It looks like a combination of `clang-format` and `clang-tidy` will do the
job but we still need to discuss it as a group more.

## ATPESC Prep

I got set up on the various compute systems required for ATPESC.
