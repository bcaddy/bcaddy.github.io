---
title:      HLLD Debugging & Automated Testing Setup                 # Title
author:     Robert Caddy               # Author Name
date:       2023-01-27 15:18:24 -0400  # Date
categories: [HLLD, Testing]     # Catagories, no more than 2
tags:       [Automated Testing]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Automated Testing

I spent about half of this week getting automated testing working with Jenkins.
I had some issues with clang-tidy's header filtering not working properly but
after that it was mostly tweaking to get it to all behave properly. It's mostly
ready, I'm just waiting on the GitHub API limits to be raised and to do some
final checks on using the tests as a PR gate.

## HLLD Debugging

I found some small discrepancies in Cholla's HLLD solver compared to Athena's. I
managed to track down that at least a few were due to the different order of
operations for the Athena vs. Cholla solver. I'm working to see if all of the
issues are just that or if there's something more at play. During this I had
found that the HLLD solver needs a refactor as it's too verbose currently. I'm
refactoring it to use structs for most of it's data so that I'm not passing
around dozens of variables. So far it's going well and will let me debug and
tweak the solver more easily.

## Other

- Moved all my various to do lists over to GitHub Project under the Cholla umbrella.
