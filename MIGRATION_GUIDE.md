# Migration Guide: Cursor IDE → Windsurf IDE

This document explains the migration from Cursor IDE to Windsurf IDE structure.

## Overview

The Agent Factory Template has been adapted from Cursor IDE to Windsurf IDE. All functionality remains the same, but the directory structure and configuration files have been updated to match Windsurf's conventions.

## Key Changes

### Directory Structure

| Cursor IDE | Windsurf IDE | Purpose |
|------------|--------------|---------|
| `.cursor/` | `.windsurf/` | Main configuration directory |
| `.cursor/rules/*.mdc` | `.windsurfrules` | Global rules (merged into single file) |
| `.cursor/commands/*.md` | `.windsurf/workflows/*.md` | Workflow commands |
| `.cursor/skills/` | `.windsurf/skills/` | Reusable skill modules |
| `.cursor/agents/` | _(not needed)_ | Windsurf has built-in agent capabilities |

### Configuration Files

#### Rules Migration
**Before (Cursor):**
- `.cursor/rules/factory-workflow.mdc`
- `.cursor/rules/secrets.mdc`
- `.cursor/rules/run-build-locally.mdc`

**After (Windsurf):**
- `.windsurfrules` (all rules merged)

#### Workflows Migration
**Before (Cursor):**
- `.cursor/commands/new-feature.md`
- `.cursor/commands/fix-bug.md`
- `.cursor/commands/quality-check.md`

**After (Windsurf):**
- `.windsurf/workflows/new-feature.md`
- `.windsurf/workflows/fix-bug.md`
- `.windsurf/workflows/quality-check.md`

### Workflow Format

Windsurf workflows support the `// turbo` annotation for auto-running safe commands:

```markdown
## Step: Run Tests
// turbo
```bash
npm run test
```
```

This allows Windsurf to automatically execute the command without user approval when it's marked as safe.

### Skills

All 25 skills have been copied to `.windsurf/skills/` with minimal changes:
- Updated references from "Cursor" to "Windsurf"
- Updated file path references (`.cursorrules` → `.windsurfrules`)

## Usage

### Slash Commands

Use the same slash commands as before:
- `/new-feature` — Full feature development workflow
- `/fix-bug` — Systematic bug fix workflow
- `/quality-check` — Run all quality signals

### Factory Workflow

The complete factory workflow remains unchanged:
1. **Brainstorm** → Use `brainstorming` skill
2. **Plan** → Use `writing-plans` skill
3. **Execute** → Use `subagent-driven-development` skill
4. **Test** → TDD with `test-driven-development` skill
5. **Review** → Use `requesting-code-review` skill
6. **Verify** → Use `verification-before-completion` skill

### Skills System

Windsurf has a built-in skills system that works similarly to Cursor:
- Skills are defined in `.windsurf/skills/`
- Reference skills by name in workflows
- Skill Router filters relevant skills to prevent context bloat

## What Stayed the Same

- ✅ All 25 agent skills
- ✅ Factory v2 architecture (Skill Router, Architecture Guardagent, Knowledge Sync)
- ✅ Autonomous orchestration scripts (`scripts/core/`)
- ✅ GitHub Actions CI/CD pipeline
- ✅ Quality tooling (Vitest, Prettier, ESLint, TypeScript)
- ✅ Development workflow and best practices

## What Changed

- 📁 Directory structure (`.cursor/` → `.windsurf/`)
- 📄 Rules format (multiple `.mdc` files → single `.windsurfrules`)
- 🔧 Workflow annotations (added `// turbo` for safe auto-run)
- 📝 Documentation references updated

## Migration Checklist

If you're migrating an existing project:

- [ ] Create `.windsurf/` directory structure
- [ ] Merge `.cursor/rules/*.mdc` into `.windsurfrules`
- [ ] Copy workflows from `.cursor/commands/` to `.windsurf/workflows/`
- [ ] Copy skills from `.cursor/skills/` to `.windsurf/skills/`
- [ ] Update skill references (Cursor → Windsurf)
- [ ] Add `// turbo` annotations to safe workflow commands
- [ ] Update README and documentation
- [ ] Test workflows with `/new-feature`, `/fix-bug`, `/quality-check`

## Backward Compatibility

The `.cursor/` directory has been preserved for reference. You can safely remove it once you've verified the Windsurf setup works correctly:

```bash
rm -rf .cursor/
```

## Support

For issues or questions about the migration:
1. Check this migration guide
2. Review `.windsurfrules` for current rules
3. Inspect `.windsurf/workflows/` for workflow definitions
4. Consult `.windsurf/skills/` for skill documentation
