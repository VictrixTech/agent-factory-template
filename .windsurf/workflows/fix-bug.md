---
description: Fix a bug using systematic debugging workflow
---

# Bug Fix Workflow

## Step 1: Investigate
Use the `systematic-debugging` skill. Before proposing any fix:
1. Reproduce the bug (or understand the reproduction steps)
2. Form a hypothesis about the root cause
3. Gather evidence (logs, error messages, code paths)
4. Verify the hypothesis before implementing a fix

## Step 2: Write a Failing Test
Write a test that reproduces the bug. Run it to confirm it fails:
// turbo
```bash
npm run test
```

## Step 3: Implement the Fix
Write the minimal code change to fix the bug. Keep the diff small and focused.

## Step 4: Verify
1. Run the failing test — it should now pass
2. Run the full test suite to check for regressions:
// turbo
```bash
npm run test && npm run typecheck && npm run lint
```

## Step 5: Review
Use the `verification-before-completion` skill to confirm:
- The root cause is addressed (not just the symptom)
- No regressions introduced
- Test coverage includes the fix
