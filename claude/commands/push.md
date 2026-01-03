---
allowed-tools: Bash(git:*)
description: Push current branch to origin with a summary of changes
---

## Current State

- Branch: !`git branch --show-current`
- Default branch:
  !`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main"`

## Changes Since Default Branch

!`git log $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")..HEAD --oneline 2>/dev/null || echo "No commits ahead or default branch not found"`

## Summary

Summarize the changes above in 2-3 sentences for a PR description.

## Push

```bash
git push origin HEAD
```

**Never force push.** If push fails due to remote changes, pull first.
