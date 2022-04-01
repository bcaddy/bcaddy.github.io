---
title:      Constrained Transport EMF Kernel 2   # Title
author:     Robert Caddy               # Author Name
date:       2022-04-01 17:00:00 -0400  # Date
categories: [Cholla, MHD]     # Catagories, no more than 2
tags:       [Constrained Transport, VL+CT, Van Leer]  # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       true                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Constrained Transport Electric Fields

I finally figured out the CT electric fields/EMF this week. I spent the first
two days reading papers and discussing it with my advisor and then got to
implementing the CUDA kernel. I've got a first draft of the kernel done but it
needs some tweaks and tests before it's done. As it stands every single slope is
written out entirely, effectively duplicating the same slope code 48 times. Next
week I plan on writing some tests for this kernel then refactoring it to use
device functions so that the code is more easily worked with and clearer.

I also recreated some figures from
[Stone et al. 2008](https://iopscience.iop.org/article/10.1086/588755/pdf)
to help me visualize the CT electric fields and their slopes. Those figures can
be found in section 3 of my
[VL+CT Algorithm]({% post_url 2021-posts/2021-01-06-VL+CT-Algorithm%})
blog post.

## Other

- Read more of [Beck 2015](https://ui.adsabs.harvard.edu/abs/2015A%26ARv..24....4B/abstract)

## Links

- [VL+CT Algorithm]({% post_url 2021-posts/2021-01-06-VL+CT-Algorithm%})
- [HLLD Algorithm]({% post_url 2020-posts/2020-10-23-HLLD-Algorithm%})
