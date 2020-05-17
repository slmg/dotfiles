#!/bin/sh

# Exit on error.
set -e

test -d "$HOME" || {
    echo "fatal: the environment variable HOME is not set to a valid path."
    exit 1
}

GIT_DIR="$HOME/.config/dotfiles.git"
BAKUP_DIR="$HOME/dotfiles.bak"

# Clone the branch dotfiles in `~/.config/dotfiles.git`.
git clone --bare --branch=dotfiles https://github.com/slmg/dotfiles.git "$GIT_DIR"

# Turn $HOME into a git working tree via an alias.
alias dotfiles='git --git-dir=$GIT_DIR --work-tree=$HOME'

# Do not show untracked files when using `dotfiles status`.
dotfiles config --local status.showUntrackedFiles no

echo "Cheking out the branch dotfiles into '$HOME'..."
# Trick to checkout in a non-empty dir without breaking anything.
dotfiles stash push --quiet

# Create a backup dir only if any files were overwritten by the previous command.
mkdir "$BAKUP_DIR"
git --git-dir="$GIT_DIR" --work-tree="$BAKUP_DIR" stash pop --quiet
if [ ! "$(ls -A "$BAKUP_DIR")" ]; then
    echo "There was no conflict with existing files. 👍"
    rm -r "$BAKUP_DIR"
else
    echo "Some files conflicted and were overwritten by git❗"
    echo "Check '$BAKUP_DIR' to restore anything, otherwise it's safe to delete this dir."
fi
