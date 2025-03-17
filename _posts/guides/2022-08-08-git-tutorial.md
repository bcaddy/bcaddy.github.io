---
title:      Git Tutorial                 # Title
author:     Robert Caddy               # Author Name
date:       2022-08-08 11:15:34 -0400  # Date
categories: [Git, Guides]     # Catagories, no more than 2
tags:       []                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# Intro to Git and GitHub

## General Structure

1. Setup and Install
2. Creating new repos
3. Repository History & Introspection
4. Git Config & Aliases
5. Committing
6. Workflow & Branching
7. Assorted Useful Git Commands
8. Other

## 1. Setup

### Installing Git

#### macOS

1. Install Homebrew with `/bin/bash -c "$(curl -fsSL
   https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
   - If you use macports or something else then use that to install git
2. Install git with `brew install git`
3. Check that git is installed with `git --version`, this guide uses some
   features that were implemented after git 2.3.10 so make sure you have at
   least that version

#### Linux

Very similar to the macOS install but you'll need to use whichever package
manager is present for your distro.

#### Windows

I personally haven't done this. I recommend you look into the Windows Subsystem
for Linux (WSL) for your git and HPC needs

- [What is the Windows Subsystem for Linux?](https://docs.microsoft.com/en-us/windows/wsl/about)
- [Get started using Git on Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)

### Register for GitHub

Follow the instructions to
[sign up for GitHub](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home).
Note that as a student/researcher you can get free GitHub Pro by filling out the
application [here](https://education.github.com/discount_requests/student_application).

I encourage you to
[setup SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
for connecting with GitHub. If you want to digitally sign your commits to show
that they're from you then you can follow the instructions I've written
[here](https://github.com/bcaddy/dotfiles-skeleton/blob/master/How-To-Guides/GPG%20setup.md),
this is entirely optional.

## 2. Creating a New Repo

*[GitHub Documentation](https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/adding-an-existing-project-to-github-using-the-command-line)*

1. Run `git init -b main`
   - `-b main` is optional, it sets the primary branch name to `main` instead of
     `master`. You can make all your git repos default to this by settting
     ```
     [init]
         defaultBranch =  main
     ```
     in your gitconfig file
2. Run `git add .` to prepare all the files in the current directory for
   committing. You can replace the dot with a space seperated list of filenames
   if you would prefer
3. Commit the changes with `git commit -m "message"`. You can also omit the `-m
   "message"` and write your commit message in the dialog box that opens, then
   save and exit, that will commit your changes.
4. Go to GitHub and create a new repo with the same name as your directory then
   ```bash
   # Set the new remote
   $ git remote add origin  <REMOTE_URL>
   # Verify the new remote URL
   $ git remote -v
   # Push to new remote. This is how you push any branch to the remote and set
   # it as an upstream branch
   git push -u origin main
   ```

### Notes

- You can add multiple origins, usefull if you're managing a complex structure of repos and their forks like many PIs are.

## 3. Committing & Branches

### Committing

Git is built around "committing" code and changes. Any time you change
something, add a new file, etc. you can then commit that file/change to add it
to repository history. Choose which things you want to commit you must first run
`git add <files/pattern>` to prepare whichever files you want for committing then commit
those files with `git commit -m "message"` or `git commit`.

### Git Message Structure

There are some best practices for git commit messages. GitHub gives some line
length limitations for optimal display which are noted in the template message
below.
[Here's a good guide](https://medium.com/@corrodedlotus/which-tense-should-be-used-on-a-git-commit-message-121cb641134b)
on general structure and ideas for writing good commit messages. There are also
some good tools that can help with structure and automation such as
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

At the end of the message you can add [git
trailers](https://git-scm.com/docs/git-interpret-trailers) if you want. They
provide an easy, machine readable, way to add metadata to your commits about
other people who were involved in the creation of the commit. Common examples
would be people who coauthored, provided minor assistance, brought an issue to
your attention, etc.

Personally I use the [Conventional
Commits](https://www.conventionalcommits.org/en/v1.0.0/) format and have found
it to be very easy to use and clear after I got used to it. If you don't want to
do that however make sure that each commit title answers the questions "If
applied, this commit will..." and as long as you're consistent with your team,
clear, and concise it doesn't matter a ton what you choose.

You can setup a commit message
template by adding the following lines to your `.gitconfig` file.

```
[commit]
    template = /path/to/template/git-message-template.txt
