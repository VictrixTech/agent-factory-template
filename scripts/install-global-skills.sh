#!/usr/bin/env bash
# install-global-skills.sh
# Copies global skills to ~/.codeium/windsurf/skills/ and validates the result

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_SRC="$PROJECT_DIR/.windsurf/skills"
SKILLS_DEST="$HOME/.codeium/windsurf/skills"

# 18 global skills (directories and files)
GLOBAL_SKILLS=(
  "brainstorming"
  "writing-plans"
  "test-driven-development"
  "systematic-debugging"
  "verification-before-completion"
  "requesting-code-review"
  "receiving-code-review"
  "using-superpowers"
  "skill-router.md"
  "knowledge-sync-protocol.md"
  "using-git-worktrees"
  "dispatching-parallel-agents"
  "subagent-driven-development"
  "executing-plans"
  "finishing-a-development-branch"
  "writing-skills"
  "web-design-guidelines"
  "ui-ux-pro-max"
)

echo "========================================"
echo " Windsurf Global Skills Installer"
echo "========================================"
echo "Source:      $SKILLS_SRC"
echo "Destination: $SKILLS_DEST"
echo ""

# Ensure destination exists
mkdir -p "$SKILLS_DEST"

# Copy each skill
COPIED=0
SKIPPED=0
FAILED=0

for skill in "${GLOBAL_SKILLS[@]}"; do
  src="$SKILLS_SRC/$skill"
  dest="$SKILLS_DEST/$skill"

  if [ ! -e "$src" ]; then
    echo "  [MISSING]  $skill  (not found in source)"
    ((FAILED++)) || true
    continue
  fi

  if [ -e "$dest" ]; then
    # Overwrite with latest version
    rm -rf "$dest"
  fi

  cp -r "$src" "$dest"
  echo "  [COPIED]   $skill"
  ((COPIED++)) || true
done

echo ""
echo "========================================"
echo " Validation"
echo "========================================"

PASS=0
FAIL=0

for skill in "${GLOBAL_SKILLS[@]}"; do
  dest="$SKILLS_DEST/$skill"
  if [ -e "$dest" ]; then
    echo "  [OK]  $skill"
    ((PASS++)) || true
  else
    echo "  [FAIL] $skill  — NOT FOUND after copy"
    ((FAIL++)) || true
  fi
done

echo ""
echo "========================================"
echo " Summary"
echo "========================================"
echo "  Copied:  $COPIED"
echo "  Skipped: $SKIPPED"
echo "  Failed:  $FAILED"
echo "  Valid:   $PASS / ${#GLOBAL_SKILLS[@]}"
echo ""

if [ "$FAIL" -eq 0 ]; then
  echo "  SUCCESS — All global skills installed to:"
  echo "  $SKILLS_DEST"
else
  echo "  WARNING — $FAIL skill(s) failed validation. Check output above."
  exit 1
fi
