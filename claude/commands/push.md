---
allowed-tools: Bash(git:*)
description: Push current branch to origin with a summary of changes
---

## Current State

- Branch: !`git branch --show-current`
- Commits ahead of master: !`git rev-list --count master..HEAD`

## Changes Since Master

!`git log master..HEAD --oneline`

## Summary

Summarize the changes above in 2-3 sentences for a PR description.

## Push

```bash
git push origin HEAD
```

**Never force push.** If push fails due to remote changes, pull first.
