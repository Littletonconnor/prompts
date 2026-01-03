---
allowed-tools: Bash(git:*)
description: Create a well-formatted conventional commit
argument-hint: [branch-name]
---

## Input

**Target branch:** $ARGUMENTS

## Current State

- Current branch: !`git branch --show-current`
- Staged changes: !`git diff --cached --stat`
- Unstaged changes: !`git status --short`

## Step 1: Branch (if specified)

If a target branch was provided above and it differs from current branch:

```bash
git switch <target-branch>
# or if branch doesn't exist yet:
git switch -c <target-branch>
```

If no target branch provided or already on that branch, skip this step.

## Step 2: Stage (if needed)

If nothing is staged but there are unstaged changes, suggest what to stage.

## Step 3: Commit

1. **Analyze** the staged diff to understand what changed
2. **Determine** the commit type:
   - `feat`: New feature
   - `fix`: Bug fix
   - `refactor`: Code change that neither fixes a bug nor adds a feature
   - `docs`: Documentation only
   - `test`: Adding or updating tests
   - `chore`: Maintenance tasks
   - `perf`: Performance improvement
   - `style`: Formatting, semicolons, etc (no code change)

3. **Format** as: `type(scope): description`
   - Scope is optional but recommended (component/file/module affected)
   - Description is imperative mood, lowercase, no period
   - Under 72 characters

4. **Add body** if the change is non-trivial:
   - Blank line after subject
   - Explain WHAT and WHY, not HOW
   - Wrap at 72 characters

5. **Execute** the commit:

```bash
git commit -m "type(scope): description"
```
