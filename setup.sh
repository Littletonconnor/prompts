#!/bin/bash

# Setup script for Claude Code slash commands
# Copies commands to ~/.claude/commands/ with overwrite protection

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/claude/commands"
TARGET_DIR="$HOME/.claude/commands"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

echo "Installing Claude commands from: $SOURCE_DIR"
echo "Installing to: $TARGET_DIR"
echo ""

copied=0
skipped=0
overwritten=0

for file in "$SOURCE_DIR"/*.md; do
    [ -e "$file" ] || continue

    filename=$(basename "$file")
    target="$TARGET_DIR/$filename"

    if [ -f "$target" ]; then
        # Check if files are identical
        if diff -q "$file" "$target" > /dev/null 2>&1; then
            echo -e "${GREEN}✓${NC} $filename (already up to date)"
            ((skipped++))
            continue
        fi

        # Files differ - ask for confirmation
        echo -e "${YELLOW}!${NC} $filename already exists and differs"
        read -p "  Overwrite? [y/N/d(iff)] " -n 1 -r
        echo

        case $REPLY in
            d|D)
                echo "--- Diff (existing vs new) ---"
                diff "$target" "$file" || true
                echo "------------------------------"
                read -p "  Overwrite? [y/N] " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    cp "$file" "$target"
                    echo -e "${GREEN}✓${NC} $filename (overwritten)"
                    ((overwritten++))
                else
                    echo -e "${YELLOW}→${NC} $filename (skipped)"
                    ((skipped++))
                fi
                ;;
            y|Y)
                cp "$file" "$target"
                echo -e "${GREEN}✓${NC} $filename (overwritten)"
                ((overwritten++))
                ;;
            *)
                echo -e "${YELLOW}→${NC} $filename (skipped)"
                ((skipped++))
                ;;
        esac
    else
        cp "$file" "$target"
        echo -e "${GREEN}✓${NC} $filename (installed)"
        ((copied++))
    fi
done

echo ""
echo "Done! Installed: $copied, Updated: $overwritten, Skipped: $skipped"
