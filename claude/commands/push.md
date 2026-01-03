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

5. **Output PR-ready content** after successful push:

   Generate a **title** from the branch name:
   - Strip prefixes: `feature/`, `fix/`, `bugfix/`, `chore/`, `feat/`, `hotfix/`
   - Replace `-` and `_` with spaces
   - Title case the result
   - Example: `feature/add-user-auth` → "Add User Auth"
   - If branch name is generic (like `dev` or `wip`), use the first commit subject instead

   Output in this format:
   ```
   ## PR Ready

   **Title:** <generated title>

   **Description:**
   <the 2-3 sentence summary from step 3>
   ```

**Never force push.** If push fails due to remote changes, pull first.
