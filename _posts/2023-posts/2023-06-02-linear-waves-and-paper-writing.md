---
title:      Linear Waves & Paper Writing                 # Title
author:     Robert Caddy               # Author Name
date:       2023-06-02 14:29:04 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Writing, Debugging, Linear Waves]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Linear Wave Initial Conditions

I spent quite awhile this week trying to debug the linear wave initial conditions to get rid of the oscillation to no avail. Since the initialization from the vector potential is only required for off axis waves and those aren't required to prove correctness I'm initializing the magnetic field directly for now and just limiting it to on axis waves only. The fixes are added to my PPM PR, [PR #300](https://github.com/cholla-hydro/cholla/pull/300).

## MHD Code Paper

I started on making figures this week and edited the methods section to reword if from a blog post to a scientific paper. I also set up some tools to automatically link to the version of the python script used to generate a figure with the LaTeX paper.