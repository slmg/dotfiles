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
On the opposite, to replace any existing tracked file by the current version on the `dotfiles` branch (ex on a fresh machine/container), use the `--hard` option.

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

* `master` for documentation and helper scripts
* `dotfiles` for "dotfiles" config files - only this branch is relevant to the homedir

The branch `dotfiles` is deployed to `$HOME` through the combination of a bare
git repository (cloned into `$HOME/.config/dotfiles.git`) and the alias defined above, pointing
git to `$HOME`.

This trick allows to use standard git commands by substituting `git` to `dotfiles`.

```sh
# Note that the repo is configured to not show untracked files when using `status`.
dotfiles status
dotfiles add $HOME/.gitconfig
dotfiles commit -m "Modified .gitconfig"
dotfiles push
```

## Post-installation steps

If you didn't use the `--hard` option during installation, no files in your homedir was altered.
Git's default behaviour is to stage every diff between your working tree and the branch `dotfiles`.
List every diff by running `dotfiles status`.

Presumably, you care not to overwrite at least some file in your homedir. If that is not the case
and you happen to have missed the `--hard` arg earlier, produce the same outcome by running the below command. It is also useful once the file you wanted to keep were removed from the index.

```sh
# Caution, any modification will be lost!
dotfiles reset --hard
```

To keep original 'dirty' files (not the dotfiles revisions), unstage them.

```sh
# Example: removing .gitconfig from the index.
dotfiles reset -- .gitconfig

# If that was a mistake, restore the 'dotfiles' revision.
dotfiles checkout .gitconfig
```
