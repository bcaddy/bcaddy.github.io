---
title:      Defense Prep & Paper Edits                 # Title
author:     Robert Caddy               # Author Name
date:       2024-03-29 12:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Paper Edits, Scaling Tests]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Defense Prep

I spent most of this week prepping for my defense: editing my dissertation, presentation, etc.

## Paper Revisions

The requested revisions of my paper are pretty much done. I need to investigate using Zenodo and that's pretty much it.

## Strong Scaling Tests

I ran some strong scaling tests on Frontier. I scaled a \\\( 459^3 \\) cell simulation (the largest I could fit on one GPU) from 1 GPU to 4096 GPUs. Typically we wouldn't go smaller than \\( 128^3 \\) cells on a single GPU which is roughly at the 64 GPU point on this plot.

![Monotonized version](/assets/img/2024-post-assets/2024-03-29-scaling_test_strong.pdf)
