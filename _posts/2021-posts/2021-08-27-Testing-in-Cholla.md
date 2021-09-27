---
title:      Testing in Cholla          # Title
author:     Robert Caddy               # Author Name
date:       2021-08-27 16:15:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Code Coverage] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing in [Cholla](https://github.com/cholla-hydro/cholla)

This week I started integrating testing into Cholla. The first part of that was
just meeting with Evan and discussing general strategy, convetions we should
use, etc. The questions and answers from that meeting can be found
[here](https://github.com/bcaddy/cholla/issues/1) in the "*Cholla Planning*"
section. First we need to reorganize Cholla source files a bit so that they all
have an appropriate directory, that's about half done. I started working on
puzzling out the build system and how to integrate a testing build into it but
all the experts were busy this week so I put that off for now and started
working on getting tests to run. I was able to get a simple integration test for
the HLLC solver in Cholla running (on GPU and everything) with a custom build
script and it works quite well. There were some issues to hammer out, mostly due
to my lack of experience with CUDA, but nothing that was too terrible. Unit
tests will be challenging in Cholla. Most of the code is fairly large,
monolithic, functions and so pretty much all tests are going to end up being
integration tests until such time as a refactor can be done. Hopefully between
the system and integration tests though we can determine where bugs are with
reasonable accuracy.


# Code Coverage
It turns out that nvcc and hipcc don't support code coverage for GPU code at
this time. There are some potential workarounds.
[VectorCAST](https://www.vectorcast.com/vc/index.html) supports it but that's an
expensive suite of tools intended for embedded devices and probably isn't useful
to us. We also might be able to capture coverage information by using the [HIP
CPU Runtime](https://github.com/ROCm-Developer-Tools/HIP-CPU) and compiling with
GCC's `--coverage` flag. This may or may not work, I haven't tested it yet.