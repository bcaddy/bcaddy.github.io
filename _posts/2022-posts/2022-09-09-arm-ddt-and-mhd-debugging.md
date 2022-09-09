---
title:      Arm DDT and MHD Debugging                 # Title
author:     Robert Caddy               # Author Name
date:       2022-09-09 14:40:57 -0400  # Date
categories: [Tools, MHD]     # Catagories, no more than 2
tags:       [Debugging, Debuggers, Arm Forge, MHD]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Arm DDT

With help some nice folks at Arm I figured out how to display device arrays in
host code, see [this post]({% post_url guides/2022-09-08-arm-ddt-with-gpus%})
for details.

In preparation for presenting on Arm Forge next week I submitted two PRs
([#187](https://github.com/cholla-hydro/cholla/pull/187) and
[#188](https://github.com/cholla-hydro/cholla/pull/188)) so that the main and
dev branches were always using the C++ version we wanted and so that debug
builds would work with the debugger.

## MHD Debugging

Now that we have a good debugger I spent some time removing the debugging
instrumentation from the MHD code. In the process I found one bug in the
magnetic field update kernel and a broken test, both have been fixed.
