---
allowed-tools: Read, Write, Bash
description: Analyze and refactor code systematically
argument-hint: <file-path>
---

## Principles

1. **Don't refactor for refactoring's sake** - if code already follows good patterns, leave it
2. **Discovery first** - understand patterns before modifying
3. **Strict types** - no `any`, explicit return types on exports
4. **No dead code** - delete commented-out code immediately

## Task

Analyze and refactor: $ARGUMENTS

### Phase 1: Discovery

Before modifying, search for:

- Similar components/hooks in codebase
- All files importing target
- Existing shared types, hooks, utils

**Rules:** Reuse existing patterns. Don't create duplicates.

### Phase 2: Assessment

Grade A-F on:

- **Readability**: Can a new dev understand this in 5 minutes?
- **Maintainability**: How hard is it to change?
- **Testability**: Can you unit test this easily?

### Phase 3: Identify Issues

Check for:

- [ ] Long Method / Large Class
- [ ] Duplicate Code
- [ ] Dead Code / Commented-out code
- [ ] Feature Envy / Inappropriate Intimacy
- [ ] Primitive Obsession / Data Clumps
- [ ] Complex conditionals / Switch Statements
- [ ] Derived state in useState (compute inline instead)
- [ ] Inline fn to memoized child (use useCallback)
- [ ] Premature abstraction / Speculative Generality

### Phase 4: TypeScript Patterns

**No `any` - use `unknown` + type guards**

```typescript
const data: unknown = fetchData();
if (isUserData(data)) data.name;
```

**Explicit return types on exports**

```typescript
export function getUser(id: string): User | undefined { ... }
export function useToggle(initial: boolean): [boolean, () => void] { ... }
```

**Discriminated unions over booleans**

```typescript
type State =
  | { status: "loading" }
  | { status: "success"; data: Data }
  | { status: "error"; error: Error };
```

**`as const` for literals**

```typescript
const STATUSES = ["pending", "active", "done"] as const;
type Status = (typeof STATUSES)[number];
```

**Exhaustive checks with `never`**

```typescript
function assertNever(x: never): never {
  throw new Error(`Unexpected: ${x}`);
}
```

### Phase 5: Simplification

**Duplication → Parameterized function**

```typescript
const handleInput = (field: Field) => (e) => setters[field](e.target.value);
```

**Nested ternaries → Lookup object**

```typescript
const ICONS = { a: "✓", b: "⏳" } as const satisfies Record<Status, string>;
```

**Magic values → Named constants**

```typescript
const THRESHOLDS = { PREMIUM: 100, LOW_STOCK: 5 } as const;
```

**Boolean explosion → State machine / useReducer**

### Phase 6: Component Structure

```typescript
// 1. Imports (React → External → Internal)
// 2. Constants
// 3. Types
// 4. Pure helpers (outside component)
// 5. Component
export function List({ items }: Props) {
  // a. State → b. Refs → c. Context → d. Custom hooks
  // e. useMemo → f. useCallback → g. useEffect
  // h. Event handlers → i. Early returns → j. Main render
}
```

### Phase 7: File Organization

**Colocate when:** tightly coupled, single consumer, feature-specific

**Move to shared when:** 3+ consumers, generic utility

### Phase 8: Recommend Actions

For each issue, suggest specific refactoring:

- Extract Method / Extract Class
- Rename Variable/Function
- Introduce Parameter Object
- Replace Conditional with Polymorphism
- Replace Magic Number with Constant

**STOP HERE and wait for approval before implementing.**

### Phase 9: Execute (after approval)

1. Make one change
2. Run tests
3. Commit if green
4. Repeat

Never refactor and change behavior in the same commit.

## When to Refactor

**Do refactor:** >250 lines, logic duplicated 3+, loose types, unclear code

**Don't refactor:** already clean, no specific goal, before deadline, "just to refactor"