```

My commit message template has notes on how to use Conventional Commits, git
trailers, and some info on keywords for GitHub. It's fairly extensive but it
means that I have notes on all commit message related things right in front of
me whenever I'm writing a commit message.

```
# Template documentation is at the end
# ================================================
# If applied, this commit will...    (soft limit ↓)        (hard limit ↓)
# <type>[(scope)][!]: <description>              |                     |


# Why is this change needed?                                           |


# Footers/git trailers (Trailers should have 2 newlines before them)   |
#BREAKING CHANGE:

# ======================================================================
# Documentation
# ======================================================================
# ==============
# Summary
# ==============
# This template is for Conventional Commit messages. Sections in <> are
# required and sections in [] are optional. Including the ! in the
# header indicates a breaking change.
#
# The only exception is the git trailers which reference another git
# user. That git user's email should be inside a pair of angled brackets
# like <name@email.com>.

# ==============
# Commit types (from https://github.com/pvdlg/conventional-changelog-metahub)
# ==============
# | Commit Type | Title                    | Description                                                                                                 |
# |:-----------:|--------------------------|-------------------------------------------------------------------------------------------------------------|
# |   `feat`    | Features                 | A new feature                                                                                               |
# |    `fix`    | Bug Fixes                | A bug Fix                                                                                                   |
# |   `docs`    | Documentation            | Documentation only changes                                                                                  |
# |   `style`   | Styles                   | Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)      |
# | `refactor`  | Code Refactoring         | A code change that neither fixes a bug nor adds a feature                                                   |
# |   `perf`    | Performance Improvements | A code change that improves performance                                                                     |
# |   `test`    | Tests                    | Adding missing tests or correcting existing tests                                                           |
# |   `build`   | Builds                   | Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)         |
# |    `ci`     | Continuous Integrations  | Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs) |
# |   `chore`   | Chores                   | Other changes that don't modify src or test files                                                           |
# |  `revert`   | Reverts                  | Reverts a previous commit                                                                                   |

# ==============
# Git Trailers
# ==============
# Should be of the format `TRAILER: Full Name <email@domain.extension>`
# with 2 newlines before the trailer
# | Trailer         | Description                                                          |
# |:---------------:|----------------------------------------------------------------------|
# | Co-authored-by: | They helped in detail with this patch. Confirmed supported by GitHub |
# | Helped-by:      | They helped without providing exact details                          |
# | Suggested-by:   | The person who suggested the patch                                   |
# | Acked-by:       | Someone more familiar with the area approves of this patch           |
# | Reported-by:    | Credit person who found the but that this patch fixes                |
# | Tested-by:      | Tested by this person                                                |
# | Signed-off-by:  | Signed off by this person. Usually used to agree to the license      |
# | Reviewed-by:    | Indicates the person has carefully reviewed this patch               |

# ==============
# Referencing/Closing GitHub issues/PRs
# ==============
# Specific issues and PRs can be referenced and automatically closed
# with the following keywords anywhere in the commit. There are NOT
# footers. To close multiple each issue must be prefaced with a keyword.
#
# Keywords:
#   - Resolve/Resolves/Resolved #X
#   - Fix/Fixes/Fixed #X
#   - Close/Closes/Closed #X

