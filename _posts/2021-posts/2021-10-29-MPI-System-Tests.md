---
title:      MPI System Tests      # Title
author:     Robert Caddy               # Author Name
date:       2021-10-29 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [GitHub Actions, Automated Testing, Continuous Integration (CI)] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# MPI System Tests
This week I added support for MPI system tests. The `SystemTestRunner` class now
can read in an arbitrary number of HDF5 files from Cholla, concatenated one
dataset at a time, and compare it to the fiducial results. This was mostly a lot
of indexing to get everything lined up right. Currently particles aren't
supported since the disk make type doesn't build, it should be easy to add them
later. I also added the ability in system tests to turn off the comparisons or
the running of Cholla. This is for tests with a large number of MPI ranks where
you might want to run Cholla in one job then do the comparisons in another job.

# Merging Into [Cholla](https://github.com/cholla-hydro/cholla)
I worked through testing Cholla on each system we use, found a [bug in
cholla](https://github.com/cholla-hydro/cholla/issues/92), and fixed a few
issues with how the test were running on Summit. After I got everything working
I updated the documentation, submitted a PR, updated the main Cholla wiki with
testing info, checked all the links in the wiki, setup the GitHub Actions
workflow and branch protection.

# Other
- The default way of running the tests through `run_tests.sh` now generates XML
  reports
