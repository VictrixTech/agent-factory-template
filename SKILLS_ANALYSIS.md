# Skills Analysis: Workspace vs Global

## Overview

This document categorizes the 25 skills into **workspace-specific** (project-dependent) and **global** (universal across all projects).

---

## Global Skills (Universal - Should be in Windsurf Global Config)

These skills apply to ANY project and should be available globally:

### 1. **Workflow & Process Skills**
- ✅ `brainstorming` - Universal creative exploration process
- ✅ `writing-plans` - Universal planning methodology
- ✅ `test-driven-development` - Universal TDD discipline
- ✅ `systematic-debugging` - Universal debugging methodology
- ✅ `verification-before-completion` - Universal verification checklist
- ✅ `requesting-code-review` - Universal code review process
- ✅ `receiving-code-review` - Universal review feedback handling
- ✅ `using-superpowers` - Meta-skill for skill discovery
- ✅ `skill-router` - Universal skill filtering mechanism

### 2. **Development Tools**
- ✅ `using-git-worktrees` - Universal Git workflow
- ✅ `dispatching-parallel-agents` - Universal parallel execution
- ✅ `subagent-driven-development` - Universal subagent orchestration
- ✅ `executing-plans` - Universal plan execution
- ✅ `finishing-a-development-branch` - Universal branch completion
- ✅ `writing-skills` - Meta-skill for creating new skills

### 3. **Architecture & Quality**
- ✅ `web-design-guidelines` - Universal UI/UX review (Vercel guidelines)
- ✅ `knowledge-sync-protocol` - Universal memory management

### 4. **Design Systems**
- ✅ `ui-ux-pro-max` - Universal design system generator (67 styles, 96 palettes, 57 font pairings)

**Total Global Skills: 18**

---

## Workspace-Specific Skills (Project-Dependent)

These skills are technology/stack-specific and should be in `.windsurf/skills/`:

### 1. **Framework-Specific**
- 📁 `next-best-practices` - Next.js specific (20 files)
- 📁 `next-cache-components` - Next.js 16 caching
- 📁 `next-upgrade` - Next.js migration
- 📁 `vercel-react-best-practices` - React optimization (59 files)
- 📁 `vercel-composition-patterns` - React patterns (10 files)
- 📁 `tailwind-v4-shadcn` - Tailwind v4 + shadcn/ui (13 files)

### 2. **Database & Backend**
- 📁 `neon-postgres` - Neon Serverless Postgres (29 files)
- 📁 `better-auth-best-practices` - Better Auth integration
- 📁 `create-auth-skill` - Auth layer creation

**Total Workspace Skills: 9**

---

## Duplicate/Overlap Analysis

### ⚠️ Potential Duplicates

1. **UI/UX Review**
   - `web-design-guidelines` - Fetches Vercel Web Interface Guidelines
   - `ui-ux-pro-max` - Comprehensive design system with Python scripts
   - **Recommendation:** Keep both, different purposes:
     - `web-design-guidelines` = Review/audit existing UI
     - `ui-ux-pro-max` = Generate new design systems

2. **Architecture Review**
   - `architecture-review.md` - References `.cursor/` paths (needs update)
   - **Issue:** Still references Cursor IDE structure
   - **Action Required:** Update to reference `.windsurf/` paths

3. **Knowledge Management**
   - `knowledge-sync-protocol.md` - Session memory distillation
   - References in `brainstorming` and `writing-plans`
   - **Recommendation:** Keep as global skill

---

## Issues Found

### 1. **Cursor IDE References**
`architecture-review.md` still contains:
```markdown
- New skills MUST be placed in `.cursor/skills/`.
```

**Fix Required:** Update to `.windsurf/skills/`

### 2. **Path References in Skills**
Several skills reference:
- `.cursor/skills/` → Should be `.windsurf/skills/`
- `AGENTS.md` → May not exist in all projects
- `MEMORY.md` → May not exist in all projects

### 3. **Python Dependencies**
`ui-ux-pro-max` requires Python 3 and has scripts in:
- `~/.windsurf/skills/ui-ux-pro-max/scripts/search.py`

**Note:** Now global - design system generation is universal across all projects. Python requirement documented in skill prerequisites.

---

## Recommended Structure

### Global Windsurf Config (~/.windsurf/skills/)
```
~/.windsurf/skills/
├── brainstorming/
├── writing-plans/
├── test-driven-development/
├── systematic-debugging/
├── verification-before-completion/
├── requesting-code-review/
├── receiving-code-review/
├── using-superpowers/
├── skill-router.md
├── using-git-worktrees/
├── dispatching-parallel-agents/
├── subagent-driven-development/
├── executing-plans/
├── finishing-a-development-branch/
├── writing-skills/
├── web-design-guidelines/
├── ui-ux-pro-max/
└── knowledge-sync-protocol.md
```

### Project Workspace (.windsurf/skills/)
```
.windsurf/skills/
├── architecture-review.md (project-specific rules)
├── next-best-practices/
├── next-cache-components/
├── next-upgrade/
├── vercel-react-best-practices/
├── vercel-composition-patterns/
├── tailwind-v4-shadcn/
├── neon-postgres/
├── better-auth-best-practices/
└── create-auth-skill/
```

---

## Migration Actions Required

1. **Update `architecture-review.md`**
   - Change `.cursor/skills/` → `.windsurf/skills/`
   - Make it project-specific (references project's AGENTS.md)

2. **Move Global Skills**
   - Extract 17 global skills to user's global Windsurf config
   - Keep 10 workspace skills in project

3. **Update Skill References**
   - Search for `.cursor/` references across all skills
   - Update to `.windsurf/` paths

4. **Document Dependencies**
   - Python requirement for `ui-ux-pro-max` is documented in skill prerequisites
   - Users must install Python 3 for design system generation features
   - Document when skills need external tools

---

## Summary

| Category | Count | Location |
|----------|-------|----------|
| **Global Skills** | 18 | `~/.windsurf/skills/` |
| **Workspace Skills** | 9 | `.windsurf/skills/` |
| **Duplicates** | 0 | None found |
| **Issues** | 3 | Path references need updates |

**No true duplicates found** - All skills serve distinct purposes. The apparent overlap between `web-design-guidelines` and `ui-ux-pro-max` is intentional: one audits, one generates.
