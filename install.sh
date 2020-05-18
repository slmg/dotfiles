#!/bin/sh

# Exit on error.
set -e

test -d "$HOME" || {
    echo "fatal: the environment variable HOME is not set to a valid path."
    exit 1
}

GIT_DIR="$HOME/.config/dotfiles.git"
GIT_RESET_HARD=false

# Parse arguments
while [ $# -gt 0 ]; do
    case $1 in
        --hard) GIT_RESET_HARD=true ;;
    esac
    shift
done

# Clone the branch dotfiles in `~/.config/dotfiles.git`.
git clone --bare --branch=dotfiles https://github.com/slmg/dotfiles.git "$GIT_DIR"

# Turn $HOME into a git working tree via an alias.
alias dotfiles='git --git-dir=$GIT_DIR --work-tree=$HOME'

# Do not show untracked files when using `dotfiles status`.
dotfiles config --local status.showUntrackedFiles no

if [ "$GIT_RESET_HARD" = true ]; then
    echo "'--hard' arg specified: overriding all tracked files in '$HOME'..."
    dotfiles reset --hard
    exit 0
fi
