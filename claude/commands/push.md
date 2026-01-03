---
allowed-tools: Bash
description: Push current branch to origin with a summary of changes
---

## Current State

- Branch: !`git branch --show-current`

## Task

1. **Detect default branch** by running:

   ```bash
   git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
   ```

   If that fails, try `main`, then `master`.

2. **Show commits ahead** of default branch:

   ```bash
   git log <default-branch>..HEAD --oneline
   ```

3. **Summarize** the changes in 2-3 sentences (useful for PR description).

4. **Push**:
   ```bash
   git push origin HEAD
   ```

**Never force push.** If push fails due to remote changes, pull first.
