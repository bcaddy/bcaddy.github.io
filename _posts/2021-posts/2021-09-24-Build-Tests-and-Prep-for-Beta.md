---
title:      Build Tests & Prep for Beta Release                 # Title
author:     Robert Caddy               # Author Name
date:       2021-09-24 16:24:10 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Makefiles, Make, Build System] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# System Test Function
I fixed a few bugs in the system test function then wrote an full system test
for Cholla. This function still needs some work but it's ready for beta. Current
limitations:
- The system test function does not currently support more than 1 MPI rank;
  serial jobs only. Adding MPI in the future should be easy but is planned for
  later
- The system test function currently requires that paths to various files be set
  more manually than I would like. I’m thinking about solutions and would love
  input but for now you can see how I’ve set paths in src/hydro_system_tests.cpp
- Fiducial data for system tests is NOT yet part of the repo and has to be
  copied manually. I can provide the files on request.


# Building Cholla & Tests
First I moved the test files into their new homes next to the files they're
testing the contents of, except for system tests which get their own directory.
Next I made sure we could still comopile Cholla when the test files were in
their new homes, this was accomplished by just filtering the test files out of
the list of object files to compile. Getting the tests themselves to build and
run required a lot more work. Summit's scheduler currently isn't allowing
interactive jobs and H2P's install of Googletest is semi-broken. Discovering
these two things ate about two days of work trying to figure out the issue.
After I figured that out I found some bugs in the HLLC test that showed up under
HIP but not CUDA, it turns out that in some cases you can pass CUDA kernels
small arrays directly but you can't do that with HIP kernel calls. I set up the
tests to build by filtering out Cholla's usual main file, setting the
appropriate flags to link Googletest, pthreads, and the HDF5 C++ API, and change
the executable name. The `clean` make target also had to be updated since it
worked off the list of objects and that's now subject to change. I made a
`CLEAN_OBJ` variable that is generated before any file filtering is done and so
now `make clean` uses that to clean all objects; the pattern finding for
deletion of the final binary also had to be tweaked for the test executable
name.

# Testing Documentation
I developed a naming scheme for our test files, test suites, and tests. This is
required to A) filter out test files and B) allow runtime filtering of which
tests to run. Unfortunately, test/suite names can only contain A-Z, a-Z, and 0-9
so making an easily readable standard for naming is not trivial. That standard
can be found in the Cholla testing documentation which is my goal for next week.