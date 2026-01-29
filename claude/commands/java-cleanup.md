---
allowed-tools: Bash, Read, Edit, Grep, Glob
description: Remove comments, fix checkstyle errors, and run tests
argument-hint: [test-class-name]
---

## Task

Clean up Java code changes and validate the build.

## Step 1: Remove Added Comments

Remove any comments that were added during the current session. Keep existing comments that were
already in the codebase.

## Step 2: Fix Import Style

Use proper imports instead of fully qualified package names in code.

**Convert these to imports:**

- `java.util.*` classes
- `com.kaching.*` classes
- Other commonly used packages

**Exceptions (OK to use inline):**

- `BigDecimal.ZERO`, `BigDecimal.ONE`
- `Option.none()`, `Option.some()`
- `Set.of()`, `List.of()`, `Map.of()`
- Enum values

## Step 3: Run Checkstyle Validation

```bash
mvn validate
```

Fix any checkstyle errors reported. Common issues:

- Line length exceeding limit
- Missing/extra whitespace
- Import ordering
- Unused imports

Repeat until `mvn validate` passes.

## Step 4: Run Tests

Run relevant tests using the test script:

```bash
agent-scripts/test.py <TestClassName>
```

### Which Tests to Run

1. **All tests affected by changes on this branch** - Check git diff to identify modified files
2. **MetaTest** - Always run if available
3. **Service-level tests** - Based on the service/directory being modified (e.g., `UserManagerTest`
   for user-related changes)

If a specific test class is provided as an argument: $ARGUMENTS

### Fix Failing Tests

If tests fail:

1. Read the failure output
2. Identify the root cause
3. Fix the issue
4. Re-run the test
5. Repeat until all tests pass

## Rules

- Fix issues autonomously without asking permission
- Run validation after each fix to verify
- If stuck on a checkstyle error after 3 attempts, report the specific error
- Do not introduce new functionality while fixing