# ==============
# Line Length
# ==============
# The title line should be soft limited and 50 characters and hard
# limited at 72 characters. Lines in the body should be wrapped at 72
# characters. These limits were chosen partly due to convention
# (50/72 formatting) and due to the fact that GitHub likes to add
# ellipses to lines longer than 72 characters
# The 50 and 72 character limits are indicated with a '|' in each prompt
```

### Modifying Commit Messages

`git commit --amend` lets you edit the last commit message. If you've already
pushed that commit you'll need to force push the change. Editing commit messages
for older commits is doable but much more complex, look up a guide if you need
to do this.

### Branches

Git branches are the main organizational tool for git and their uses are many and varied. Branches are to complex to be simply summarized in a few lines in this document so I'll refer you to the [Atlassion documentation on branches](https://www.atlassian.com/git/tutorials/using-branches) and provide a [Git Branches cheatsheet](https://devhints.io/git-branch) that I use regularly.

Branches should generally be short lived: make a branch, add a small feature, merge the branch, then get rid of it. Long lived branches can be difficult to rebase. Once a feature branch has been merged it shouldn't be used again. Using an already merged branch can be complex

## 4. Repository History & Introspection

### Git Status

`git status` you will use all the time to check the status of a repo. Shows
current status of rebases, merges, staged files, unstaged files, tracked files,
etc. Has flags for targeting specific branches, what info is displayed, etc.

### Git Log

- `git log` shows lots of info but it isn't organized super well.
- `git log --oneline --decorate --graph --all` gives a prettier picture.
- `git show SHA` gives all the details on a specific commit

### Git Blame

`git blame` is used for checking who  made what modification to your code. Just
use GitLens for VS Code or GitHub.

### Git Diff

`git diff` shows all the differences between the *unstaged* changes and the previous commit + staged changes.

### Visual Studio Code (VSC) Extentions

- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens), a million amazing features. Just install it asap. Theres a paid version with a few more features but it's free for public repos so you should sign up.
- [Git
  Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph),
  A very clean and usable graph of the history of the repo. An improved version
  of `git log --oneline --graph`. GitLens now has a similar feature, though I
  prefer the Git Graph version; that's entirely a personal preference.
- Diffs and merge conflicts are much simplier

### Searching

#### VS Code

VS Code has a great search pane that I use most of the time when I have VS Code
open in the directory that I'm searching. It allows easy find and replace with
reasonably sophisticated search tools.

#### [Ack](https://beyondgrep.com)

I use Ack when I don't have VS Code open or if I need to parse many, many files
and VS Code would be too slow. Ack is a simple tool for recursively searching
text files. General usage is just `ack "pattern"` and it will recuresivley
search for the pattern while ignoring common VCS directories, binaries, etc. My
alias for it is:
```bash
alias ack='ack --ignore-dir={_site,.git,.container,._site} --ignore-case --literal'
```

[Why use Ack?](https://beyondgrep.com/why-ack/)

1. fast
2. portable
3. easier than grep
4. Ignores the files and directories you probably don't want to search
5. easy to specify file type with `--language`. e.g. `--cpp` or `--python`
6. pretty colors and good output formatting
7. Perl Regex
8. Similar flags to grep

## 5. Git Configuration Files

### `.gitconfig`

Your global settings for git are stored in the file `.gitconfig` in your home
directory. You can also have settings on a per repo basis but I haven't
personally had much need for that. Inside your `.gitconfig` is information
identifying who is making commits, what editor they're using, etc.

Probably the most complex use of `.gitconfig` is aliases. You can set up aliases
for git the same way you can with bash or any other shell. This can enable you
to either shorten commands that you use often or make long, complex commands
faster and more reliable to use. My `.gitconfig` is below with comments
describing the more complicated things.

```
[core]
  editor = nano
  whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
[init]
  defaultBranch = main
[user]
  name = Bob Caddy
  email = rcaddy@princeton.edu
  username = bcaddy # My GitHub Username
[github]
  user = bcaddy
  token = token
[commit]
  template = ~/dotfiles/git-message-template.txt
[pull]
  rebase = false
[filter "lfs"]
  clean = git-lfs clean -- %f
  smudge = git-lfs smudge -- %f
  process = git-lfs filter-process
  required = true
