---
allowed-tools: Bash, Read, Write
description: Fix ESLint and TypeScript errors systematically
argument-hint: [file-path or directory]
---

## Task

Fix all ESLint and TypeScript errors in: $ARGUMENTS

If no path provided, run on entire project.

## Critical: tsc Usage

```bash
# ❌ WRONG: tsc --noEmit path/to/file.tsx
# This ignores tsconfig.json (missing jsx, esModuleInterop, paths)

# ✅ RIGHT: Run on project, filter output
tsc --noEmit --skipLibCheck 2>&1 | grep "filename"

# ✅ For entire project
tsc --noEmit --skipLibCheck
```

**Never pass a file path directly to tsc** - it ignores tsconfig.json settings.

## Verification Commands

```bash
# Single file
tsc --noEmit --skipLibCheck 2>&1 | grep "<filename>" && npx eslint <file>

# Directory
tsc --noEmit --skipLibCheck && npx eslint "src/**/*.{ts,tsx}"

# Filter tsc to src/ only
tsc --noEmit --skipLibCheck 2>&1 | grep "^src/"
```

## Common ESLint Errors

| Error                     | Fix                                              |
| ------------------------- | ------------------------------------------------ |
| `no-unsafe-assignment`    | Add explicit return type to source function/hook |
| `no-unsafe-member-access` | Type the variable properly                       |
| `no-unsafe-call`          | Add proper function type                         |
| `no-unsafe-return`        | Type the return value                            |
| `no-explicit-any`         | Use `unknown`, generics, or proper type          |

## Fix Protocol

### Step 1: Collect Errors

```bash
# Get files with TypeScript errors
tsc --noEmit --skipLibCheck 2>&1 | grep -E "\.tsx?:" | cut -d'(' -f1 | sort -u

# Get files with ESLint errors
npx eslint "src/**/*.{ts,tsx}" -f compact 2>&1 | grep -E "\.tsx?:" | cut -d':' -f1 | sort -u
```

### Step 2: Fix Each File

For each file with errors:

1. Run checks on that file
2. Read the errors
3. Fix ALL errors
4. Re-run checks
5. Repeat until zero errors

### Step 3: Verify Clean State

```bash
tsc --noEmit --skipLibCheck && npx eslint "src/**/*.{ts,tsx}"
```

Must be zero errors.

## Fix Patterns

### Unsafe Tuple Destructuring

```typescript
// ❌ no-unsafe-assignment
const [value, setValue] = useUntypedHook();

// ✅ Add return type to hook
function useHook(): [string, (v: string) => void] {
  return [value, setValue];
}
```

### Missing Return Types

```typescript
// ❌ Implicit any return
export function getData() { return fetch(...) }

// ✅ Explicit return type
export function getData(): Promise<Data> { return fetch(...) }
```

### Type Assertions

```typescript
// ❌ as any
const x = data as any

// ✅ Type guard or proper typing
if (isValidData(data)) { ... }
```

## Rules

- Fix errors autonomously, don't ask permission
- Run verification after EVERY file change
- Delete commented-out code while fixing
- If fix requires changing another file, do it
- Max 5 iterations per file - if stuck, report the blocking issue
