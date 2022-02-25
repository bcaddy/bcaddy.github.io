---
title:      Boundary Conditions & Testing Data  # Title
author:     Robert Caddy               # Author Name
date:       2022-02-25 10:46:42 -0400  # Date
categories: [Cholla, MHD]               # Catagories, no more than 2
tags:       [Boundary Conditions, Git, GitHub, Git LFS, Testing]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Boundary Conditions

I finished up implementing MHD boundary conditions with some advice from Alwin.
To test it I learned the basics of how to use cuda-gdb on the command line which
was actually a lot easier than expected, unfortunately required though since the
cuda-gdb VS Code integration is very poor at the time of writing. I implemented
the MHD boundary conditions by, if `MHD` is defined, generating two indices; one
for the hydro variables and one for the magnetic fields. Then I loop through the
fields and choose which index to use based on which field is being copied or
modified.

## Cholla Testing Data

As we add more systems tests and their associated data the main Cholla repo
could end up being fairly large which is an issue for non-developers who want to
clone the repo and run simulations. To alleviate this I'm working on making a
seperated repo,
[cholla-tests-data](https://github.com/cholla-hydro/cholla-tests-data), that is
a submodule of Cholla and uses Git LFS to manage the HDF5 files. All the
planning and research for that is done, I'm just working on implementing it now.
I did look into using [DVC](https://dvc.org) but at this time I think it's
overkill for what we're doing.

## Other

- Prepped for the testing hack day I'm leading this week
- Fixed an issue with MPI not installing properly on GitHub Actions builds
- Some reading on dust polarization
