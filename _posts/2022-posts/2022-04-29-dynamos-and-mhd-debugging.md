---
title:      Dynamos & MHD Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2022-04-29 11:49:40 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer, Reductions, matplotlib, Debugging, Dynamo]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       True                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

- Fixed some bugs in the divergence checking code and improved output formatting
- Fixed some bugs and formatting in the plotting code and tried a parallel
  version that turned out to actually be slower
- Found the issue with why Cholla didn't seem to be updating. I thought setting
  the time between outputs to zero meant that it would output on every time step
  when actually it just forced the time step to be zero. Setting the compile
  time macro `OUTPUT_ALWAYS` is what actually forces cholla to write out on
  every time step.
- Spent more time identifying bugs. The list of identified bugs thus far is:
  - time step = 0.1 when `-G` is set which is required for NVCC to enable GPU
    debuggers. Unclear why at this time, might be a Cholla bug rather than an
    MHD bug
  - X and Y velocity bug on left boundary. They both spike up really high on the
    first time step. Likely an issue with the boundary condition indexing
  - Large errors in central region, likely some of the CT slopes or the magnetic
    field update.

## Dynamos

I spend quite a bit of time reading up on dynamos. I read some basics on them
and have either read or am working on reading these papers. The dynamos of
greatest interest to my research are the \\( \alpha \\) and \\( \omega \\)
effects which together form the \\( \alpha\omega \\) dynamo. This dynamo is
believed to be the primary effect that sustains the galactic magnetic fields.
The \\( \alpha \\) effect is caused by helical fluid motion moving perpendicular
to the magnetic field direction which causes the magnetic field to twist and
turn into a shape resembling the letter \\( \alpha \\). The \\( \omega \\)
effect is simply cause by differential rotation "winding up" the magnetic field.
Together the two and take a begining magnetic field and stretch and fold it so
that it returns to it's original shape with an increased strength.

### Read or started

- [Pakmer et al. 2018, *Faraday rotation maps of disc
  galaxies*](https://academic.oup.com/mnras/article/481/4/4410/5106366)
- [Ntormousi et al. 2020, *A dynamo amplifying the magnetic field of a
  Milky-Way-like galaxy*](https://www.aanda.org/10.1051/0004-6361/202037835)
- [Pariev & Colgate 2007, *A Magnetic Alpha-Omega Dynamo in Active Galactic
  Nuclei Disks: I. The Hydrodynamics of Star-Disk Collisions and Keplerian
  Flow*](https://arxiv.org/abs/astro-ph/0611139)
- [Pariev et al. 2007, *A Magnetic Alpha-Omega Dynamo in Active Galactic Nuclei
  Disks: II. Magnetic Field Generation, Theories and
  Simulations*](https://arxiv.org/abs/astro-ph/0611188)
- [NASA *The Solar Dynamo*](https://solarscience.msfc.nasa.gov/dynamo.shtml)
- [*Dynamo Theory* by Andrew
  Gilbert](https://empslocal.ex.ac.uk/people/staff/adgilber/dynamoreview.pdf)
- [*Mean Field Theory Dynamo
  Solutions*](https://web.gps.caltech.edu/classes/ge131/notes2016/Ch22.pdf)

## Other

I got interested in Rust as an HPC programming language so I did some poking
around. Looks interesting but we'll have to see how support goes in the next
couple of years. If I was working on a high performance single node project I'd
probably try it out; I'm not sure if it would work well yet for massively
parallel systems though. Check out [Costanzo et al.
2021](https://arxiv.org/abs/2107.11912) for an interesting performance
comparison. Rust looks like it's currently losing but other benchmarks show it
being faster so it might just be a matter of which benchmark you pick.
