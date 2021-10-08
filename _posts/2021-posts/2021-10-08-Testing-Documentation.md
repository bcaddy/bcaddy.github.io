---
title:      Testing Documentation                 # Title
author:     Robert Caddy               # Author Name
date:       2021-10-08 10:00:00 -0400  # Date
categories: [Cholla, Testing]     # Catagories, no more than 2
tags:       [Google Test, Framework, Documentation] # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Testing
I spent about half of this week writing, editing, and workshopping the
documentation for Cholla's new testing system. Along the way I found a few small
errors, mostly unclear naming, in the tests and fixed that.

I also started laying the groundwork for automated testing. This mostly meant
updating the OS of the machine we plan to use so that we can use GCC/G++ 10,
getting Cholla to build on it after, and adding the appropriate build
scripts to Cholla. I also worked on getting GoogleTest to build properly on that
machine but had to deal with the OS upgrade first.

# Other
- Lunch with my grad student mentees