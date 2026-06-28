#!/usr/bin/env bash

set -euo pipefail

SOURCE="$HOME/.config/opencode/AGENTS.md"

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: AGENTS.md not found:"
    echo "  $SOURCE"
    exit 1
fi

link_agent() {
    local target_dir="$1"

    mkdir -p "$target_dir"
    ln -sfn "$SOURCE" "$target_dir/AGENTS.md"

    echo "✓ $target_dir/AGENTS.md"
}

echo "Synchronizing AGENTS.md..."
echo

# Codex
link_agent "$HOME/.codex"

# Cursor (adjust if Cursor changes location in the future)
link_agent "$HOME/.cursor"

# Antigravity (adjust if Antigravity uses another directory)
link_agent "$HOME/.antigravity"

echo
echo "Source of truth:"
echo "  $SOURCE"
echo
echo "Done."
