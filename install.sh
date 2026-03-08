#!/bin/bash
set -e

PACKAGE_ID="com.github.archfill.plasma-caffeine"
PLASMOID_DIR="$HOME/.local/share/plasma/plasmoids/$PACKAGE_ID"
BIN_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Plasma Caffeine..."

# Install helper script
mkdir -p "$BIN_DIR"
cp "$SCRIPT_DIR/package/contents/scripts/caffeine-helper" "$BIN_DIR/plasma-caffeine"
chmod +x "$BIN_DIR/plasma-caffeine"
echo "  helper -> $BIN_DIR/plasma-caffeine"

# Install plasmoid
mkdir -p "$PLASMOID_DIR"
cp -r "$SCRIPT_DIR/package/"* "$PLASMOID_DIR/"
echo "  plasmoid -> $PLASMOID_DIR"

echo ""
echo "Done! Add the widget:"
echo "  Right-click desktop → Add Widgets → search 'Plasma Caffeine'"
echo ""
echo "If the widget doesn't appear, restart plasmashell:"
echo "  kquitapp6 plasmashell && kstart plasmashell"
