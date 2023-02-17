---
title:      Debugging & Frontier Workshop                 # Title
author:     Robert Caddy               # Author Name
date:       2023-02-17 11:35:42 -0400  # Date
categories: [MHD]     # Catagories, no more than 2
tags:       [Frontier, Debugging, Workshop]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## MHD Debugging

I found the issue I was struggling with last week with some help from Alwin Mao.
It turns out that since MHD is face centered it needs the ghost cell closest to
the grid to always had physical values and the diode in the outflow boundary
conditions causes some values that are physical for pure hydro but not MHD.
Disabling the diode for MHD fixed the issue
([PR #252](https://github.com/cholla-hydro/cholla/pull/252)).

The Ryu & Jones 1a shock tube has a weird extra wave in the middle still. I'm
working on hunting down that issue and am making progress but haven't found it
yet. It also seems to coincide with some noise in the \\( B_z \\) field so I'm
working on tracing where that comes from

## Clang-tidy Checks

While investigating the failing `bugprone-signed-char-misuse` check I found that
our sole C language file's contents are unused so we can remove that file and
all the build infrastructure for C. I opened an issue about it and plan to fix
it during our next hack session
([Issue #253](https://github.com/cholla-hydro/cholla/issues/253)).

## Frontier Training Workshop

I've also been attending the
[Frontier Training Workshop](https://www.olcf.ornl.gov/calendar/frontier-training-workshop-february-2023/)
most of the week.
