#!/bin/sh

set -e

command -v code || {
    echo "VsCode could not be found in PATH, is it installed ?"
    exit 1
}

EXTENSIONS_LIST="$HOME/.config/Code/User/extensions.txt"

echo "Syncing $EXTENSIONS_LIST..."

# Sync $EXTENSIONS_LIST which may contain new extensions.
< "$EXTENSIONS_LIST" xargs -L 1 code --install-extension

# Add locally installed extensions to $EXTENSIONS_LIST.
TMP_EXTENSION_LIST=$(mktemp)
code --list-extensions >> "$EXTENSIONS_LIST"
< "$EXTENSIONS_LIST" sort | uniq > "$TMP_EXTENSION_LIST"
mv "$TMP_EXTENSION_LIST" "$EXTENSIONS_LIST"

echo "Done."
