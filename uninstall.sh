#!/bin/bash

PACKAGE_ID="com.github.archfill.plasma-caffeine"
PLASMOID_DIR="$HOME/.local/share/plasma/plasmoids/$PACKAGE_ID"
BIN_DIR="$HOME/.local/bin"

echo "Uninstalling Plasma Caffeine..."

# Stop inhibitor if running
"$BIN_DIR/plasma-caffeine" stop 2>/dev/null || true

rm -f "$BIN_DIR/plasma-caffeine"
echo "  removed $BIN_DIR/plasma-caffeine"

rm -rf "$PLASMOID_DIR"
echo "  removed $PLASMOID_DIR"

echo "Done."
