---
title:      System Test Pathing & Prep for Beta Release                 # Title
author:     Robert Caddy               # Author Name
date:       2021-10-01 16:50:10 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Makefiles, Make, Build System, C++17] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing
- Removed the old regression test
- Integrated Googletest linking into the make host files

The main thing I did though was improve pathing on the system test function and
finalize the beta version of testing. The system test function now takes no
arguments and determines all the paths it needs from the test name and some
command line arguments, this did require writing a main function for the tests.
It also now stores all the output into a directory in `cholla/bin` with the same
name as the test. Without `std::filesystem` in C++17 this is somewhat annoying
but is doable. I wrote a simple script in `cholla/builds/scripts/run_tests.sh`
to build and run tests across different systems. After that I tested everything
thouroughly on Spock and Summit then wrote a bunch of doxygen documentation.
Currently my testing branch is properly squashed down to a single commit and
ready for a PR once I finish the documentation that will go in the Cholla wiki.


# Other
- Updated website and started using the new gemfile for the theme to facilitate
  easier updates in the future
- Ran a spell checker on Cholla and fixed errors in comments
  ([Cholla PR #88](https://github.com/cholla-hydro/cholla/pull/88))
- Updated the old Cholla Makefiles repo to use as a place to store my VS Code
  settings directory for Cholla. Now it's the
  [editor-settings-cholla](https://github.com/bcaddy/editor-settings-cholla)
  repo.