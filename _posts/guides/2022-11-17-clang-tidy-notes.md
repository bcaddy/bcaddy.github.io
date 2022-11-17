---
title:      Clang-tidy Notes                # Title
author:     Robert Caddy               # Author Name
date:       2022-11-17 10:29:48 -0400  # Date
categories: [Clang, clang-tidy]     # Catagories, no more than 2
tags:       [Static Analyzers, LLVM Tooling]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Clang-tidy notes

[clang-tidy 15 documentation](https://releases.llvm.org/15.0.0/tools/clang/tools/extra/docs/clang-tidy/index.html)
[minimal .clang-tidy](https://github.com/cpp-best-practices/gui_starter_template/blob/main/.clang-tidy)
[Intro to Clang-tidy](https://www.youtube.com/watch?v=OchPaGEH4TE)
[clang-tidy checks to avoid](https://www.youtube.com/watch?v=oxpsHk1yq88)

## System Headers

Setting the `HeaderFilterRegex` in `.clang-tidy` to `'.*'` should tell it to
ignore system headers.

## Fixes

Fixes can be automatically applied with the `-fix` flag. Multiple C++ files
don't handle fixes well as each instance of `clang-tidy` will try to apply the
same fixes at the same time. Instead either perform fixes manually or export the
fixes with the `-export-fixes` command and try applying them with
`clang-apply-replacements <directory-to-fix-yaml-files>`

## `run-clang-tidy.py`

[`run-clang-tidy.py`](https://github.com/rizsotto/Bear) is an LLVM tool for
running `clang-tidy` in parallel over an entire codebase. It requires a JSON
Compile Database which can be generated from GNU Make using
[Bear](https://github.com/rizsotto/Bear).
