---
title:      Debugging & DeviceVector                 # Title
author:     Robert Caddy               # Author Name
date:       2022-07-22 17:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Debugging]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## `DeviceVector`

I added simple method for assigning values to locations in a `DeviceVector`
array.

I also got the `DeviceVector` class and GPU reduction fixes into my MHD branch.
This required quite a few changes to integrate but ended up working exactly as
expected with C++17 and structured binding. Now I can declare a `static
DeviceVector` and static values from the `ReductionLaunchParams` struct and use
those on every instance of the function and then they will clean themselves up
upon exiting.

## MHD Debugging

I found and fixed an issue with the magnetic field update kernel. The thread
guard on it was set to strict and loosening it fixed a major bug, now all linear
waves run with a zero divergence. More complex cases still fail, there's an
issue with the y boundary conditions on the lower side, still working on
identifying the exact location but it's somewhere in the kernel that sets the
ghost cells.

## Other

- Wrote a class for MPI persistent communication
- Cleaned up my timing class
