---
description: Run all quality signals (lint, typecheck, test, format, build) and report results
---

# Quality Check

Run all quality signals in order and report results.

## Steps

Run each check sequentially. Stop and report on first failure, or run all and summarize:

1. **ESLint:**
// turbo
```bash
npm run lint
```

2. **TypeScript:**
// turbo
```bash
npm run typecheck
```

3. **Tests:**
// turbo
```bash
npm run test
```

4. **Formatting:**
// turbo
```bash
npm run format:check
```

5. **Build** (only if all above pass):
```bash
npm run build
```

## Report Format

```
QUALITY CHECK RESULTS
=====================
Lint:      PASS/FAIL
TypeCheck: PASS/FAIL
Tests:     PASS/FAIL (X passed, Y failed)
Format:    PASS/FAIL
Build:     PASS/FAIL/SKIPPED
=====================
Overall:   PASS/FAIL
```

If any check fails, provide details about what failed and how to fix it.
