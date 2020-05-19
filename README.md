# dotfiles

Solely use git to version homedir's dotfiles. No extra tooling, no symlinks.
Original idea from this [Hacker News thread](https://news.ycombinator.com/item?id=11070797).

## Installation

Download the setup script using either `curl` or `wget`. It is recommended to inspect it
before running it (security).

```sh
curl -fsSL https://raw.githubusercontent.com/slmg/dotfiles/master/install.sh -o install.sh
# or
wget https://raw.githubusercontent.com/slmg/dotfiles/master/install.sh

# Once you're happy with what the script does, execute it.
sh install.sh
```

By default, no existing tracked file is overwritten by the script so it's safe to run.
On the contrary, to replace all existing tracked files by the current version on the `dotfiles` branch (useful on a fresh machine/container), use the `--hard` option.

```sh
# Caution, any modification will be lost!
sh install.sh --hard
```

To manage `$HOME` like a normal git repository, define the below alias.

```sh
alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'

# Include it in your shell profile (which should live in the branch 'dotfiles').
export "alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'" >> .bashrc
```

## Principle

This repo is architected as a set of two main branches:

* `master` - to host documentation and helper scripts
* `dotfiles` - to host config files, only this branch is deployed locally

The branch `dotfiles` is deployed to `$HOME` through the combination of a bare
git repository (cloned into `$HOME/.config/dotfiles.git`) and the alias `dotfiles`,
pointing git to `$HOME`.

This trick allows to use standard git commands by substituting `git` to `dotfiles`.

Review any diff by running:

```sh
# Note that git is configured to not show untracked files when using this command.
dotfiles status
```

Then decide what to do using `dotfiles checkout`/`add`/`commit`/`reset` etc...
Classic git workflow! :)
