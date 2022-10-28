---
title:      Linear Waves and Best Practices                 # Title
author:     Robert Caddy               # Author Name
date:       2022-10-28 14:50:31 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Debugging, Best Practices, Scientific Software]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Linear Wave Debugging

I finished linear wave tests, they needed a bit of polishing. With some help I
discovered that the perturbations I was seeing in the Alfven wave tests weren't
an issue since they also appear in Athena++. The fast magnetosonic and contact
waves are both correct as well now. The slow magnetosonic wave might be working
but there appear to be some issues in the initial conditions so I'm not sure
yet.

MHD also passes hydro wave tests and the Sod shock tube.

## Scientific Software Best Practices

I presented on scientific software best practices based off of:

- [Wilson et al. 2014](https://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.1001745&type=printable)
- [Wilson et al. 2017](https://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1005510&type=printable)
- [*Software Engineering's Greatest Hits*](https://www.youtube.com/watch?v=HrVtA-ue-x0) by Greg Wilson of Wilson et al.

<!-- They're all very well done and I highly recommend them. Wilson et al. 2014 discusses best practices in general with a focus on larger/community codes. Wilson et al. 2017 has a lot of specifics, discussion of best practices for data and paper writing, and is focussed more on smaller codes (lab and personal codes). *Software Engineering's Greatest Hits* is a really intersting discussion of what we empirically know about software development. -->

## Other

- Solved ROCm bug [ROCm issue
  \#1842](https://github.com/RadeonOpenCompute/ROCm/issues/1842). I was using
  the wrong function. The correct function wasn't documented. Shout out to Damon
  McDougall for finding the issue.
- Update website to v5.3.1
- Fix some typos in the [HLLD Algorithm post]({% post_url
  guides/2020-10-23-HLLD-Algorithm %})
- Read [The Circumgalactic
  Medium](https://www.annualreviews.org/doi/10.1146/annurev-astro-091916-055240)
  by Tumlinson et al. 2017 for class
