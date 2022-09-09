---
title:      Arm DDT with GPUs                 # Title
author:     Robert Caddy               # Author Name
date:       2022-09-08 11:53:28 -0400  # Date
categories: [Arm DDT, Guides]     # Catagories, no more than 2
tags:       [Debugger, Debugging]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Debugging GPU Codes with Arm DDT

See the [Arm Forge User Guide](https://developer.arm.com/documentation/#f[navigationhierarchiescontenttype]=User%20Guide&cf[navigationhierarchiesproducts]=%20Tools%20and%20Software,Server%20and%20HPC,Arm%20Architecture%20tools,Arm%20HPC%20products,Arm%20Forge) for all the info, this is just a place for some notes and tips

- Use `-g -O0` to compile host code and `-g -G -cudart shared` to compile device
  code. The `-g -G` enable debugging symbols and `-cudart shared` enable device
  memory debugging.
- A device pointer's contents can be accessed by preappending `@global` to its
  type. A permanant version of this can be done with expressions.
  - `((@global TYPE *)(VARIABLE_NAME)` to get the proper pointer
  - `((@global TYPE *)(VARIABLE_NAME)[IDX]` to get the value at `IDX`
  - `((@global TYPE *)(VARIABLE_NAME)[IDX]@N` to get `N` values starting at `IDX`
- The expressions panel; can also be used for any other debugging or math
  expression you want
