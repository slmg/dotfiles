# dotfiles

Solely use git to version homedir's dotfiles. No extra tooling, no symlinks.
Idea discovered in [this post](https://www.atlassian.com/git/tutorials/dotfiles).

## Installation

Run one of the following `curl` or `wget` commands.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/slmg/dotfiles/master/install.sh)"

# or

sh -c "$(wget -O- https://raw.githubusercontent.com/slmg/dotfiles/master/install.sh)"
```

## How does it work

This repo`s architecture consists of two main branches:

* `master` for documentation and helper scripts
* `dotfiles` for "dotfiles" config files - only this branch is relevant to the homedir

The branch `dotfiles` is deployed to `$HOME` through the combination of a bare
git repository (cloned into `$HOME/.config/dotfiles.git`) and an alias pointing
git to `$HOME`:

```sh
# Included in shell profile.
alias dotfiles="git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME"
```

This alias allows `$HOME` to be managed like a normal git repo:

```sh
dotfiles status
dotfiles add $HOME/.gitconfig
dotfiles commit -m "Modified .gitconfig"
dotfiles push
```
