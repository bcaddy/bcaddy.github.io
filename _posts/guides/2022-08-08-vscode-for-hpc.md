---
title:      Visual Studio Code for HPC and C++                 # Title
author:     Robert Caddy               # Author Name
date:       2022-08-08 11:16:11 -0400  # Date
categories: [VSC, Guide]     # Catagories, no more than 2
tags:       [C++, VSC, HPC, Cluster]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Intro to Visual Studio Code for C++ and HPC

## IDE vs. Text Editor vs. "Inline" Text Editor

- "Inline" Text Editors: vi/vim, emacs, pico/nano. Great for quick edits in the terminal. Extensible but often tricky to extend and offer limited functionality. They are there to edit text

- Text Editors: Sublime, Notepad, VS Code, Atom, etc. Usually stand alone applications with a CLI. They offer dramatically varying levels of extensability from effectively none to becoming essentially full IDEs

- IDEs: CLion, Spyder, PyCharm, Eclipse, Visual Studio etc. These applications lots of other features besides just text editing and are often language specific. Typical IDEs have comprehensive syntax highlighting, advanced, project wide, auto-complete, build tools, debugging, refactoring, linters, version control integration, code introspection (class browser, inheritance diagrams, etc), project wide searching, etc. Generally IDEs offer a more complete and holistic programming environment compared to just a standard text editor

Which one of these you choose to use depends on your use case and personal preference. Likely a mixture of all three will be required.

## Why VS Code?

- First, VS Code, Visual Studio for Windows, and Visual Studio for MacOS are not the same thing. VS for Windows in an excellent IDE...that only works on windows. VS on Mac is a totally unrelated IDE (basically Microsoft bought another IDE and reskinned it). VS for windows has solid CUDA support, VS for mac doesn't. VS Code is an highly extensible text editor

- With the right combination of packages VS Code can become essentially a full IDE for most languages, even multiple languages, though there can be a significant learning curve

## VS Code Features

- The command palette (shift+cmd+P) lets you search through all the available commands
  - cmd+P lets you search through the project. Also just backspacing to remove the `>` in the command palette works
- Keyboard shortcuts: So many, just takes time, can be replaced with vim style shortcuts
- Code folding
- Git integration
  - Git lens, line by line blame etc
  - Git tree
- snippets
- multi-cursor
- Zen mode - clears out distractions, more screen real estate
- debugging
  - [Using C++ on Linux in VS Code](https://code.visualstudio.com/docs/cpp/config-linux)
  - [Configuring C/C++ debugging](https://code.visualstudio.com/docs/cpp/launch-json-reference)
  - [Debug C++ in Visual Studio Code](https://code.visualstudio.com/docs/cpp/cpp-debug)
  - [Pretty printing with GDB](https://sourceware.org/gdb/wiki/STLSupport)
- linter through Intellisense
  - Problems Panel
- Outline Panel
- Refactor (rename symbol)
- Built in terminal
- **SO. MANY. MORE.** tldr: If you want VS Code to do something either it can or there is an extension for it

## Recommended Extensions

- Find a theme you like. There are hundreds, just google around for good VS Code themes and you will find something. (Recommend *An Old Hope Theme*, *Bear Theme*, *Material Theme*, *Material Icon Theme*) [Tweak themes](https://code.visualstudio.com/docs/getstarted/themes#_customizing-a-color-theme) or [Theme Color](https://code.visualstudio.com/api/references/theme-color)
- Bash IDE - Or whatever shell you use
- Better Align - for aligning code to make it pretty
- Prettier - Code beautifier
- Better Comments - Highlights comments very well. Includes highlighting for `TODO`, `FIXME` etc
- ~~Bracket Pair Colorizer~~ - Colors bracket pairs for readability, highly recommended. _**Now included in VS Code**_
- C/C++ -  Everything you need for those languages, includes intellisense. This is a must
- Clipboard Ring - multiple clipboards
- Code Spell Checker - A spell checker, takes a little bit of setting up but is excellent
- Doxygen - Language support
- Doxygen Documentation Generator - Helps automatically generate Doxygen documentation
- Git Graph & Git Lens - Excellent Git integration. Much better than VS Code default
- LaTeX language support
- Live Share - Enables sharing and collaborating live, this could make collaborating long distance way easier
- Markdown All in One - Markdown support
- Python
- Python Docstring Generator
- Remote - Allows remote development, lots of subpackages, just install them all
- ~~Settings Sync - Sync settings across machines~~ This is now a feature in core VSC
- snippet-creator - Simplifies making snippets
- Todo Tree - Shows TODO, FIXME, et in tree view
- Trailing Spaces - Helps strip trailing spaces
- vscode-cudacpp - Eh, works ok, best we've got
- Better Comments
- Bookmarks
- C-mantic
- Clang-tidy
- Code Spell Checker
- Edit csv
- Error Lens
- Jupyter - Jupyter Notebook Support
- Jupyter Keymap
- Jupyter Notebook Renderers
- Nsight Visual Studio Code Edition
- vscode-pdf

## Useful Resources and Links

- [Microsofts VS Code docs are excellent](https://code.visualstudio.com/docs)
- [r/vscode wiki](https://www.reddit.com/r/vscode/wiki/index#wiki_vs_code_wiki)
- [Visual Studio Code Tips & Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
- [From vim to Visual Studio Code](https://blog.questionable.services/article/from-vim-to-vscode/)
- [My Top 8 Visual Studio Code Tips and Features](https://scotch.io/bar-talk/my-top-8-visual-studio-code-tips-and-features)
- [Best of Visual Studio Code: Features, Plugins, Acting Like Atom and Sublime](https://scotch.io/tutorials/best-of-visual-studio-code-features-plugins-acting-like-atom-and-sublime#toc-document-this)
- [Data Science in Visual Studio Code](https://code.visualstudio.com/docs/python/data-science-tutorial)

## Other Topics

### Useful links

- [LSST C++ Style Guide](https://developer.lsst.io/cpp/api-docs.html#boilerplate-for-header-h-and-source-cc-files)
- [Always Squash and Rebase your Git Commits](https://blog.carbonfive.com/always-squash-and-rebase-your-git-commits/)

### Dotfiles Organization

You might find that your settings files, such as `.bashrc`, `.gitconfig`, `.pythonrc`, etc. can become difficult to manage or keep synced between computers; these files are also called "dotfiles" since their names usually start with a period. To help manage these more effectively I highly recommend you put them all in a git repo and then link those files to the appropriate location. There are many repos out there that will help you do exactly that but I've found that many of them are too complex to easily use and don't always work well when you might have to work on multiple different systems/clusters. With the help of my friend [Seth Cook](https://github.com/MacaroonCookie) I wrote a system for managing my dotfiles which you can find in my [dotfiles-skeleton](https://github.com/bcaddy/dotfiles-skeleton) repo. That repo contains all the documentation required to get up and running with managing your dotfiles, simply fork the repo, add your dotfiles, and start working. I periodically update the skeleton repo with any major changes in my private dotfiles repo.


### Usefull Command Line Tools

- `Homebrew`/`Macports` - package managers
- `ack` - better, easier searching than `grep`
- `sl` - Who doesn't like Steam Locomotives?
- `tree` - Displays all files in a directory recursively with a nice tree view

### What Terminal to use?

- On MacOS I use iTerm2
