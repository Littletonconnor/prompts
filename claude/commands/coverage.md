---
allowed-tools: Bash, Read, Write
description: Analyze test coverage gaps for a file or directory
argument-hint: <file-path or directory>
---

## Task

Analyze test coverage for: $ARGUMENTS

## Step 1: Identify Code Paths

Read the source file(s) and catalog every code path:

**Functions/Methods**

- [ ] Public functions
- [ ] Private/internal functions
- [ ] Callbacks and handlers

**Branches**

- [ ] If/else branches
- [ ] Switch/case statements
- [ ] Ternary expressions
- [ ] Early returns / guard clauses

**Error Handling**

- [ ] Try/catch blocks
- [ ] Error callbacks
- [ ] Thrown exceptions
- [ ] Null/undefined checks

**Async Paths**

- [ ] Promise resolutions
- [ ] Promise rejections
- [ ] Async/await error paths
- [ ] Timeout scenarios

**Edge Cases**

- [ ] Empty inputs
- [ ] Boundary conditions
- [ ] Type coercion scenarios

## Step 2: Find Existing Tests

Search for test files:

```bash
# Find related test files
find . -name "*test*" -o -name "*spec*" | grep -i "<filename>"
```

Read existing tests and map which code paths they cover.

## Step 3: Coverage Report

Output a report:

```markdown
## Coverage Analysis: <file>

### Covered ✅

| Code Path                | Test File    | Test Name                 |
| ------------------------ | ------------ | ------------------------- |
| `functionA()` happy path | file.test.ts | "should return data"      |
| `functionA()` error case | file.test.ts | "should throw on invalid" |

### Missing ❌

| Code Path             | Priority | Reason                       |
| --------------------- | -------- | ---------------------------- |
| `functionB()` timeout | High     | No async error handling test |
| `handleError()`       | Medium   | Error handler untested       |
| Line 45 else branch   | Low      | Edge case, unlikely path     |

### Summary

- **Covered**: X / Y code paths (Z%)
- **Critical gaps**: [list]
- **Recommended next tests**: [prioritized list]
```

## Step 4: Generate Missing Tests

After presenting the report, ask:

> Would you like me to generate tests for the missing code paths?

If yes, generate tests following the project's existing patterns.

## Priority Guidelines

**High Priority** (test immediately):

- Public API functions
- Error handling paths
- Security-related code
- Data validation

**Medium Priority** (test soon):

- Private functions with complex logic
- State mutations
- Integration points

**Low Priority** (test when time permits):

- Simple getters/setters
- Logging statements
- Unlikely edge cases

## Rules

- Match existing test file structure and naming
- Don't suggest tests for trivial code (simple assignments, logging)
- Focus on behavioral coverage, not line coverage
- Identify flaky test risks (time-dependent, order-dependent)
