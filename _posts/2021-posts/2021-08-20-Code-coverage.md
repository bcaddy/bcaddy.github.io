---
title:      Code Coverage       # Title
author:     Robert Caddy               # Author Name
date:       2021-08-20 14:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, GitHub Actions, Code Coverage, Codecov] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Code Coverage
This week I focused on determining code coverage and tools to use that
information. Generating the coverage data is fairly easy, you just have to pass
the `--coverage` flag to the compiler. This works for GCC but I don't know about
other compilers. However, making that data useful and readable is much more
challenging. I used `lcov` which is a standard tool for this developed by and
for the developers of the Linux kernel. By default it reports coverage on
everything that the program touches, including the STL and any external or
system libraries. It also *only* reports coverage for the units of code that are
actually tested. I.e. if you are testing a single function it will tell you the
coverage of that function and totally ignore the rest of the project. The first
issue can be solved with a combination of the `--extract` and `--remove` flags
while the second issue requires that you generate an initial report where all
the lines are indicated as running zero times and then *add* the report where
the code is actually executed. Here's an example of what you have to do:

```bash
# Gather initial, zero count data
# --capture = get the data
# --directory = where the program is? can be done more than once
# --output-file = results output file. Should end in ".info"
# ${capture_directories[@]} = an array of directory paths that you want to find
#                             coverage for the contents of
lcov --capture --initial ${capture_directories[@]} --output-file coverage_base.info

# Generate test results. This is the actual data from running the tests
lcov --capture ${capture_directories[@]} --output-file coverage_test.info

# Combine base and test results
lcov --add-tracefile coverage_base.info --add-tracefile coverage_test.info --output-file coverage_all.info

# Extract data from only the files within Repo_root. This should exclude any
# system or external libraries
lcov --extract coverage_all.info "${repo_root}/*" --output-file coverage_all.info

# Remove data from files that are within ${repo_root} but that you don't want to
# include in the report; like the tests themselves
exclude_patterns=('*-tests.cpp' # Remove traces of the tests themselves
                  '*-test.cpp') # Remove traces of the tests themselves
# --remove TRACEFILE PATTERN = remove all things associated with PATTERN in TRACEFILE
lcov --remove coverage_all.info "${exclude_patterns[@]}" --output-file coverage_all.info
```

At this point you can display the data in ASCII with `lcov`, generate an HTML
report, or upload the coverage report to somewhere else for analysis.

```bash
# Print out the report in the console. The report is reasonably clean but
# doesn't provide any line-by-line view
lcov --list coverage_all.info

# Generate a nice HTML report that you can browse through like a website. It
# allows you to see exactly which lines are covered, how many times, which lines
# are being missed, etc.
genhtml coverage_all.info --output-directory Code-coverage-html
```

The third option is to upload this coverage report to an external tool,
preferably as part of your automated testing or CI pipeline. I wanted a more
sophisticated, web based, tool for this so that we could have a nice GUI to see
current and past code coverage, track how we're improving, get coverage reports
on pull requests, etc. The two tools I looked at were
[Coveralls](https://coveralls.io) and [Codecov](https://about.codecov.io).
Coveralls was easier to setup, I literally just made an account then copied an
pasted the code from their [GitHub Marketplace
page](https://github.com/marketplace/coveralls), but it failed to combine
multiple reports from different combinations of ifdefs which is a critical
feature. Codecov was a bit more work to set up, largely because their
documentation is a bit confusing but their support was very helpful and got my
issues sorted out quickly. CodeCov also combined reports from different ifdef
combinations natively without any work from me at all and allows you to see the
coverage from each combination of ifdefs and in any combination or subset. Plus
they have prettier and more useful graphs. You can see an example of Codecov in
action [here](https://app.codecov.io/gh/bcaddy/hydro-sandbox). Both tools
provide readme badges that will display your current code coverage on your
repositories readme.


## Other
- Read Fielding & Bryan 2021, Squire et al. 2021
- Watched Alicia Klinvex's talk on
  [Testing & Documenting Your Code](https://www.youtube.com/watch?v=kAC0N84JaHA)
- Updated modules used on Summit and Spock to account for recent OS and software
  stack updates
