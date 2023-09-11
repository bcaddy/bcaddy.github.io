---
title:      Software Testing & Methodologies                 # Title
author:     Robert Caddy               # Author Name
date:       2022-08-08 11:16:55 -0400  # Date
categories: [Testing, Guide]     # Catagories, no more than 2
tags:       [Comparing Floats, C++, Floating Point Numbers, Framework, GitHub Actions]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Useful Links & Guides

- *Note that a lot of these links lead to specific companies who are selling
  testing software or something similar. The guides are still good, they're just
  trying to promote their own product. I'm not endorsing their product or
  suggesting we use it, I just liked the guide.*
- *links marked with a '1' are must reads, '2' means helpful but not required,
  '3' is for additional reading*
- (1)[Software Testing Methodologies](https://smartbear.com/learn/automated-testing/software-testing-methodologies/)
- (1)[What is Continuous Integration?](https://www.atlassian.com/continuous-delivery/continuous-integration)
- (2)[What Is End To End Testing? A Helpful Introductory Guide](https://www.testim.io/blog/end-to-end-testing-guide/)
- (2)[Test Driven Development](https://en.wikipedia.org/wiki/Test-driven_development)
- (2)[How to test software, part I: mocking, stubbing, and contract testing](https://circleci.com/blog/how-to-test-software-part-i-mocking-stubbing-and-contract-testing/)
- (3)Best Practices for HPC Software Developers: #4 "Testing & Documenting Your Code" ([video](https://www.youtube.com/watch?v=kAC0N84JaHA))([slides](https://www.olcf.ornl.gov/wp-content/uploads/2016/04/testing_webinar.pdf))
- (3)[Automated Regression Testing: Everything You Need To Know](https://www.testim.io/blog/automated-regression-testing/)
- (3)[Software Testing](https://en.wikipedia.org/wiki/Software_testing#Testing_approach)
- (3)[HPC testing best practices, one of the talks here](https://ideas-productivity.org/events/hpc-best-practices-webinars/)
- (3)[gtest MPI listener](https://github.com/LLNL/gtest-mpi-listener)

## GoogleTest Specific Links

- (1)[Googletest Primer](https://google.github.io/googletest/primer.html)
- (1)[Floating-Point Comparison](https://google.github.io/googletest/reference/assertions.html#floating-point)
- (2)[Comparing Floating Point Numbers, 2012 Edition](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
  - *This is part of an excellent series of blogs on floating point numbers*

# Terminology

- "Unit test" - Test a single "unit" of code such as a function, class method,
  constructor, etc.
- "Integration Test" - Test how multiple units of code work together. Example:
  testing an entire Riemann solver instead of just the individual functions
  within it
- "End-to-End (E2E) testing" or "System testing" - Testing the entire code to
  make sure it produces the correct result or action. Tests should probably be
  comparing floating point values not strings.
- "Regression test" - Test that new changes have not broken the code or
  introduced new bugs. Unit, integration, and E2E tests can all be regression
  tests
- "Performance Test" - Make sure the thing you're testing doesn't take more time,
  memory, or other resources than expected
- "Mocking" - Some tests might have a dependency that doesn't behave in a
  predictable way for testing and so we need to make fake or "mocked" version
  that does. An example might be a random number generator. In production we
  want it to be random but in testing we might always want it to return the same
  value.
- "Automated Testing" - Running tests automatically based on some event.
  Typically this event is something like pushing to GitHub or opening a pull
  request.
- "Continuous Integration (CI)" - Quickly integrating changes from different
  developers using some sort of automated build, test, deployment system. Read
  the link in the Useful Links & Guides section for more info.
- "Test Driven Development (TDD)" - Writing the tests BEFORE you write the code
  that will be tested. This can be done as part of the design phase to make sure
  the end product matches all the requirements.

# Testing Strategies

- What should you test exactly?
  - Test each path within the code. I.e. each branch in every if-elif-else
    statement or any similar branching
  - Test with good inputs AND bad inputs, the code should fail when given bad
    inputs and it should fail the way you expect it to.
  - Test edge cases. Things that are uncommon but could throw a wrench in
    things. Examples might be zero velocity etc
  - For system tests make sure to test the number of total time steps
- **Death Tests**
  - Special naming convention should be used. Specifically the name of all test
    suites with a death test in them should end in `DeathTest`
    [Reason](https://google.github.io/googletest/advanced.html#death-tests-and-threads)
- We need to have a rigorous naming scheme for tests and test suites. Google likely has suggestions
- If you have series of tests that require the same setup (initializing a class etc) then you can
  use a test fixture to automate that. Each test will use its own instance of the fixture
  - Resources can be shared between tests in the same suite, it just requires some extra syntax.
    Look at GTests documentation for details
- **Performance Tests**
  1. Benchmark the code. There's a library for this or you can do it yourself
  2. Compare the execution time to the fiducial time with EXPECT_NEAR using an appropriate margin
     of error
- Tests should also be done with different compilers(both across vendors and versions), OS's, hardware, etc.

# Naming & Location of Tests

- Tests should be named clearly and similarly to what they test so they can be
  easily found. I.e. the code that tests `hllc.cpp` should be name something
  like `hllc-tests.cpp`
- Where to store the tests?
  1. Right next to the file it tests. This can lead to very cluttered
     directories but means that the testing is never "out of sight and out of
     mind"
  2. If the source directory is broken up into subdirectories for each "topic"
     then in a subsubdirectory within the topic. I.e. within
     `repo-root/src/topic-dir/topic-dir-test`. This is probably the most
     organized and cleanest way of doing things but it requires a really solid
     directory structure for source files
  3. In `repo-root/tests`. This might be the best option when your source files
     are just all in a single directory without sub directories. However it
     means that the tests are out of sight when editing, and therefore likely
     out of mind. Also, since the testing directory should maintain the same
     structure as the source directory it can be hard to maintain.

# C++ Testing Frameworks

- [GoogleTest](https://github.com/google/googletest)
  - [GoogleTest Primer](https://google.github.io/googletest/primer.html)
  - Feature rich
  - Reasonably easy to use
  - Includes death tests, important since Cholla doesn't have much in the way of
    error handling
  - Has an extensive list of related projects that enhance its features
  - Threadsafe if the `pthreads` library is available. i.e. everywhere except
    Windows
  - Requires an entire external library
  - Is only designed with CMake and Bazel in mind. Integration with Make works
    fine.
- [Catch2](https://github.com/catchorg/Catch2)
  - Very simple and easy to implement, though lacking some features
  - Header only
  - Popular
  - Due to the header only nature it can significantly increase compile times if
    used improperly
  - No death tests
  - Not thread safe
- [DOCtest](https://github.com/onqtam/doctest)
  - A stripped down, faster version of Catch2
  - Fast but not very feature rich
  - No death tests
  - Not thread safe
- Boost Test
  - Not bad, just doesn't really stand out compared to other options
  - No death tests
  - Not thread safe
- CTest
  - Might work if you're using CMake already, if not then it's not worth it.

# Automated Testing

- gitlab CI, CircleCI, and Jenkins all support nvidia GPUs
  - gitlab CI is probably my best bet
    - Does it support multiple GPU's in parallel?
- gitHub Actions?
  - I don't think they currently support GPU's but self hosted runners can
  - [MLOps Tutorial #4: GitHub Actions with your own GPUs](https://www.youtube.com/watch?v=rVq-SCNyxVc)
  - [CML self-hosted runners on demand with GPUs](https://dvc.org/blog/cml-self-hosted-runners-on-demand-with-gpus)
  - [Self-hosted runners for GitHub Actions is now in beta](https://github.blog/2019-11-05-self-hosted-runners-for-github-actions-is-now-in-beta/)
  - [GitHub Actions: Providing Data Scientists With New Superpowers](https://fastpages.fast.ai/actions/markdown/2020/03/06/fastpages-actions.html#fn:1)
- Ability to test only changed sections automatically?

# Naming Scheme

Googletest allows you to choose which tests to run at runtime via standard
pattern matching. To facilitate this we need to have rigorous system for naming
test suites and tests. Here you will find those conventions. Details of the
naming scheme we used for Cholla can be found
[here](https://github.com/cholla-hydro/cholla/wiki/Testing).
