---
title:      System Test Refactor       # Title
author:     Robert Caddy               # Author Name
date:       2021-10-15 16:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Documentation] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing
After getting feedback on the testing system last week I refactored the entire
system testing function into a class with substantially expanded functionality.
This was really helpful and made the tool a lot more expandable for future work.
It did make it harder to implement MPI tests but the additional functionality of
the class should allow me to do more complex MPI tests in the long run. As part
of the refactor I added a bunch of utility methods for setting fiducial data,
time step number, choosing what to test, etc. I tried to set it up such that any
new fiducial data arrays would be saved as HDF5 files for later manual
comparison if needed but the HDF5 C++ API is difficult and annoying to use so I
decided to postpone that until someone needs it. The new class has lots of
doxygen comments and there is documentation in the wiki of my fork of
[Cholla](https://github.com/bcaddy/cholla)

## Performance Timing
I wanted to examing the performance characteristics of the system test so I
reran the system test 1,000 times and got these results:

| Section         | Average Time | Minimum Time | Maximum Time |
| --------------- | ------------ | ------------ | ------------ |
| Cholla Run      | 1.06028 *s*  | 487.683 *ms* | 1.67028 *s*  |
| Total Time      | 1.07490 *s*  | 494.208 *ms* | 1.69090 *s*  |
| Non-Cholla Time | 1.462  *ms*  |   6.525 *ms* | 2.062  *ms*  |

All in all it came out to about 1.4 \\( \mu s\\) per cell. That's with a lot of
overhead in the form of class instantiation, array allocation, etc that either
wouldn't exist in an MPI test or can be optimized away.

# Automated Testing
Automated testing, and general portability, might require us to be able to build
and link to GoogleTest without relying on the system to already have it
installed. I wrote a script to do that and set up the various make.host files to
use a user installed version of GoogleTest over the system installed one. I'm
getting some library linking issues on the Pitt H2P cluster but it works on
Summit, Spock, and C-3PO (Evan's computer).

# Other
- Modified run_tests script to automatically choose machine name and launch
  command based on the hostname.