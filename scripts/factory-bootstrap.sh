#!/usr/bin/env bash
#
# Agent Code Factory Bootstrap Script
#
# Sets up a new project with the full agent-driven development infrastructure:
# - Shared skills from ~/.cursor/skills-shared/
# - Base rules for common conventions
# - Workflow commands
# - Generic subagents
# - Quality tooling (Vitest, Prettier, Husky, ESLint)
# - GitHub Actions CI + PR review
# - AGENTS.md template
#
# Usage:
#   ./factory-bootstrap.sh [project-dir]
#   ./factory-bootstrap.sh              # bootstraps current directory
#   ./factory-bootstrap.sh ~/my-project # bootstraps specified directory

set -euo pipefail

PROJECT_DIR="${1:-.}"
SHARED_SKILLS="$HOME/.cursor/skills-shared"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "=========================================="
echo "  Agent Code Factory Bootstrap"
echo "=========================================="
echo ""
echo "Project: $PROJECT_DIR"
echo ""

# Validate
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Directory $PROJECT_DIR does not exist"
  exit 1
fi

cd "$PROJECT_DIR"

# ─── 1. Copy shared skills ───────────────────────────────────────────────────

echo "1. Copying shared skills..."
mkdir -p .cursor/skills

if [ -d "$SHARED_SKILLS" ]; then
  SKILL_COUNT=0
  for skill_dir in "$SHARED_SKILLS"/*/; do
    skill_name=$(basename "$skill_dir")
    if [ ! -d ".cursor/skills/$skill_name" ]; then
      cp -r "$skill_dir" ".cursor/skills/"
      SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
  done
  echo "   Copied $SKILL_COUNT new skills ($(ls .cursor/skills | wc -l | tr -d ' ') total)"
else
  echo "   Warning: Shared skills not found at $SHARED_SKILLS"
  echo "   Run the factory bootstrap on the NeroView project first to populate shared skills"
fi

# ─── 2. Create base rules ────────────────────────────────────────────────────

echo "2. Creating base rules..."
mkdir -p .cursor/rules

if [ ! -f .cursor/rules/secrets.mdc ]; then
cat > .cursor/rules/secrets.mdc << 'RULE_EOF'
# Secrets Rule

## Never commit secrets

- Do **not** commit any of:
  - OAuth **client secrets**
  - DB URLs containing passwords/tokens
  - API keys, tokens, private keys

## Preferred patterns

- Put secrets in environment variables and `.env.local` (not committed).
- Document **placeholders**, not real values.

## If a secret is found

- **Stop** and ask to rotate/revoke it.
- Remove it from tracked files and add an ignore rule if needed.
RULE_EOF
  echo "   Created: secrets.mdc"
fi

if [ ! -f .cursor/rules/run-build-locally.mdc ]; then
cat > .cursor/rules/run-build-locally.mdc << 'RULE_EOF'
# Run build locally before pushing

- Always run the build command locally before pushing.
- If the build fails, fix the errors first.
- Avoid running builds after each small fix during development.
- Use linter/type checker for quick feedback during dev.
- Save full builds for the end or when specifically needed.
RULE_EOF
  echo "   Created: run-build-locally.mdc"
fi

if [ ! -f .cursor/rules/factory-workflow.mdc ]; then
cat > .cursor/rules/factory-workflow.mdc << 'RULE_EOF'
# Agent Code Factory Workflow

## Development Workflow Skills

When working on this project, follow the factory workflow using installed skills:

### For New Features or Creative Work
1. **Brainstorm first:** Use the `brainstorming` skill before any creative work
2. **Plan before code:** Use the `writing-plans` skill to create a detailed implementation plan
3. **Execute with subagents:** Use the `subagent-driven-development` skill for independent tasks

### For Implementation
4. **TDD:** Use the `test-driven-development` skill
5. **Quality signals:** Run lint, typecheck, test, format:check after implementation

### Before Completing Work
6. **Verify:** Use the `verification-before-completion` skill
7. **Review:** Use the `requesting-code-review` skill before merging

### For Bug Fixes
- Use the `systematic-debugging` skill — investigate before fixing

## Available Commands
- `/new-feature` — Full feature development workflow
- `/fix-bug` — Systematic bug fix workflow
- `/run-tests` — Run test suite and report
- `/quality-check` — Run all quality signals
RULE_EOF
  echo "   Created: factory-workflow.mdc"
fi

echo "   $(ls .cursor/rules/*.mdc 2>/dev/null | wc -l | tr -d ' ') rules total"

# ─── 3. Create workflow commands ──────────────────────────────────────────────

echo "3. Creating workflow commands..."
mkdir -p .cursor/commands

if [ ! -f .cursor/commands/new-feature.md ]; then
cat > .cursor/commands/new-feature.md << 'CMD_EOF'
---
description: Start a new feature using the full factory workflow
---
# New Feature Workflow

1. Use `brainstorming` skill to explore requirements
2. Use `writing-plans` skill to create implementation plan
3. Use `subagent-driven-development` to execute the plan
4. Run quality checks: lint, typecheck, test, format
5. Use `verification-before-completion` before finishing
6. Use `requesting-code-review` before merging
CMD_EOF
  echo "   Created: new-feature.md"
fi

if [ ! -f .cursor/commands/fix-bug.md ]; then
cat > .cursor/commands/fix-bug.md << 'CMD_EOF'
---
description: Fix a bug using systematic debugging
---
# Bug Fix Workflow

1. Use `systematic-debugging` skill to investigate
2. Write a failing test that reproduces the bug
3. Implement the minimal fix
4. Verify the test passes and no regressions
5. Use `verification-before-completion` before finishing
CMD_EOF
  echo "   Created: fix-bug.md"
fi

if [ ! -f .cursor/commands/quality-check.md ]; then
cat > .cursor/commands/quality-check.md << 'CMD_EOF'
---
description: Run all quality signals and report results
---
# Quality Check

Run each check and report results:
1. Lint check
2. Type check
3. Tests
4. Format check
5. Build (if all above pass)
CMD_EOF
  echo "   Created: quality-check.md"
fi

echo "   $(ls .cursor/commands/*.md 2>/dev/null | wc -l | tr -d ' ') commands total"

# ─── 4. Create generic subagents ─────────────────────────────────────────────

echo "4. Creating generic subagents..."
mkdir -p .cursor/agents

if [ ! -f .cursor/agents/project-researcher.md ]; then
cat > .cursor/agents/project-researcher.md << 'AGENT_EOF'
---
name: project-researcher
description: Specialized for exploring this codebase
tools:
  - codebase_search
  - grep
  - read_file
  - list_directory
model: fast
---
# Project Researcher

Explore the codebase to find relevant code, understand architecture, and answer questions.
Search broadly first, then read specific files for details.
Report with file paths, line numbers, and relevant snippets.
AGENT_EOF
  echo "   Created: project-researcher.md"
fi

if [ ! -f .cursor/agents/project-tester.md ]; then
cat > .cursor/agents/project-tester.md << 'AGENT_EOF'
---
name: project-tester
description: Runs tests and quality checks
tools:
  - terminal
  - read_file
model: fast
---
# Project Tester

Run quality signals in order: lint -> typecheck -> test -> format -> build.
Stop at first failure and report details. Suggest fixes for straightforward issues.
AGENT_EOF
  echo "   Created: project-tester.md"
fi

if [ ! -f .cursor/agents/project-reviewer.md ]; then
cat > .cursor/agents/project-reviewer.md << 'AGENT_EOF'
---
name: project-reviewer
description: Reviews code against project conventions
tools:
  - codebase_search
  - grep
  - read_file
model: fast
---
# Project Reviewer

Review code for: security (no secrets), architecture (correct locations),
quality (types, error handling, tests), and conventions (naming, imports, style).
Rate issues as CRITICAL, WARNING, or SUGGESTION.
AGENT_EOF
  echo "   Created: project-reviewer.md"
fi

echo "   $(ls .cursor/agents/*.md 2>/dev/null | wc -l | tr -d ' ') subagents total"

# ─── 5. Create AGENTS.md template ────────────────────────────────────────────

echo "5. Creating AGENTS.md template..."
if [ ! -f AGENTS.md ]; then
cat > AGENTS.md << 'AGENTS_EOF'
# Project - Agent Context

## Project Overview

[Describe your project here - what it does, who it's for, key features]

## Tech Stack

- **Framework:** [e.g., Next.js 15, Express, etc.]
- **Language:** TypeScript
- **Database:** [e.g., Postgres, SQLite, etc.]
- **Deployment:** [e.g., Vercel, AWS, etc.]

## Architecture

[Describe your project structure, key directories, patterns]

## Coding Conventions

- [List your project's coding conventions]
- [Import patterns, naming conventions, etc.]

## Quality Signals

```bash
npm run lint        # ESLint
npm run typecheck   # TypeScript
npm run test        # Tests
npm run format:check # Prettier
npm run build       # Full build
```

## Common Tasks

[Describe how to add features, fix bugs, run migrations, etc.]
AGENTS_EOF
  echo "   Created AGENTS.md template"
else
  echo "   AGENTS.md already exists, skipping"
fi

# ─── 6. Create GitHub Actions ────────────────────────────────────────────────

echo "6. Creating GitHub Actions..."
mkdir -p .github/workflows

if [ ! -f .github/workflows/ci.yml ]; then
cat > .github/workflows/ci.yml << 'CI_EOF'
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  quality:
    name: Quality Checks
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci 
      - name: Lint
        run: npm run lint
      - name: Type Check
        run: npm run typecheck
      - name: Test
        run: npm run test
      - name: Format Check
        run: npm run format:check

  build:
    name: Build
    runs-on: ubuntu-latest
    needs: [quality]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci 
      - run: npm run build
CI_EOF
  echo "   Created: ci.yml"
fi

echo "   $(ls .github/workflows/*.yml 2>/dev/null | wc -l | tr -d ' ') workflows total"

# ─── 7. Create docs/plans directory ──────────────────────────────────────────

echo "7. Creating docs structure..."
mkdir -p docs/plans
if [ ! -f docs/plans/.gitkeep ]; then
  touch docs/plans/.gitkeep
  echo "   Created: docs/plans/"
fi

# ─── Summary ─────────────────────────────────────────────────────────────────

echo ""
echo "=========================================="
echo "  Bootstrap Complete!"
echo "=========================================="
echo ""
echo "Created:"
echo "  .cursor/skills/     — $(ls .cursor/skills 2>/dev/null | wc -l | tr -d ' ') skills"
echo "  .cursor/rules/      — $(ls .cursor/rules/*.mdc 2>/dev/null | wc -l | tr -d ' ') rules"
echo "  .cursor/commands/   — $(ls .cursor/commands/*.md 2>/dev/null | wc -l | tr -d ' ') commands"
echo "  .cursor/agents/     — $(ls .cursor/agents/*.md 2>/dev/null | wc -l | tr -d ' ') subagents"
echo "  .github/workflows/  — $(ls .github/workflows/*.yml 2>/dev/null | wc -l | tr -d ' ') workflows"
echo "  AGENTS.md           — Project context template"
echo "  docs/plans/         — Implementation plans directory"
echo ""
echo "Next steps:"
echo "  1. Edit AGENTS.md with your project details"
echo "  2. Install quality tools: npm i -D vitest prettier husky lint-staged"
echo "  3. Add test/format/typecheck scripts to package.json"
echo "  4. Run 'npx husky init' and configure pre-commit hook"
echo "  5. Try '/new-feature' command to start your first feature"
echo ""