[alias]
  # Simple aliases
  stick = log --oneline --decorate --graph --all -n 30  # my prefered version of git log
  longStick = log --oneline --decorate --graph --all    # my prefered version of git log with extra length
  stat  = status                                        # short version of status
  com   = commit                                        # short version of commit
  ca    = commit --all                                  # add and commit at once
  fix-commit = commit --edit --file=.git/COMMIT_EDITMSG
  subpull = pull --recurse-submodule                    # Pull both the parent and submodule repos
  pull-force = !git fetch --all && git reset --hard @{u}  # Pull and overwrite local changes
  alias = config --get-regexp alias
  ri2 = rebase -i HEAD~2
  su = submodule update
  co = checkout

  # More complex aliases
  # ====================
  # on macOS this opens the GitHub repo in your browser, on other OSs print the URL
  hub = "!f() { \
  echo-github-url.sh; \
  }; f"
[include]
  path = /path/to/additional/gitconfig # you can include additional gitconfig files if you want
```

The `echo-github-url.sh` script mentioned above is here

```bash
#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's,:,/,' -e 's,git@,http://,' | xargs open
else
    git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's,:,/,' -e 's,git@,http://,'
fi;
```

### `.gitignore`

Your `.gitignore` files tells git which files to ignore. Good for compiled code,
logs, OS files, etc. This goes in the root directory of your repo. Here's the
default one I usually use.

```
# Files specific to this repo #
###############################


# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so
*.mod
*.a
a.out
*.dSYM
*.gch
__pycache__
*.pyc
*.pyx
*.prof

# Packages & Archives #
#######################
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
```

## `.gitmodules` (optional)

Belongs in your repo root and is used to store information about any [git
submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) you
might have. Git submodules are beyond the scope of this document but they
provide an easy way to have "sub repos" within your repo.

## `.git-blame-ignore-revs` (optional)

Belongs in your repo root and is used to tell `git blame` to ignore specific
commits. To enable this you need to run this command in the repo:
`git config blame.ignoreRevsFile .git-blame-ignore-revs`
Requires git v2.23 or greater and each entry must include the full 40 character
hash. This can be handy for ignoring commits that just do formatting or similar.

## 6. Workflow

Once you've finished the feature, bug fix, etc. you might find that you have a
lot of commits at an intermediate state. Often these intermediate states are
poorly designed, broken, or bad in some other way. Ideally we would like to
reduce all our work to one, or a couple, high quality commits before merging
them. Here's two options on how to do that; you should always backup your branch
by creating a new branch from it (`git branch backup-old-branch-name`)
before trying either of these methods.

### Option 1: Safely Squash and Rebase your Git Commits

*This section is based on the post
[Always Squash and Rebase your Git Commits](https://blog.carbonfive.com/always-squash-and-rebase-your-git-commits/)
by Anna Sherman. It's written in more detail there and I highly
recommend reading it*

This method works best for a small (<50) commits where you care about the
intermediate state and commit messages. It can be more complex but lets you walk
through your intermediate commits one-by-one to fix any conflicts.

```bash
# Pull current root branch
git pull main
# Create and checkout a new branch, Note that you can also checkout specific commits
git checkout -b featureBranch
# Set that branch upstream
git push origin featureBranch --set-upstream

# do stuff, make commits, etc

# Squash
git rebase -i HEAD~[number of commits]
# OR
git rebase -i [SHA]
# SHA is the unique identifier for a given commit. It's a 40 character hash
# (SHA=Simple Hashing Algorithm) which is often referenced by just the first 7
# characters. You'll usually see it just to the left of the commit message

# Check that your main branch is up to date
git checkout main
git pull

# Rebase on to main branch
git checkout featureBranch
git rebase main

# Update remote branch, NOTE THE DANGERS OF force push
git push origin featureBranch --force
# force pull
# git fetch --all
# git reset --hard origin/<branchName>

