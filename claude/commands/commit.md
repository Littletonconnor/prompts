---
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git diff:*), Bash(git status:*)
description: Create a well-formatted conventional commit
---

## Current State

- Staged changes: !`git diff --cached --stat`
- Unstaged changes: !`git status --short`

## Task

Create a conventional commit for the staged changes following these rules:

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

5. **Execute** the commit with `git commit -m "..."`

If nothing is staged, suggest what to stage based on unstaged changes.
