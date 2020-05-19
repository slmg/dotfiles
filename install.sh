#!/bin/sh

# Exit on error.
set -e

test -d "$HOME" || {
    echo "fatal: the environment variable HOME is not set to a valid path."
    exit 1
}

GIT_DIR="$HOME/.config/dotfiles.git"
GIT_RESET_HARD=false
REPO_URL=https://github.com/slmg/dotfiles.git

# Parse arguments
while [ $# -gt 0 ]; do
    case $1 in
        --hard) GIT_RESET_HARD=true ;;
        --ssh) REPO_URL=git@github.com:slmg/dotfiles.git ;;
    esac
    shift
done

# This is needed just for 'git clone' to work (/dev/null would be nice but does not work).
TMP_LOCATION=$(mktemp -d)

# When using --separate-git-dir, 'git clone' fails if the path does not exists.
mkdir -p "$(dirname "$GIT_DIR")"

echo "Cloning a bare copy into '$GIT_DIR'..."
git clone --quiet --separate-git-dir="$GIT_DIR" --single-branch --branch=dotfiles \
    "$REPO_URL" "$TMP_LOCATION"

# Not needed anymore, 'git checkout' is the strategy used to restore the desired state.
rm -rf "$TMP_LOCATION"

# Turn $HOME into a git working tree via this alias.
alias dotfiles='git --git-dir=$GIT_DIR --work-tree=$HOME'

# Do not show untracked files when using `dotfiles status`.
dotfiles config --local status.showUntrackedFiles no

echo "Checking out the branch 'dotfiles' on the working tree '$HOME'..."

if [ "$GIT_RESET_HARD" = true ]; then
    echo "'--hard' arg specified: performing hard checkout..."
    dotfiles checkout "$HOME"
else
    # Restore 'deleted' files only - safe to do because they in fact do not exists yet.
    dotfiles checkout-index -a || {
        echo "To prevent data loss, existing tracked files were not overwritten. Inspect them and decide what to do."
    }
fi

echo "Done! You may now define the alias 'dotfiles' to opperate in your homedir:"
echo
echo "    alias dotfiles='git --git-dir=$GIT_DIR --work-tree=$HOME'"
echo
