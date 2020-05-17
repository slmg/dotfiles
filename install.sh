#!/bin/sh

# Exit on error.
set -e

test -d "$HOME" || {
    echo "fatal: the environment variable HOME is not set to a valid path."
    exit 1
}

GIT_DIR="$HOME/.config/dotfiles.git"

# Clone the branch dotfiles in `~/.config/dotfiles.git`.
git clone --bare --branch=dotfiles https://github.com/slmg/dotfiles.git "$GIT_DIR"

# Turn $HOME into a git working tree via an alias.
alias dotfiles='git --git-dir=$GIT_DIR --work-tree=$HOME'

# Do not show untracked files when using `dotfiles status`.
dotfiles config --local status.showUntrackedFiles no
