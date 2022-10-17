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


Still working on bug hunting. I tested a bunch of different things and finally
found the bug that was causing the \\( B_x \\) field to update. There was a
copy/paste error in the CT field calculations and I was using the wrong velocity
for one of the upwinding steps. My next step is going to be trying out simple
waves. I'll be using the wave tests from ATHENA++ which are detailed in
[Gardiner & Stone 2005](https://arxiv.org/abs/astro-ph/0501557). The initial conditions are given by

$$
    \vec{U} = \vec{\bar{U}} + A \vec{R_k} \cos\left(2\pi x\right).
$$

Where \\( \vec{U} \\) is the initial condition in conserved variables and
follows the usual density, momentum, magnetic field, energy ordering,
\\(\vec{\bar{U}} \\) is the constant background state that is being pertubed by
the wave, \\( A \\) is the amplitude of the wave/perturbation, \\( R_k \\) is
the right eigenvector and depends on the wave, and \\( x \\) is the position in
space. Magnetic fields will have to be implemented slightly differently than the
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
            \sqrt{2} \\
            1/2
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for fast magnetosonic waves with \\( c_f = 2 \\)

$$
    \vec{R}_{\pm c_f} = \frac{1}{6\sqrt{5}}
        \begin{bmatrix}
            6 \\
            \pm 12 \\
            \mp 4 \sqrt{2} \\
            \mp 2 \\
            0 \\
            8 \sqrt{2} \\
            4 \\
            27
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for slow magnetosonic waves with \\( c_s = 0.5 \\)

$$
    \vec{R}_{\pm c_s} = \frac{1}{6\sqrt{5}}
        \begin{bmatrix}
            12 \\
            \pm 6 \\
            \pm 8 \sqrt{2} \\
            \pm 4 \\
            0 \\
            -4 \sqrt{2} \\
            -2 \\
            9
         \end{bmatrix}.
$$

\\( \vec{R}_k \\) for Alfvén waves with \\( c_a = 1 \\)

$$
    \vec{R}_{\pm c_a} = \frac{1}{3}
        \begin{bmatrix}
            0 \\
            0 \\
            \pm 1 \\
            \mp 2\sqrt{2} \\
            0 \\
            -1 \\
            2 \sqrt{2} \\
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