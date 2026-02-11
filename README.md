# Agent Factory Template

A GitHub template repository for bootstrapping new projects with an agent-driven code factory.

## What's Included

- **25 Agent Skills** in `.cursor/skills/` (obra/superpowers workflow, Vercel, Next.js, Tailwind)
- **3 Cursor Rules** in `.cursor/rules/` (secrets, build, factory workflow)
- **3 Workflow Commands** in `.cursor/commands/` (new-feature, fix-bug, quality-check)
- **3 Custom Subagents** in `.cursor/agents/` (researcher, tester, reviewer)
- **GitHub Actions CI** with lint, typecheck, test, build pipeline
- **AI PR Review** via qodo-ai/pr-agent
- **PR Auto-labeling** based on changed file paths
- **AGENTS.md** template for project context
- **Quality Tooling** config: Vitest, Prettier, Husky + lint-staged

## Quick Start

1. Click "Use this template" on GitHub
2. Clone your new repo
3. Run `npm install`
4. Edit `AGENTS.md` with your project details
5. Start developing with `/new-feature` command

## Factory Workflow

```
Issue/Request
  -> /new-feature (brainstorm -> plan -> execute -> test -> review)
  -> Git commit + push
  -> CI pipeline (lint, typecheck, test, build)
  -> AI PR review
  -> Human review
  -> Merge + deploy
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/new-feature` | Full feature development workflow |
| `/fix-bug` | Systematic bug fix workflow |
| `/quality-check` | Run all quality signals |
| `/route` | Optimize context by selecting relevant skills (Factory v2) |

## Factory v2 Architecture (New)

The template now includes the **Factory v2** upgrade for high-efficiency orchestration:
- **Skill Router:** Located in `.cursor/skills/skill-router.md`. It prevents context bloat by dynamically filtering 25+ skills down to the task-relevant subset.
- **Architecture Guardagent:** Located in `.cursor/skills/architecture-review.md`. Acts as a validator to ensure all generated code complies with `AGENTS.md` and modular standards.
- **Knowledge Sync Protocol:** Detailed in `.cursor/skills/knowledge-sync-protocol.md`. Provides a framework for distilling local session memory into global project intelligence.

## Setup Notes

After creating a project from this template:

1. **Install dependencies:** `npm install --legacy-peer-deps`
2. **Initialize Husky:** `npx husky init`
3. **Configure pre-commit:** Set up `.husky/pre-commit` with `npx lint-staged`
4. **Add your quality scripts** to `package.json`:
   ```json
   "test": "vitest run",
   "typecheck": "tsc --noEmit",
   "format:check": "prettier --check .",
   "lint:strict": "next lint --strict"
   ```
5. **Set up branch protection** (see `.github/BRANCH_PROTECTION.md`)
6. **Add secrets** to GitHub repo settings:
   - `OPENAI_API_KEY` (for AI PR review)
