---
title:      Defense Presentation & Paper Edits                 # Title
author:     Robert Caddy               # Author Name
date:       2024-03-22 12:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Edits, Scaling Tests]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Defense Presentation

I spent a couple days this week working on my defense presentation. I think it's mostly ready and will be practising it with some people soon.

## Paper Edits

I'm working my way through the reviewer comments and I'm mostly through them, nothing too dramatic and their suggestions will definitely improve the paper.

I also created new scaling plots with the fused PCM version of Cholla and did performance checks on single V100 and A100 GPUs. The V100 achieved 160 million cell updates per second, the A100 achieved 259 million cell updates per second, and the MI250X single GCD got 236 million cell updates per second.

![Monotonized version](/assets/img/2024-post-assets/2024-03-22-scaling_tests_cells_per_second.pdf)