# Merge featureBranch into main
git checkout main
git merge featureBranch
git push
```

Squashing to a single commit isn't required, but maybe squash down to a handful
and make sure that each commit builds and passes tests. Remember you can have
multiple layers of this: `featureBranch` off of `main` and `subFeatureBranch`
off of `featureBranch`

### Option 2: The Nuclear Option

This is the nuclear approach for when you do not care about intermediate state.
This is often nice for when you have hundreds of commits and you don't want to
deal with any potential merge conflicts between them and instead just use the
latest state. You will destroy all new commits since you branched and just keep
the changed files. If you want to know what the commit messages said you will
need to get them manually *before* starting this process. Please backup your
branch before doing this.

```bash
# Pull current root branch
git pull main
# Create and checkout a new branch, Note that you can also checkout specific commits
git checkout -b featureBranch
# Set that branch upstream
git push origin featureBranch --set-upstream

# do stuff, make commits, etc

# Reset
# `git branch --show-current` returns the name of the current branch,
#  "featureBranch" in this case.
# `git merge-base <commit 1> <commit 2>` returns the SHA to the most recent
# common ancestor.
#
# Overall this command takes us back to the same state as when `featureBranch`
# branched off of `main` but with all the changes since then ready to stage and
# commit
git reset $(git merge-base main $(git branch --show-current))
git add <whatever you want to add>
git commit

# Check that your main branch is up to date
git checkout main
git pull

# Rebase on to main branch
git checkout featureBranch
git rebase main

# Update remote branch, NOTE THE DANGERS OF force push
git push origin featureBranch --force
# force pull
# git fetch --all
# git reset --hard origin/<branchName>

# Merge featureBranch into main
git checkout main
git merge featureBranch
git push
```

### Group Workflow

What I've written above is a workflow for an individual developer and it's
intended to work well with a team but is not itself a "team workflow". What the
best workflow is for an entire team is a huge subject of debate with a [myriad of
ideas](https://en.wikipedia.org/wiki/Software_development_process) about what
works best where with what kind of team. Most are variants of
[Agile Software Development](https://agilemanifesto.org) such as
[Extreme Programming](https://en.wikipedia.org/wiki/Extreme_programming) and
[Scrum](https://www.scrum.org/learning-series/what-is-scrum/). I've had good
luck more Agile development and it's popular for a reason, I encourage you to
spend some time looking into Agile software development practices.

Probably the most common mistake people make when working in a group is not
merging their work to `dev` often enough because the feature their feature
branches are implementing is far too large. Generally the features you choose to
implement in a specific branch should be small, typically something you can do in a week
or less (2 weeks at the absolute most) and consist of less than 300 changes,
though there is some flexibility there. This means that your branch is never too
far behind the `dev` branch that the team is working on and everyone else gets
your changes quickly. This goes a **long** way to reducing merge conflicts and
making collaborating much easier.

## 7. Assorted Useful Git Commands

### Git Reset

*[detailed guide](https://www.atlassian.com/git/tutorials/undoing-changes/git-reset)*

*[--soft vs. --mixed vs --hard guide](https://stackoverflow.com/questions/3528245/whats-the-difference-between-git-reset-mixed-soft-and-hard)*

`git reset` is an incredibly powerful and useful tool and you should know how to
use it. However, it’s less a gun that you can shoot yourself in the foot with
and more of a hand-grenade vending machine so make sure to backup your branch
before using it.

- `git reset`, removes all staged files from staging already
- `git reset --hard`, deletes all uncommitted changes to tracked files
- `git reset --soft HEAD~X`, undo the last X commits but keep the changes staged.
  Fantastic for if you mess up a commit.
- `git reset SHA`, moves both the current HEAD pointer and the branch pointer to
  a specific SHA. This is often a more dangerous version of `git revert` or
  `git cherry-pick` and unless you know what you're doing should be avoided.
  DON'T USE IT ON SHARED BRANCHES
  - If used with `--soft` it will delete all the commits after `SHA` but NOT
    change the files that were committed and it will stage them for a commit.
  - If used with `--mixed` (default behavior) it will delete all the commits
    after `SHA` but NOT change the files that were committed. The changes will
    not be staged for commiting
  - If used with `--hard` - If used with `--hard` it will delete all the commits
    after `SHA` AND delete all changes after `SHA`. The changes *might* be
    recoverable with `git reflog` but don't count on it. Be very careful with
    `--hard`.

### Git Revert

`git revert SHA` undoes a specific commit. It doesn't *delete* that commit, just
reverse all the changes in the original commit and makes a new commit with those
undone changes. Deleting and editing old commits can be done but requires a
force push and so should not be done on shared branches; probably shouldn't be
done on unshared branches either.

### Git Stash

Have something you're working on and need to go somewhere else? Note that
stashes are local ONLY.

```bash
git stash

