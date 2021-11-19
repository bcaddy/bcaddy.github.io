---
title:      Particle Debugging & MHD Prep        # Title
author:     Robert Caddy               # Author Name
date:       2021-11-19 13:45:00 -0400  # Date
categories: [MHD, Testing]     # Catagories, no more than 2
tags:       [Testing, Particles, HLLD] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Particle System Tests

I finished hunting (I hope) all the particle related bugs in the system test
runner class and found some bugs with how particle IDs are currently implemented
in Cholla. So I submitted a PR and got my stuff merged into Cholla and will do
more thorough testing once Cholla supports global particle IDs on GPUs.

## MHD Prep

I'm now preparing to implement MHD into Cholla, starting with the HLLD solver.
To this end I spent some time reviewing the HLLD solver, and Riemann Solvers in
general, wrote a bunch of the boilerplate code that MHD will require, updated my
[MHD GitHub Issue](https://github.com/bcaddy/cholla/issues/2) with current
plans, and started prepping testing for the future HLLD solver.

Getting known correct data from the HLLD algorithm is tricky since it's not
exact so we can't rely on analytic results; therefore I need a known good HLLD
solver to compare with my HLLD solver. I extracted the HLLD solver from
Athena[^1] and built a program to call it with different values and print the
results at full precision. To find reasonable inputs I decided to use values
from various MHD Riemann problems and so researched and wrote a blog post on
them:
[MHD Riemann Problems]({% post_url 2021-posts/2021-11-19-MHD-Riemann-Problems %}).
Next week I plan to use Athena++ to simulate all the Riemann problems then use
L/R values that span each wave as my test cases. The extracted HLLD solver,
results from Athena++, and analysis notebook can all be found on in my
[hydro sandbox](https://github.com/bcaddy/hydro-sandbox/tree/main/Athena-Code).

## Other

- Reading more of the [Decadal Survey](https://www.nationalacademies.org/our-work/decadal-survey-on-astronomy-and-astrophysics-2020-astro2020)

### Footnotes

[^1]: I used the older Athena HLLD solver since Athena++'s HLLD solver is much
    more tightly integrated and depends on many different classes that I didn't
    want to risk trying to mock up. The Athena HLLD solver is less tightly
    integrated and I could easily mock or copy the structs and functions
    required.
