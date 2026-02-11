# KNOWLEDGE_SYNC.md - Memory Export Protocol

## Overview
This protocol defines how insights from local `MEMORY.md` (personal/session context) are sanitized and exported to a Centralized Knowledge Base (CKB) for long-term project intelligence.

## The Sync Flow

### 1. Extraction (The Distiller)
- **Source:** `MEMORY.md` and `memory/*.md`.
- **Frequency:** Weekly or upon completion of a major project milestone.
- **Criteria:** Extract only "lessons learned," "architectural decisions," "discovered API quirks," and "optimized workflows."

### 2. Sanitization (The Firewall)
- **REMOVE** all PII (Personally Identifiable Information).
- **REMOVE** local paths, specific credentials, or private user preferences.
- **CONVERT** "I decided to..." into "Best practice for [Project] is...".

### 3. Formatting (The Loader)
- Output format: Markdown with YAML frontmatter.
- Tagging: `#architecture`, `#optimization`, `#lesson-learned`, `#api-insight`.

### 4. Destination
- Primary: `.cursor/skills/knowledge/` (local enhancement).
- Secondary: Git-based central wiki or shared Notion/Obsidian vault.

## Example Sync Entry
```markdown
---
id: KB-2026-001
topic: Qwen3-Coder Syntax Optimization
date: 2026-02-11
tags: [coding, models]
---
# Insight
Qwen3-Coder-Next handles multi-step bash logic better when broken into distinct sub-tasks rather than a single complex piping command.
```

## Maintenance
- Run `KNOWLEDGE_SYNC` when `MEMORY.md` exceeds 500 lines.
- Archiving: Once synced, move old daily logs to `memory/archive/`.
