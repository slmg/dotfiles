#!/bin/sh

# This script performs two actions:
#
#   1. Install all extensions from the extensions list.
#   2. Dump locally installed extensions to the extensions list.
#
# In effect, deleted extensions need to also be deleted from the extensions list.
# Otherwise they would be installed again the next time this script is run.

set -e

EXTENSIONS_LIST="$HOME/.config/Code/User/extensions.txt"

# Sanity checks.
command -v code || {
    echo "VsCode could not be found in PATH, is it installed?"
    exit 1
}
test -f "$EXTENSIONS_LIST" || {
    echo "$EXTENSIONS_LIST does not exist! Aborting..."
    exit 1
}

echo "Syncing $EXTENSIONS_LIST..."

# Sync $EXTENSIONS_LIST which may contain new extensions.
< "$EXTENSIONS_LIST" xargs -L 1 code --install-extension

# Overwrite $EXTENSIONS_LIST with locally installed extensions.
code --list-extensions > "$EXTENSIONS_LIST"

echo "Done."
