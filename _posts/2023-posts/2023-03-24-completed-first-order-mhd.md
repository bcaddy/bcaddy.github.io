---
title:      Completed First Order MHD!                 # Title
author:     Robert Caddy               # Author Name
date:       2023-03-24 11:35:01 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Tests, MHD Tests]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD

### Advecting Field Loop

This is done and in [PR #273](https://github.com/cholla-hydro/cholla/pull/273). Last week I discovered that the issues I was having with it were just due to some errors in how I was computing the mean magnetic pressure during each time step (I was including ghost cells) and now that's fixed and the test passes. It did highlight some issues with MHD I/O though.

### MHD I/O

Previously MHD was outputting one extra cell in each direction for each of the magnetic fields when it should have just been outputting one extra in the direction of the field. In [PR #270](https://github.com/cholla-hydro/cholla/pull/270/files) I fixed that, added a restart test for MHD and hydro, and replaces all custom `PI` macros with built in `M_PI`.

### MHD Compiler Warnings

There have been some compiler warnings with MHD builds for awhile, mostly related to non-MHD code. In [PR #272](https://github.com/cholla-hydro/cholla/pull/272) I fixed them with a mix of converting `char` arrays to `std::string`s and the use of the [`[[maybe_unused]]`](https://en.cppreference.com/w/cpp/language/attributes/maybe_unused) [attribute specifier](https://en.cppreference.com/w/cpp/language/attributes).

### MHD Blast Wave Test

I added initial conditions and a regression test for the MHD blast wave detailed in [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract). This test passes and the new code is detailed in [PR #274](https://github.com/cholla-hydro/cholla/pull/274)

### Orszag-Tang Vortex Test

I added initial conditions and a regression test for the Orszag-Tang Vortex detailed in [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract). This test passes. The PR will be up once previous PRs are merged as it depends on some of the utility functions implemented in them.

## Other

- Automated testing is now ready. See [PR #229](https://github.com/cholla-hydro/cholla/pull/229) for details.
- Updated this website to v5.6.0
- Fixed failing tests on automated testing. Just had some corrupted data that needed reset.
- Opened an issue on converting from `int` to `size_t`/`ptrdiff_t` where appropriate. [Issue #271](https://github.com/cholla-hydro/cholla/issues/271)
