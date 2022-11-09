---
title:      MHD Test Problems            # Title
author:     Robert Caddy               # Author Name
date:       2022-10-17 10:10:09 -0400  # Date
categories: [MHD, Guide]     # Catagories, no more than 2
tags:       [Linear Waves, HLLD]       # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Summary

This is a repository of some MHD test problems. Most of them are taken from
Athena++ and [Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract)

## Linear Waves

I'll be using the wave tests from Athena++ which are detailed in
[Gardiner & Stone 2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract).
The initial conditions are given by

$$
    \vec{U} = \vec{\bar{U}} + A \vec{R_k} \cos\left(\frac{2\pi x}{\lambda}\right).
$$

Where \\( \vec{U} \\) is the initial condition in conserved variables and
follows the usual density, momentum, magnetic field, energy ordering,
\\(\vec{\bar{U}} \\) is the constant background state that is being pertubed by
the wave, \\( A \\) is the amplitude of the wave/perturbation, \\( R_k \\) is
the right eigenvector and depends on the wave, \\( x \\) is the position in
space and \\( \lambda \\) is the wavelength; \\(\lambda = 1 \\) for the initial conditions and waves listed here. Magnetic fields will have to be implemented slightly differently than the
other components because they're at slightly different positions (cell faces
rather than centers). \\( R_k \\) is in conserved variables with the order
\\( \left( \rho, \rho v_1, \rho v_2, \rho v_3, B_1, B_2, B_3, E \right) \\)

Here are the values of the parameters

$$
    A = 10^{-6}
$$

In primitive variable \\( \vec{\bar{U}} \\) is

$$
    \vec{\bar{U}}_{primitive} =
        \begin{bmatrix}
            \rho \\
            P \\
            v_x \\
            v_y \\
            v_z \\
            B_x \\
            B_y \\
            B_z
         \end{bmatrix}
         =
         \begin{bmatrix}
            1 \\
            1/\gamma \\
            0 \text{(or 1 for the contact/entropy wave)} \\
            0 \\
            0 \\
            1 \\
            3/2 \\
            0
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for fast magnetosonic waves with \\( c_f = 2 \\)

$$
    \vec{R}_{\pm c_f} = \frac{1}{2\sqrt{5}}
        \begin{bmatrix}
            2 \\
            \pm 4 \\
            \mp 2 \\
            0 \\
            0 \\
            4 \\
            0 \\
            9
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for slow magnetosonic waves with \\( c_s = 0.5 \\)

$$
    \vec{R}_{\pm c_s} = \frac{1}{2\sqrt{5}}
        \begin{bmatrix}
            4 \\
            \pm 2 \\
            \pm 4 \\
            0 \\
            0 \\
            -2 \\
            0 \\
            3
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for Alfvén waves with \\( c_a = 1 \\)

$$
    \vec{R}_{\pm c_a} =
        \begin{bmatrix}
            0 \\
            0 \\
            0 \\
            \mp 1 \\
            0 \\
            0 \\
            1 \\
            0
        \end{bmatrix}.
$$

\\( \vec{R}_k \\) for contact/entropy waves, make sure to set \\( v_x=1 \\) in
\\( \vec{\bar{U}} \\) for this wave, with \\( c_c = v_x \\)

$$
    \vec{R}_{\pm c_c} = \frac{1}{2}
        \begin{bmatrix}
            2 \\
            2 \\
            0 \\
            0 \\
            0 \\
            0 \\
            0 \\
            1
        \end{bmatrix}.
$$

### Rotated Linear Waves

[Gardiner & Stone
2008](https://ui.adsabs.harvard.edu/abs/2008JCoPh.227.4123G/abstract) use the
following rotation for rotated waves. \\( \alpha \\) is the pitch angle (rotation about \\( y \\))  and \\(
\beta \\) is the yaw angle (rotation about \\( z \\)).

$$
        \begin{bmatrix}
            x \\
            y \\
            z
         \end{bmatrix}
         =
         \begin{bmatrix}
            x_1 \cos{\alpha} \cos{\beta} - x_2 \sin{\beta} - x_3 \sin{\alpha} \cos{\beta} \\
            x_1 \cos{\alpha} \sin{\beta} - x_2 \cos{\beta} - x_3 \sin{\alpha} \sin{\beta}\\
            x_1 \sin{\alpha} - x_3 \cos{\alpha}
         \end{bmatrix}.
$$

At an angle where \\( \sin{\alpha} = 2/3 \\) and \\( \sin{\beta} = 2/\sqrt{5}
\\) Stone & Gardiner use a domain of \\( 0 \leqslant x \leqslant 3.0 \\), \\( 0
\leqslant y \leqslant 1.5 \\), and \\( 0 \leqslant z \leqslant 1.5 \\)

## MHD Riemann Problems

See the [MHD Riemann Problems]({% post_url
guides/2021-11-19-MHD-Riemann-Problems %}) post for info on MHD Riemann Problems.
