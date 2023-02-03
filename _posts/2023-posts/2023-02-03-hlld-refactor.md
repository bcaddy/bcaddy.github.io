---
title:      HLLD Refactor                 # Title
author:     Robert Caddy               # Author Name
date:       2023-02-03 13:35:34 -0400  # Date
categories: [HLLD]     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## HLLD Refactor

I finished refactoring the HLLD solver to use structs instead of scalar
variables this week
([PR #237](https://github.com/cholla-hydro/cholla/pull/237)). It uses a few less
registers now, is much more readable, and several hundred lines shorter.

## Other

- Fixed minor bug in Sod shock tube tests ([PR #238](https://github.com/cholla-hydro/cholla/pull/238))
- Removed `using namespace std` from Cholla which resolves
  [Issue #233](https://github.com/cholla-hydro/cholla/issues/233) and lets us
  enable the `google-build-using-namespace` clang-tidy check.
  ([PR #245](https://github.com/cholla-hydro/cholla/pull/245))
