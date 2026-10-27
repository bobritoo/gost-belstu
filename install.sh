#!/bin/bash
set -euo pipefail

TOML="typst.toml"

[ -f "$TOML" ] || { echo "Error: $TOML not found"; exit 1; }

VERSION="$(grep '^version' "$TOML" | cut -d'"' -f2)" || { echo "Error: version not found"; exit 1; }
NAME="$(grep '^name' "$TOML" | cut -d'"' -f2)" || { echo "Error: name not found"; exit 1; }

[ -n "$VERSION" ] || { echo "Error: VERSION is empty"; exit 1; }
[ -n "$NAME" ] || { echo "Error: NAME is empty"; exit 1; }

PACKAGE_DIR="$HOME/.local/share/typst/packages/local/$NAME/$VERSION"

[ -d "$PACKAGE_DIR" ] && rm -r "$PACKAGE_DIR"

mkdir -p "$(dirname "$PACKAGE_DIR")"

if [ "${1:-}" = "soft" ]; then
    ln -vs "$(pwd)" "$PACKAGE_DIR"
else
    cp -R . "$PACKAGE_DIR/"
fi
