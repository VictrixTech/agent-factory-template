# Windsurf IDE Setup Guide

This project is configured for **Windsurf IDE** with the Agent Factory workflow.

## Quick Start

1. **Open in Windsurf IDE**
   - Open this project folder in Windsurf
   - Windsurf will automatically detect `.windsurfrules` and `.windsurf/` configuration

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Verify Setup**
   ```bash
   npm run lint && npm run typecheck && npm run test
   ```

## Available Workflows

Windsurf provides three main workflow commands:

### `/new-feature`
Complete feature development workflow:
- Brainstorm requirements
- Create implementation plan
- Execute with TDD
- Run quality checks
- Review and verify

### `/fix-bug`
Systematic bug fixing workflow:
- Investigate root cause
- Write failing test
- Implement minimal fix
- Verify no regressions

### `/quality-check`
Run all quality signals:
- ESLint
- TypeScript type checking
- Unit tests
- Prettier formatting
- Production build

## Skills System

The project includes **25 agent skills** in `.windsurf/skills/`:

### Core Skills
- `brainstorming` - Explore requirements before coding
- `writing-plans` - Create detailed implementation plans
- `subagent-driven-development` - Execute plans with parallel agents
- `test-driven-development` - Write tests before implementation
- `systematic-debugging` - Root cause analysis
- `verification-before-completion` - Final verification
- `requesting-code-review` - Code review workflow

### Architecture & Quality
- `architecture-review` - Guardagent for code standards
- `skill-router` - Dynamic skill filtering
- `knowledge-sync-protocol` - Session memory management

### Framework-Specific
- `next-best-practices` - Next.js patterns
- `next-cache-components` - Next.js 16 caching
- `next-upgrade` - Next.js migration
- `vercel-react-best-practices` - React optimization
- `vercel-composition-patterns` - Component patterns
- `tailwind-v4-shadcn` - Tailwind v4 + shadcn/ui

### Database & Auth
- `neon-postgres` - Neon Serverless Postgres
- `better-auth-best-practices` - Better Auth integration
- `create-auth-skill` - Auth layer creation

### Development Tools
- `using-git-worktrees` - Git worktree isolation
- `dispatching-parallel-agents` - Parallel task execution
- `executing-plans` - Multi-session plan execution
- `finishing-a-development-branch` - Branch completion
- `receiving-code-review` - Handle review feedback
- `web-design-guidelines` - UI/UX best practices
- `writing-skills` - Create new skills

## Rules

Global rules are defined in `.windsurfrules`:

### Factory Workflow
- Brainstorm → Plan → Execute → Test → Review → Verify
- Use skills for each phase
- TDD for all implementation
- Quality signals after changes

### Security
- Never commit secrets
- Use environment variables
- Document placeholders only
- Rotate exposed secrets immediately

### Quality Gate
- Run `npm run build` before pushing
- Avoid builds during active development
- Use linting tools for quick checks
- Test in browser via dev server

## Autonomous Orchestration

The project includes Mission Control scripts:

```bash
# Start autonomous feature development
./scripts/core/mission.sh "YOUR_FEATURE_NAME"
```

This orchestrates:
- **RECON** - Research and planning
- **FORGE** - Implementation
- **VERIFY** - Testing and validation
- **CRITIQUE** - Review and refinement

## Factory v2 Architecture

### Skill Router
Prevents context bloat by filtering 25+ skills to task-relevant subset:
- Analyzes task domain
- Scans file context
- Selects relevant skills
- Improves model performance

### Architecture Guardagent
Validates generated code against standards:
- Checks `AGENTS.md` compliance
- Enforces modular patterns
- Reviews architectural decisions

### Knowledge Sync Protocol
Distills session memory into project intelligence:
- Captures design decisions
- Documents patterns
- Builds project knowledge base

## Development Workflow

### Starting a New Feature
```bash
# Use the workflow command
/new-feature

# Or manually:
# 1. Brainstorm with AI
# 2. Create plan in docs/plans/
# 3. Execute with TDD
# 4. Run quality checks
# 5. Review and verify
```

### Fixing a Bug
```bash
# Use the workflow command
/fix-bug

# Or manually:
# 1. Investigate root cause
# 2. Write failing test
# 3. Implement minimal fix
# 4. Verify no regressions
```

### Quality Checks
```bash
# Use the workflow command
/quality-check

# Or manually:
npm run lint
npm run typecheck
npm run test
npm run format:check
npm run build
```

## Project Structure

```
.
├── .windsurf/
│   ├── workflows/          # Slash command workflows
│   └── skills/             # 25 agent skills
├── .windsurfrules          # Global rules
├── docs/
│   └── plans/              # Implementation plans
├── scripts/
│   └── core/               # Autonomous orchestration
├── package.json            # Dependencies & scripts
└── README.md               # Project overview
```

## Tips

1. **Use Skills** - Reference skills by name in conversations
2. **Follow Workflows** - Use `/new-feature`, `/fix-bug`, `/quality-check`
3. **TDD Always** - Write tests before implementation
4. **Quality First** - Run checks after every change
5. **Document Plans** - Save plans to `docs/plans/`
6. **Verify Before Done** - Use verification skill before claiming completion

## Next Steps

1. Edit `AGENTS.md` with your project details
2. Start developing with `/new-feature`
3. Set up GitHub Actions (already configured)
4. Configure branch protection
5. Add secrets to GitHub repo settings

## Support

- **Migration Guide**: See `MIGRATION_GUIDE.md`
- **Skills Reference**: See `SKILLS_REFERENCE.md`
- **README**: See `README.md`
