---
title:      Clang Tools Setup                 # Title
author:     Robert Caddy               # Author Name
date:       2022-11-18 16:44:28 -0400  # Date
categories: [Clang, Cholla]     # Catagories, no more than 2
tags:       [Static Analyzers, LLVM Tooling, clang-tidy, clang-format]
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Clang-Format

I set up our `clang-format` settings file, wrote a bash script to run it on all
our C++ files, and made a GitHub Action to check if a commit is properly
formatted that will run on every push and PR. I also added a
`.git-blame-rev-ignore-revs` file to help git blame know to ignore the
reformatting commits.

## Clang-Tidy

I set up the `.clang-tidy` file with all the settings we want and hooked it into
Cholla's build system so it will work with all our code, including the GPU code.
I figured out which checks we want to run and then disabled all the ones that
aren't currently passing, over time we'll work on getting them to pass. You can
find my `clang-tidy` notes [here]({% post_url guides/2022-11-17-clang-tidy-notes
%}). Next week I'll add clang to our docker images and add a GitHub Actions
workflow to run `clang-tidy`.
