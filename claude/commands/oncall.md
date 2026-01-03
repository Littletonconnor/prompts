---
allowed-tools: Bash, Read, Write, WebSearch, Browser
description: Investigate production issue from Sentry alert
argument-hint: <sentry-screenshot>
---

## Task

Investigate this production issue: $ARGUMENTS

## Step 1: Capture

Navigate to the Sentry URL and take a screenshot. Extract:

- Error message and type
- Occurrence count and affected users
- Stack trace (file, line, function)
- First/last seen timestamps

## Step 2: Research

Search for the error:

```
"<error message>" site:github.com
"<error type>" <library name> issue
```

Check for known issues, workarounds, or fixes.

## Step 3: Investigate Code

Read the file from the stack trace. Understand:

- How this code path is triggered
- What conditions cause the error
- Recent changes (`git log -p --since="1 week ago" -- <file>`)

## Step 4: Assess Priority

| Dimension        | HIGH                             | MEDIUM                      | LOW                          |
| ---------------- | -------------------------------- | --------------------------- | ---------------------------- |
| **Impact**       | Business-critical action blocked | Non-critical feature broken | User can recover immediately |
| **Reoccurrence** | Happens every time / many users  | Intermittent / some users   | Rare edge case               |

**Final Priority:**

- HIGH = High impact OR high reoccurrence → fix immediately
- MEDIUM = Medium impact/reoccurrence → fix after HIGH queue empty
- LOW = Low both → fix when time permits

## Step 5: Output

### For Me (Technical Explanation)

```sh
## Issue Summary
[What's happening]

## Stack Trace Analysis
- File: [path]
- Function: [name]
- Line: [number]
- Trigger: [how this code gets called]

## Root Cause
[Why this is happening]

## Research Findings
[GitHub issues, related bugs, workarounds found]
```

### For Jira (Copy-Paste Comment)

```sh
## Priority Assessment

**Impact**: [HIGH/MEDIUM/LOW]
- [1-2 sentence justification]

**Probability to Reoccur**: [HIGH/MEDIUM/LOW]
- [1-2 sentence justification]

## Summary
[2-3 sentences explaining the issue for non-technical readers]

## Affected Users
- Occurrences: [count]
- Users impacted: [count or scope]
- First seen: [date]

## Recommended Action
[What needs to happen to fix this]
```

## Step 6: Fix

If the fix is straightforward:

1. Implement the fix
2. Run tests
3. Show me the diff

If complex or risky:

1. Explain the options
2. Wait for my input
