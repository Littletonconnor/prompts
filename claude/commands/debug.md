---
allowed-tools: Bash, Read, Write
description: Debug an issue with structured investigation
argument-hint:
---

## Task

Debug the following issue: $ARGUMENTS

### Investigation Protocol

**Phase 1: Understand**

1. Reproduce the error if possible
2. Read the full stack trace carefully
3. Identify the exact line/function where failure occurs

**Phase 2: Hypothesize** Before making any changes, list 3 possible causes ranked by likelihood:

1. Most likely: ...
2. Possible: ...
3. Less likely: ...

**Phase 3: Verify** Write a minimal test that reproduces the bug BEFORE fixing:

```bash
// This test should FAIL before the fix and PASS after
```

**Phase 4: Fix**

- Make the minimal change needed
- Explain why this fixes the root cause, not just the symptom

**Phase 5: Validate**

- Run the test to confirm it passes
- Run related tests to check for regressions
- Document what you learned

### Rules

- Do NOT modify tests to make them pass
- Do NOT add console.logs without removing them
- PREFER fixing root causes over adding defensive checks
