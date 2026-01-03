---
allowed-tools: Bash(git diff:*), Bash(git log:*), Read
description: Perform a thorough code review of staged or specified changes
argument-hint: [branch-or-file]
---

## Context

- Current branch: !`git branch --show-current`
- Changes to review: !`git diff --cached --stat 2>/dev/null || git diff HEAD~1 --stat`

## Task

Perform a comprehensive code review of $ARGUMENTS (or staged changes if none specified).

### Review Checklist

**1. Correctness**

- Does the code do what it's supposed to do?
- Are there edge cases not handled?
- Are there potential null/undefined issues?

**2. Security**

- Input validation present?
- SQL injection, XSS, CSRF risks?
- Secrets or sensitive data exposed?
- Authentication/authorization properly checked?

**3. Performance**

- N+1 queries?
- Unnecessary re-renders (React)?
- Missing indexes for DB queries?
- Large objects in memory?

**4. Maintainability**

- Clear naming?
- Functions doing one thing?
- Appropriate abstraction level?
- Dead code?

**5. Testing**

- New code covered by tests?
- Edge cases tested?
- Tests actually test behavior (not implementation)?

### Output Format

Organize findings by severity:

- 🔴 **Blocker**: Must fix before merge
- 🟠 **Warning**: Should fix, but not blocking
- 🟡 **Suggestion**: Nice to have improvements
- 💭 **Question**: Needs clarification

Include specific file:line references for each finding.
