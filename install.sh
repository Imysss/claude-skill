#!/usr/bin/env bash
# Symlink all skill directories in this repo to ~/.claude/skills/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

mkdir -p "$SKILLS_DIR"

count=0
skipped=0
for d in "$SCRIPT_DIR"/*/; do
  name=$(basename "$d")
  # Only treat directories with a SKILL.md as installable skills
  [ -f "$d/SKILL.md" ] || continue
  target="$SKILLS_DIR/$name"
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "  skip: $name (already exists at $target)"
    skipped=$((skipped + 1))
    continue
  fi
  ln -s "$d" "$target"
  echo "  link: $name -> $target"
  count=$((count + 1))
done

echo
echo "Installed $count skill(s). Skipped $skipped."
echo "Restart Claude Code to pick up the new skills."
