---
description: Start a new feature using the full factory workflow (brainstorm -> plan -> execute -> test -> review)
---

# New Feature Workflow

Follow this complete workflow to implement a new feature:

## Step 1: Brainstorm
Use the `brainstorming` skill to explore the user's intent, requirements, and design before writing any code. Ask clarifying questions. Understand the "why" before the "what."

## Step 2: Plan
Use the `writing-plans` skill to create a detailed implementation plan. Save the plan to `docs/plans/YYYY-MM-DD-<feature-name>.md`. Break work into bite-sized tasks (2-5 minutes each).

## Step 3: Execute
Use the `subagent-driven-development` skill to execute the plan. Dispatch one subagent per independent task. For each task:
1. Write the failing test first (TDD)
2. Implement minimal code to pass
3. Run tests to verify
4. Commit

## Step 4: Quality Check
Run all quality signals:
```bash
npm run lint
npm run typecheck
npm run test
npm run format:check
```

## Step 5: Review
Use the `requesting-code-review` skill to review the implementation. Check against the plan. Verify all acceptance criteria are met.

## Step 6: Verify
Use the `verification-before-completion` skill before claiming the work is done. Ensure tests pass, no regressions, and the feature works as specified.