#do other stuff

# See all the different stashes
git stash list

# Extract and reapply the current stash
git stash pop
```

Stashes can be given names, include untracked or ignored files
(`--include-untracked` and `--all`) and you can create a branch directly from a
stash (`git stash branch <optional branch name>`). Delete all stashes with `git
stash clear`

### Git Cherry-pick

`git cherry-pick SHA` grabs the single commit with the given SHA and copies it
onto the currently active branch. Useful it you want to grab the changes from an
older commit or move just one commit between branches

### Git Add -p

`git add -p <optional filename>` lets you commit single lines/chunks of code
without commiting all the changes in a file. See
[this guide](https://riptutorial.com/git/example/9227/selecting-which-lines-should-be-staged-for-committing)
for more info

### Git Clean

`git clean` is used for operating on untracked files. Useful for deleting many
untracked files if you need to. Go read the documentation if you think you might
need this. This is often more easily done in the VS Code changes view.

### Git `-C path`

Runs git as if it's in the directory specified by `path`. Fantastic for
scripts. I use it in my
[`gitall.sh`](https://github.com/bcaddy/dotfiles-skeleton/blob/master/bin/gitall.sh)
script to check multiple repos at once for updates and in
[`Repo-check-updates.sh`](https://github.com/bcaddy/dotfiles-skeleton/blob/master/bin/Repo-check-updates.sh)
to check if there are any updates for a given branch/repo that I need to apply.

Note: *lowercase -c is [totally different](https://git-scm.com/docs/git#Documentation/git.txt--cltnamegtltvaluegt)*

## 8. Other

### GitHub: Issues, Pull Requests, Actions, Wiki

GitHub, and other similar services, do many other things besides just host git repositories, here I'll give you a quick run down of some of the highlights.

- Issues: A place to raise issues or ask questions about a specific repository. This is how you would notify a repository owner about an issue. They can also be used to keep track of to-do items in a repo. They can be referenced in a commit message by writing `#Issue-Number`.
- Pull Requests (PRs): A request that the owner of a repository "pulls" your code into the repo. It takes a bit to get used to how to use these but it makes managing large repos much easier. They can be referenced in a commit message by writing `#PR-Number`.
- Actions: Actions are tasks that you can have GitHub automatically or manually perform on certain triggers. Common use cases are compiling and publishing a website, building and testing code, build and publishing documentation, etc. They have TONS of uses and aren't too hard to start using.
- Wiki: A wiki for the repo. Exactly what it sounds like, all pages are written in markdown.

### Dotfiles Organization

You might find that your settings files, such as `.bashrc`, `.gitconfig`, `.pythonrc`, etc. can become difficult to manage or keep synced between computers; these files are also called "dotfiles" since their names usually start with a period. To help manage these more effectively I highly recommend you put them all in a git repo and then link those files to the appropriate location. There are many repos out there that will help you do exactly that but I've found that many of them are too complex to easily use and don't always work well when you might have to work on multiple different systems/clusters. With the help of my friend [Seth Cook](https://github.com/MacaroonCookie) I wrote a system for managing my dotfiles which you can find in my [dotfiles-skeleton](https://github.com/bcaddy/dotfiles-skeleton) repo. That repo contains all the documentation required to get up and running with managing your dotfiles, simply fork the repo, add your dotfiles, and start working. I periodically update the skeleton repo with any major changes in my private dotfiles repo.
