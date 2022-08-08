---
title:      Constrained Transport EMF Kernel   # Title
author:     Robert Caddy               # Author Name
date:       2022-03-25 14:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Bugs, Constrained Transport, VL+CT, Van Leer]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## VL+CT Integrator

I worked a lot this week on figuring out the CT electric fields kernel. After
rereading Stone & Gardiner 2009, Gardiner & Stone 2008, and Stone et al. 2008
and looking at the source code for Athena I think I have a good handle on how
exactly to compute the CT EMFs. I'm still working on implementation as it's
fairly tricky but I anticipate finishing it next week. The biggest hurdle was
figuring out exactly where and how to use the magnetic fluxes returned from the
HLLD solver. According to the Athena source code this is the correct way to
convert them into EMFs.

*Note that the directions used here are relative to the internal workings of the
HLLD solver. Since the HLLD solver is inherently 1D we run it three times, once
for each direction. So in the case where the solver is running in the Y
direction the solver's Y field is actually the Z field and the solvers Z field
is actually the X field, cyclically extended for the Z direction*

| HLLD solve Direction | Equation for Magnetic Flux | Eqn. as a Cross Product    | EMF                 |
|----------------------|----------------------------|----------------------------|---------------------|
| \\( X \\)            | \\( V_x B_y - B_x V_y \\)  | \\(  (V \times B)_z \\) | \\( -\varepsilon_z \\) |
| \\( X \\)            | \\( V_x B_z - B_x V_z \\)  | \\( -(V \times B)_y \\) | \\(  \varepsilon_y \\) |
| \\( Y \\)            | \\( V_x B_y - B_x V_y \\)  | \\(  (V \times B)_z \\) | \\( -\varepsilon_x \\) |
| \\( Y \\)            | \\( V_x B_z - B_x V_z \\)  | \\( -(V \times B)_y \\) | \\(  \varepsilon_z \\) |
| \\( Z \\)            | \\( V_x B_y - B_x V_y \\)  | \\(  (V \times B)_z \\) | \\( -\varepsilon_y \\) |
| \\( Z \\)            | \\( V_x B_z - B_x V_z \\)  | \\( -(V \times B)_y \\) | \\(  \varepsilon_x \\) |

## Magnetic field storage side

Magnetic fields were stored on the "left" (i-1/2) face of the cell that was
indexed; i.e. the i,j,k cell stored the magnetic fields at the i-1/2, j-1/2, and
k-1/2 faces. This is opposite the way Cholla stores the other face centered
quantities (interface states and fluxes) so I switched the magnetic fields to be
stored on the "right" faces instead. The changes are in
[PR #140](https://github.com/cholla-hydro/cholla/pull/140).

## Other

- Read more of [Beck 2015](https://ui.adsabs.harvard.edu/abs/2015A%26ARv..24....4B/abstract)

## Links

- [VL+CT Algorithm]({% post_url guides/2021-01-06-VL+CT-Algorithm%})
- [HLLD Algorithm]({% post_url guides/2020-10-23-HLLD-Algorithm%})
