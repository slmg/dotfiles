# dotfiles

Solely use git to version homedir's dotfiles. No extra tooling, no symlinks.
Idea discovered in [this post](https://www.atlassian.com/git/tutorials/dotfiles).

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

By default, any existing tracked file is not overwritten by the script so it's safe to run.
On the opposite, to replace any existing tracked file by the current version on the `dotfiles` branch (useful on a fresh machine/container), use the `--hard` option.

```sh
# Caution, any modification will be lost!
sh install.sh --hard
```

To manage `$HOME` like a normal git repository, define the below alias.

```sh
alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'

# Include it in your shell profile (already done on the branch's rc file).
export "alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'" >> .bashrc
```

## Principle

This repo`s architecture consists of two main branches:

* `master` - hosting documentation and helper scripts
* `dotfiles` - hosting config files, only this branch is deployed locally

The branch `dotfiles` is deployed to `$HOME` through the combination of a bare
git repository (cloned into `$HOME/.config/dotfiles.git`) and the alias defined above, pointing
git to `$HOME`.

This trick allows to use standard git commands by substituting `git` to `dotfiles`.

```sh
# Note that the repo is configured to not show untracked files when using `status`.
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m "Modified .gitconfig"
dotfiles push
```

## Post-installation steps

By default, no existing tracked file is altered if the install script was run
without the `--hard` option. Review any diff by running:

```sh
dotfiles status
```

Then decide what to do using `dotfiles checkout`/`add`/`commit`/`reset` etc...
Classic git workflow! :)

If you realise that you do not care about any diff and that it would have been preferrable to
pass `--hard` to the `install.sh` script, produce the same outcome by running:

```sh
# Overwrite everything. Caution, any modification will be lost!
dotfiles checkout $HOME
```
