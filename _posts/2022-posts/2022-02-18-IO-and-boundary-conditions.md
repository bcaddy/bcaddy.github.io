---
title:      I/O and Boundary Conditions # Title
author:     Robert Caddy                # Author Name
date:       2022-02-18 10:06:03 -0400   # Date
categories: [Cholla, MHD]               # Catagories, no more than 2
tags:       [I/O, Boundary Conditions, Git, GitHub]  # Tags, any number
pin:        false                       # Should this post be pinned?
toc:        true                        # Table of Contents?
math:       false                       # Does this post contain math?
#image:      /assets/img/#              # Header image path
---

## Grid & I/O

I finished up MHD I/O in Cholla so now cholla can read and write magnetic field
variables, set initial conditions, etc. I also added new parameter files for
Einfeldt Strong Rarefaction plus the Ryu & Jones 4 and Dai & Woodward MHD shock
tubes.

## Boundary Conditions

I've started on boundary conditions in Cholla for MHD but they're especially
tricky. The MPI and periodic boundaries work exactly the same in hydro and MHD
since they just take the value of the next cell over but the reflective and
transmissive boundaries don't; they take the value of one of the real cells near
the edge and so I need to make sure we get the correct cell and treat the outer
face of MHD grid as part of the real grid and not a ghost cell. After discussing
it extensively I think that I need to modify some combination of functions in
`src/mpi/cuda_pack_buffers.cu` since that is where all the assignment is done.
Specifically the kernel `PackGhostCellsKernel` which in turn calls
`SetBoundaryMapping` and `FindIndex` to compute which cell to source the ghost
cell values from. I'm not sure of the best way to do that yet but I'm working on
it.

## Other

- Read the dust polarization section (21.3) of *Physics of the Interstellar
  Medium and Intergalactic Medium* by Bruce T. Draine
- Attended the *[Wrong Way: Lessons Learned and Possibilities for Using the “Wrong” Programming Approach on Leadership Computing Facility Systems](https://ideas-productivity.org/events/hpc-best-practices-webinars/)* webinar.
