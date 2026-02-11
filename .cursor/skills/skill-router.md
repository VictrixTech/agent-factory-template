# Skill Router

## Context
You are an AI assistant using Cursor. You have access to a large library of skills (25+). Loading all of them simultaneously causes context bloat and reduces model performance.

## Objective
Filter the available skills to a relevant subset based on the current task, file context, and user intent.

## Routing Logic
1. **Analyze Task:** Identify the primary domain (Coding, Architecture, UI/UX, Memory, Product).
2. **Scan Imports/Files:** Check for specific technologies (React, Python, SQL) or project-specific files (AGENTS.md, MEMORY.md).
3. **Select Core Skills:**
   - Always include: `architecture-review.md` (Guardagent), `session-manager`.
4. **Select Domain Skills:**
   - **Frontend:** `ui-ux-pro-max`, `mobile-dev-sync`.
   - **Data/Logic:** `knowledge-graph`, `sql-optimizer`.
   - **Maintenance:** `cost-guard`, `knowledge-sync`.
5. **Instruction:** "Only apply instructions from the selected skills. Ignore irrelevant skill blocks."

## Skill Map
- **Arch/Safety:** `architecture-review.md`, `critical_safety_rules.md`
- **Logic/SWE:** `qwen-coder-logic`, `test-driven-dev`
- **UI/UX:** `ui-ux-pro-max`, `mini-max-frontend`
- **Project/Memory:** `knowledge-sync`, `memory-distiller`

## Usage in Cursor
When a new task starts:
1. Run `Skill Router`.
2. Output the list of "Active Skills" for the session.
3. Reference only those `.md` files in the `.cursorrules` or prompt context.
