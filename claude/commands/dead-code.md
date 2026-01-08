---
allowed-tools: Bash, Read, Write
description: Find unused code in a file or directory
argument-hint: <file-path or directory>
---

## Task

Analyze for dead code: $ARGUMENTS

## Step 1: Catalog Exports & Definitions

Read the source file(s) and list:

**Exports**

- [ ] Exported functions
- [ ] Exported classes
- [ ] Exported constants
- [ ] Exported types/interfaces

**Internal Definitions**

- [ ] Private functions
- [ ] Local variables
- [ ] Helper classes
- [ ] Internal constants

**Imports**

- [ ] Named imports
- [ ] Default imports
- [ ] Namespace imports
- [ ] Type-only imports

## Step 2: Search for Usages

For each definition, search the codebase:

```bash
# Find usages of a symbol
grep -r "symbolName" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" .

# Exclude the definition file itself
grep -r "symbolName" --include="*.ts" . | grep -v "definition-file.ts"
```

Check:

- Direct calls/references
- Re-exports from index files
- Dynamic imports
- String references (for reflection/dynamic access)

## Step 3: Dead Code Report

```markdown
## Dead Code Analysis: <file>

### Unused Exports ❌

| Symbol            | Type     | Line | Confidence |
| ----------------- | -------- | ---- | ---------- |
| `oldHelper()`     | function | 45   | High       |
| `LegacyClass`     | class    | 120  | High       |
| `DEPRECATED_FLAG` | const    | 12   | Medium     |

### Unused Imports ❌

| Import       | From    | Line |
| ------------ | ------- | ---- |
| `unusedUtil` | ./utils | 3    |
| `OldType`    | ./types | 5    |

### Unused Internal Code ❌

| Symbol             | Type     | Line | Confidence |
| ------------------ | -------- | ---- | ---------- |
| `_privateHelper()` | function | 89   | High       |
| `tempVar`          | variable | 34   | High       |

### Potentially Dead (Review Needed) ⚠️

| Symbol           | Type     | Line | Reason                     |
| ---------------- | -------- | ---- | -------------------------- |
| `dynamicHandler` | function | 67   | May be called dynamically  |
| `EventType`      | type     | 23   | Only used in type position |

### Summary

- **Unused exports**: X
- **Unused imports**: Y
- **Unused internal**: Z
- **Safe to remove**: [list with high confidence]
```

## Step 4: Cleanup

After presenting the report, ask:

> Would you like me to remove the dead code? I'll start with high-confidence items.

If yes:

1. Remove unused imports first
2. Remove unused internal code
3. Remove unused exports (verify no external consumers)
4. Run tests after each removal

## Confidence Levels

**High** (safe to remove):

- No references found anywhere in codebase
- Not in public API / package exports
- Not referenced in config files

**Medium** (probably safe):

- Only referenced in comments or strings
- Deprecated but may have external consumers
- Test-only usage

**Low** (investigate first):

- Dynamic access patterns (`obj[key]`)
- Reflection or metaprogramming
- Public package exports
- Referenced in build configs

## False Positive Checks

Before marking as dead, verify:

- [ ] Not used in test files
- [ ] Not exported from package index
- [ ] Not referenced in config (webpack, babel, etc.)
- [ ] Not used via dynamic import
- [ ] Not an API endpoint handler
- [ ] Not a CLI command
- [ ] Not a lifecycle hook (React, Vue, etc.)

## Rules

- Never remove code that's part of a public API without confirmation
- Check git history - recently added code might have pending usage
- Commented-out code is always dead - remove it
- Be cautious with framework hooks/callbacks (may be called implicitly)
