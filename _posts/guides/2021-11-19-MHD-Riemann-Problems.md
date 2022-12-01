---
title:      MHD Riemann Problems            # Title
author:     Robert Caddy               # Author Name
date:       2021-11-19 10:10:09 -0400  # Date
categories: [MHD, Guide]     # Catagories, no more than 2
tags:       [Riemann Problem, Shock Tube, HLLD,]       # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

I'll be using a selection of MHD Riemann Problems and shock tubes to test my
HLLD and overall MHD implementation so I wanted to gather some of the basics
here. This post was originally written with information from Miniati & Martin
2011[^charm]. Citations are at the bottom and images are cited in their
captions.

Once MHD is fully implemented a followup post will follow with non-Riemann test
problems such as the Orszag-Tang Vortex.

## Table of Riemann Problems

| Field           | Brio & Wu[^bw] | Dai & Woodward[^dw]             | Einfeldt Strong Rarefaction[^fr][^hlld] | Ryu & Jones 1a[^rj]           | Ryu & Jones 2a[^rj]             | Ryu & Jones 4d[^rj] |
| \\( \gamma \\)  | \\( 2 \\)      | \\( \frac{5}{3} \\)             | \\( 1.4 \\)                             | \\( \frac{5}{3} \\)           | \\( \frac{5}{3} \\)             | \\( \frac{5}{3} \\) |
| \\( t_{max} \\) | \\( 0.1 \\)    | \\( 0.2 \\)                     | \\( 0.16 \\)                            | \\( 0.08 \\)                  | \\( 0.2 \\)                     | \\( 0.16 \\)        |
| **Left**        |                |                                 |                                         |                               |                                 |                     |
| \\( \rho \\)    | \\( 1.0 \\)    | \\( 1.08 \\)                    | \\( 1.0 \\)                             | \\( 1.0 \\)                   | \\( 1.08 \\)                    | \\( 1.0 \\)         |
| \\( P \\)       | \\( 1.0 \\)    | \\( 1.0 \\)                     | \\( 0.45 \\)                            | \\( 20 \\)                    | \\( 0.95 \\)                    | \\( 1.0 \\)         |
| \\( V_x \\)     | \\( 0.0 \\)    | \\( 0.0 \\)                     | \\( -v_0 = -2.0 \\)                     | \\( 10.0 \\)                  | \\( 1.2 \\)                     | \\( 0.0 \\)         |
| \\( V_y \\)     | \\( 0.0 \\)    | \\( 0.0 \\)                     | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( 0.01 \\)                    | \\( 0.0 \\)         |
| \\( V_z \\)     | \\( 0.0 \\)    | \\( 0.0 \\)                     | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( 0.5 \\)                     | \\( 0.0 \\)         |
| \\( B_x \\)     | \\( 0.75 \\)   | \\( \frac{4}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)                             | \\( \frac{5}{\sqrt{4\pi}} \\) | \\( 2\sqrt{4\pi} \\)            | \\( 0.7 \\)         |
| \\( B_y \\)     | \\( 1.0 \\)    | \\( \frac{3.6}{\sqrt{4\pi}} \\) | \\( 0.5 \\)                             | \\( \frac{5}{\sqrt{4\pi}} \\) | \\( \frac{3.6}{\sqrt{4\pi}} \\) | \\( 0.0 \\)         |
| \\( B_z \\)     | \\( 0.0 \\)    | \\( \frac{2}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( \frac{2}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)         |
| **Right**       |                |                                 |                                         |                               |                                 |                     |
| \\( \rho \\)    | \\( 0.128 \\)  | \\( 1.0 \\)                     | \\( 1.0 \\)                             | \\( 1.0 \\)                   | \\( 1.0 \\)                     | \\( 0.3 \\)         |
| \\( P \\)       | \\( 0.1 \\)    | \\( 0.2 \\)                     | \\( 0.45 \\)                            | \\( 1.0 \\)                   | \\( 1.0 \\)                     | \\( 0.2 \\)         |
| \\( V_x \\)     | \\( 0.0 \\)    | \\( 0.0 \\)                     | \\( v_0 = 2.0 \\)                       | \\( -10 \\)                   | \\( 0.0 \\)                     | \\( 0.0 \\)         |
| \\( V_y \\)     | \\( 0.0 \\)    | \\( 0.0 \\)                     | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( 0.0 \\)                     | \\( 0.0 \\)         |
| \\( V_z \\)     | \\( 0.0 \\)    | \\( 1.0 \\)                     | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( 0.0 \\)                     | \\( 1.0 \\)         |
| \\( B_x \\)     | \\( 0.75 \\)   | \\( \frac{4}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)                             | \\( \frac{5}{\sqrt{4\pi}} \\) | \\( 2\sqrt{4\pi} \\)            | \\( 0.7 \\)         |
| \\( B_y \\)     | \\( -1.0 \\)   | \\( \frac{4}{\sqrt{4\pi}} \\)   | \\( 0.5 \\)                             | \\( \frac{5}{\sqrt{4\pi}} \\) | \\( \frac{4}{\sqrt{4\pi}} \\)   | \\( 1.0 \\)         |
| \\( B_z \\)     | \\( 0.0 \\)    | \\( \frac{2}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)                             | \\( 0.0 \\)                   | \\( \frac{2}{\sqrt{4\pi}} \\)   | \\( 0.0 \\)         |

## Details on Each Problem

### Brio & Wu Shock Tube[^bw]

The Brio & Wu Shock Tube is essentially a Sod Sock Tube with magnetic fields. It
shows most of the MHD waves and is a good stress test for approximate Riemann
solvers and MHD simulation code.

Waves, left to right:

1. Fast rarefaction
2. Compound wave
3. Contact discontinuity
4. Slow shock
5. Fast rarefaction

![Brio & Wu Image](/assets/img/2021-post-assets/11-November/Brio-Wu-Miniati-Martin-2011-fig-2.png)
*Brio & Wu Shock Tube at \\( t=0.1 \\). Source: Figure 2 from Miniati & Martin 2011[^charm]*

### Dai & Woodward Shock Tube[^dw]

The Dai & Woodward Shock Tube produces 3 pairs of MHD waves moving outwards from
the central contact discontinuity. This is probably a more robust test of MHD
than the Brio & Wu Shock Tube since it shows all 7 MHD waves.

Waves, left ot right:

1. Fast shock
2. Alfvên/Rotation waves
3. Slow shock
4. Contact discontinuity
5. Slow shock
6. Alfvên/Rotation waves
7. Fast shock

![Dai & Woodward Image](/assets/img/2021-post-assets/11-November/Dai-Woodward-Miniati-Martin-2011-fig-3.png)
*Dai & Woodward Shock Tube at \\( t=0.2 \\). Source: Figure 3 from Miniati & Martin 2011[^charm]*

### Einfeldt Strong Rarefaction[^fr][^hlld]

This is the only test here that isn't a shock tube. We have identical initial
conditions on both sides, except the \\( x \\)-velocity which is negative on the
left side and positive on the right. This velocity, \\( V_0 \\), can lead to
spurious oscillation with high order Godunov schemes[^charm] when \\( V_0 \\) is
large (\\( V_0 \ge 3 \\)) and so I've chosen a more conservative value of \\( V_0=2 \\) . These
diverging fluids lead to an extremely strong and fast rarefaction where the
energy is dominated by kinetic energy and can often reveal issues in code
accuracy since it can lead to nonphysical states with negative density or
internal energy

Waves, left ot right:

1. Fast rarefaction
2. Fast rarefaction

![Strong Rarefaction Image](/assets/img/2021-post-assets/11-November/Strong-rarefaction-Miniati-Martin-2011-fig-5.png)
*EinFeldt Strong Rarefaction at \\( t=0.16 \\). Source: Figure 5 from Miniati & Martin 2011[^charm]*

### Ryu & Jones Shock Tube 1a[^rj]

Ryu & Jones 1995 contains a wealth of different shock tubes and is an excellent
resource. Shock tube 1a has a fairly simple and easy to read set of 5 waves.
Does not include an Alfvên wave

Waves, left ot right:

1. Fast shock
2. Slow rarefaction
3. Contact discontinuity
4. Slow shock
5. Fast shock

![Ryu & Jones Image](/assets/img/2021-post-assets/11-November/Ryu-Jones-1995-fig-1a.png)
*Ryu & Jones Shock Tube at \\( t=0.08 \\). Source: Figure 1a from Ryu & Jones 1995 [^rj]*

### Ryu & Jones Shock Tube 2a[^rj]

Shock tube 2a has a fairly simple and easy to read set of 7 waves. Does include
an Alfvên wave.

Waves, left ot right:

1. Fast shock
2. Alfvên wave
3. Slow shock
4. Contact discontinuity
5. Slow shock
6. Alfvên wave
7. Fast shock

![Ryu & Jones Image](/assets/img/2021-post-assets/11-November/Ryu-Jones-1995-fig-2a.png)
*Ryu & Jones Shock Tube at \\( t=0.2 \\). Source: Figure 1a from Ryu & Jones 1995 [^rj]*

### Ryu & Jones Shock Tube 4d[^rj]

Shock Tube 4d features a switch-on slow rarefaction. Switch-on/off magnetosonic
waves cause the tangential magnetic field to turn on/off.

Waves, left ot right:

1. Hydrodynamic rarefaction
2. Switch on slow shock
3. Contact discontinuity
4. Slow Shock
5. Alfvên/Rotation wave
6. Fast rarefaction

![Ryu & Jones Image](/assets/img/2021-post-assets/11-November/Ryu-Jones-Miniati-Martin-2011-fig-4.png)
*Ryu & Jones Shock Tube at \\( t=0.16 \\). Source: Figure 4 from Miniati & Martin 2011[^charm]*

## Citations

[^charm]: Miniati, F., &#38; Martin, D. F. (2011). Constrained-transport
    magnetohydrodynamics with adaptive mesh refinement in CHARM. *Astrophysical
    Journal, Supplement Series*, *195*(1).
    [https://doi.org/10.1088/0067-0049/195/1/5](https://doi.org/10.1088/0067-0049/195/1/5)

[^bw]: Brio, M., &#38; Wv, C. C. (1988). An Upwind Differencing Scheme for
    the Equations of Ideal Magnetohydrodynamics. *JOURNAL OF COMPUTATIONAL
    PHYSICS*, *75*, 40–422.
    [https://ui.adsabs.harvard.edu/abs/1988JCoPh..75..400B/abstract](https://ui.adsabs.harvard.edu/abs/1988JCoPh..75..400B/abstract)

[^dw]: Dai, W., &#38; Woodward, P. R. (1998). ON THE DIVERGENCE-FREE
    CONDITION AND CONSERVATION LAWS IN NUMERICAL SIMULATIONS FOR SUPERSONIC
    MAGNETOHYDRODYNAMIC FLOWS. *THE ASTROPHYSICAL JOURNAL*, *494*, 317–335.
    [https://iopscience.iop.org/article/10.1086/305176/meta](https://iopscience.iop.org/article/10.1086/305176/meta)

[^rj]: Ryu, D., Jones, T. W., &#38; Frank, A. (1995). Numerical
    Magnetohydrodynamics in Astrophysics: Algorithm and Tests for
    Multi-Dimensional Flow 1. *The Astrophysical Journal*.
    [https://ui.adsabs.harvard.edu/abs/1995ApJ...442..228R/abstract](https://ui.adsabs.harvard.edu/abs/1995ApJ...442..228R/abstract)

[^fr]: Einfeldt, B., Munz, C. D., Roe, P. L., &#38; W green, B. (1991). On
    Godunov-Type Methods near Low Densities. *JOURNAL OF COMPUTATIONAL PHYSICS*,
    *92*, 213–295.
    [https://ui.adsabs.harvard.edu/abs/1991JCoPh..92..273E/abstract](https://ui.adsabs.harvard.edu/abs/1991JCoPh..92..273E/abstract)

[^hlld]: Miyoshi, T., &#38; Kusano, K. (2005). A multi-state HLL approximate
    Riemann solver for ideal magnetohydrodynamics. *Journal of Computational
    Physics*, *208*(1), 315–344.
    [https://doi.org/10.1016/j.jcp.2005.02.017](https://doi.org/10.1016/j.jcp.2005.02.017)

[^athena]: Stone, J. M., Gardiner, T. A., Teuben, P., Hawley, J. F., &#38;
    Simon, J. B. (2008). ATHENA: A NEW CODE FOR ASTROPHYSICAL MHD. *The
    Astrophysical Journal Supplement Series*, *178*, 137–177.
