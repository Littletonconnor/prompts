#!/bin/bash

# Setup script for Claude Code slash commands and agent skills
# Copies commands to ~/.claude/commands/ and skills to ~/.claude/skills/ and ~/.cursor/skills/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Install commands (single files)
install_commands() {
    local source_dir="$SCRIPT_DIR/claude/commands"
    local target_dir="$HOME/.claude/commands"

    mkdir -p "$target_dir"

    echo -e "${BLUE}Installing Claude commands${NC}"
    echo "  From: $source_dir"
    echo "  To:   $target_dir"
    echo ""

    local copied=0
    local skipped=0
    local overwritten=0

    for file in "$source_dir"/*.md; do
        [ -e "$file" ] || continue

        local filename=$(basename "$file")
        local target="$target_dir/$filename"

        if [ -f "$target" ]; then
            if diff -q "$file" "$target" > /dev/null 2>&1; then
                echo -e "${GREEN}✓${NC} $filename (already up to date)"
                ((skipped++))
                continue
            fi

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
    echo "Commands: Installed: $copied, Updated: $overwritten, Skipped: $skipped"
}

# Install skills (directories) to a target location
install_skills_to_target() {
    local source_dir="$1"
    local target_dir="$2"
    local target_name="$3"

    mkdir -p "$target_dir"

    echo -e "${BLUE}Installing skills to $target_name${NC}"
    echo "  From: $source_dir"
    echo "  To:   $target_dir"
    echo ""

    local copied=0
    local skipped=0
    local overwritten=0

    for skill_dir in "$source_dir"/*/; do
        [ -d "$skill_dir" ] || continue

        local skill_name=$(basename "$skill_dir")
        local target="$target_dir/$skill_name"

        if [ -d "$target" ]; then
            # Check if directories are identical (compare recursively)
            if diff -rq "$skill_dir" "$target" > /dev/null 2>&1; then
                echo -e "${GREEN}✓${NC} $skill_name (already up to date)"
                ((skipped++))
                continue
            fi

            echo -e "${YELLOW}!${NC} $skill_name already exists and differs"
            read -p "  Overwrite? [y/N/d(iff)] " -n 1 -r
            echo

            case $REPLY in
                d|D)
                    echo "--- Diff (existing vs new) ---"
                    diff -r "$target" "$skill_dir" || true
                    echo "------------------------------"
                    read -p "  Overwrite? [y/N] " -n 1 -r
                    echo
                    if [[ $REPLY =~ ^[Yy]$ ]]; then
                        rm -rf "$target"
                        cp -r "$skill_dir" "$target"
                        echo -e "${GREEN}✓${NC} $skill_name (overwritten)"
                        ((overwritten++))
                    else
                        echo -e "${YELLOW}→${NC} $skill_name (skipped)"
                        ((skipped++))
                    fi
                    ;;
                y|Y)
                    rm -rf "$target"
                    cp -r "$skill_dir" "$target"
                    echo -e "${GREEN}✓${NC} $skill_name (overwritten)"
                    ((overwritten++))
                    ;;
                *)
                    echo -e "${YELLOW}→${NC} $skill_name (skipped)"
                    ((skipped++))
                    ;;
            esac
        else
            cp -r "$skill_dir" "$target"
            echo -e "${GREEN}✓${NC} $skill_name (installed)"
            ((copied++))
        fi
    done

    echo ""
    echo "$target_name skills: Installed: $copied, Updated: $overwritten, Skipped: $skipped"
}

# Install skills to both Claude and Cursor
install_skills() {
    local source_dir="$SCRIPT_DIR/skills"

    if [ ! -d "$source_dir" ]; then
        echo "No skills directory found, skipping skill installation"
        return
    fi

    echo ""
    install_skills_to_target "$source_dir" "$HOME/.claude/skills" "Claude"
    echo ""
    install_skills_to_target "$source_dir" "$HOME/.cursor/skills" "Cursor"
}

# Main
echo "========================================"
echo "  Prompts Setup"
echo "========================================"
echo ""

install_commands
install_skills

echo ""
echo "========================================"
echo "  Setup complete!"
echo "========================================"
