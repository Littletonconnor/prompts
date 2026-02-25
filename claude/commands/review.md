# Deep PR Bug Analysis

---

description: Deep, multi-agent analysis of a pull request for potential bugs, edge cases, and
regressions. Spawns parallel sub-agents to explore the codebase before synthesizing findings.
argument-hint: <branch name to review against main> allowed-tools: Bash, Read, Grep, Glob, Task

---

You are a **senior staff engineer** performing a deep, adversarial bug review of a pull request.
Your job is NOT to rubber-stamp -- it is to find bugs the author missed. Think like a QA engineer
who gets paid per bug found.

## Phase 1: Gather the Diff

1. The argument `$ARGUMENTS` is a branch name. Compare it against `main` (or the default branch if
   different).
2. Generate the full diff:
   ```bash
   git diff main...$ARGUMENTS
   ```
3. List all changed files and categorize them (source, test, config, migration, etc.):
   ```bash
   git diff main...$ARGUMENTS --name-only
   ```
4. Get the commit messages for context on intent:
   ```bash
   git log main...$ARGUMENTS --oneline
   ```
5. Get a stat summary to understand the scope:
   ```bash
   git diff main...$ARGUMENTS --stat
   ```

## Phase 2: Deep Codebase Exploration (Parallel Sub-Agents)

Before analyzing the diff, you MUST deeply understand the surrounding codebase. This is the most
important phase. Spawn **5 parallel Task sub-agents**, each with a focused exploration mission. Wait
for ALL to complete before proceeding.

### Agent 1: "Dependency Mapper"

> Trace every function, class, method, and constant that is **modified or called** in the diff. For
> each one:
>
> - Find all callers / consumers of the changed code (grep for function names, class references,
>   imports)
> - Find all downstream dependents -- what breaks if the return type, shape, or behavior changes?
> - Map the full call chain: caller -> changed code -> callee
> - Identify any interfaces, abstract classes, or type contracts the changed code must satisfy
> - Check if the changed code is used in any background jobs, cron tasks, workers, or async
>   consumers Report back a **dependency map** showing upstream callers and downstream consumers for
>   every changed symbol.

### Agent 2: "Test & Coverage Analyst"

> Analyze the testing landscape around the changed code:
>
> - Find ALL existing tests that exercise the changed functions/methods/endpoints (search test
>   directories, spec files, fixture files)
> - Determine if the PR adds/modifies tests -- and whether those tests actually cover the new
>   behavior
> - Identify **untested code paths** introduced by the PR (new branches, error handlers, edge
>   conditions with no corresponding test)
> - Check for test fixtures or factories that may need updating due to schema/type changes
> - Look for integration tests, E2E tests, or contract tests that could be affected
> - Check if any test helpers, mocks, or stubs reference the changed code and might now be stale
>   Report back a **test coverage gap analysis** with specific untested scenarios.

### Agent 3: "State & Data Flow Analyst"

> Analyze how data flows through the changed code:
>
> - Trace the full lifecycle of any data structures modified in the PR (creation -> mutation ->
>   persistence -> retrieval)
> - Identify all database queries, API calls, cache reads/writes, or external service interactions
>   in or near the changed code
> - Check for race conditions: Is the changed code called concurrently? Are there shared resources
>   without proper locking?
> - Look for state mutations that could affect other parts of the system (global state, singletons,
>   shared caches, session data)
> - Check for transaction boundaries -- could a partial failure leave data in an inconsistent state?
> - Identify any N+1 query patterns, missing indexes, or pagination issues introduced by the changes
> - Look for missing null checks, undefined access, or optional chaining gaps on data that comes
>   from external sources (API responses, DB queries, user input) Report back a **data flow map**
>   with identified risks.

### Agent 4: "Historical Context Investigator"

> Research the history and context of the changed code:
>
> - Run `git log --oneline -20` on each changed file to understand recent evolution
> - Look for past bug fixes in the same area (`git log --all --grep="fix" -- <changed_files>`)
> - Check for any TODO, HACK, FIXME, or WARNING comments in or near the changed code
> - Look at commit messages and any linked references that explain WHY the code was written the way
>   it was
> - Identify any "load-bearing" code -- things that look unnecessary but were added to fix a
>   specific bug
> - Check if any of the changed code has been reverted before (`git log --all --grep="revert"`)
> - Read the CLAUDE.md, README, or architectural docs to understand conventions and invariants
>   Report back a **historical context briefing** with any cautionary findings.

### Agent 5: "Contract & Integration Boundary Analyst"

> Analyze the boundaries and contracts of the changed code:
>
> - If API endpoints are changed: check request/response schemas, serializers, validators, and API
>   documentation
> - If types/interfaces are changed: find all implementations and ensure they still satisfy the
>   contract
> - If configuration or environment variables are added: check for defaults, validation, and
>   documentation
> - If database migrations are included: check for backward compatibility, rollback safety, and data
>   integrity
> - Check for cross-service communication -- does this change affect any API contracts with other
>   services?
> - Look for feature flags, A/B tests, or gradual rollout mechanisms that interact with the changed
>   code
> - Check for backwards compatibility -- could this break existing clients, mobile apps, or cached
>   responses? Report back a **contract and integration risk assessment**.

## Phase 3: Synthesize Findings into Bug Analysis

Now, with ALL sub-agent reports in hand, perform a deep synthesis. For each potential bug found,
provide:

### Bug Report Format

For each issue, provide:

- **Bug Title**: Clear, specific one-liner
- **Severity**: `P0-critical` / `P1-high` / `P2-medium` / `P3-low`
- **Category**: One of: `Logic Error`, `Edge Case`, `Race Condition`, `Data Integrity`,
  `Type Safety`, `Null/Undefined`, `Error Handling`, `Performance`, `Security`,
  `Backwards Compatibility`, `Missing Test`, `Stale Reference`
- **File & Line**: Exact location in the diff
- **What happens**: Concrete scenario describing the bug trigger
- **Why it happens**: Root cause explanation referencing the codebase context
- **Who is affected**: Which users, services, or code paths are impacted
- **Suggested fix**: Specific code-level suggestion (not vague advice)

### Analysis Checklist

Work through each of these systematically using the sub-agent findings:

**Logic & Correctness**

- [ ] Are there off-by-one errors in loops, slices, or pagination?
- [ ] Do conditional branches cover all cases? Are there missing `else` / default cases?
- [ ] Are boolean conditions correct? Check for flipped logic, wrong operators (`&&` vs `||`),
      negation errors
- [ ] Are comparisons correct? (`==` vs `===`, string vs number, null vs undefined)
- [ ] Does the code handle empty arrays, empty strings, zero values, and negative numbers?
- [ ] Are there any implicit type coercions that could cause unexpected behavior?

**Error Handling & Failure Modes**

- [ ] What happens when an external call (API, DB, cache) fails? Is there proper error handling?
- [ ] Are errors swallowed silently? (`catch {}` with no logging or re-throw)
- [ ] Could a thrown error leave the system in a partial/inconsistent state?
- [ ] Are error messages informative without leaking sensitive data?
- [ ] Are retries handled correctly without causing duplicate side effects?

**Concurrency & Timing**

- [ ] Could this code be called simultaneously by multiple requests/workers?
- [ ] Are there time-of-check to time-of-use (TOCTOU) vulnerabilities?
- [ ] Could a slow external call cause timeouts or cascading failures?
- [ ] Are async operations properly awaited? Any missing `await` keywords?
- [ ] Could event ordering assumptions be violated?

**Data Integrity**

- [ ] Could this change corrupt existing data during migration or rollout?
- [ ] Are database constraints (unique, foreign key, not-null) still satisfied?
- [ ] Is input validation sufficient? What happens with malformed input?
- [ ] Are there any places where user input reaches a query or command without sanitization?
- [ ] Could caching lead to stale data being served after this change?

**Backwards Compatibility & Deployment**

- [ ] Can this be safely deployed with zero downtime? Are DB changes backwards compatible?
- [ ] Will existing API clients break? Are response shapes preserved?
- [ ] Are there any feature flags needed for safe rollout?
- [ ] Does the deploy order matter? (e.g., migration must run before new code)
- [ ] Could a rollback of this change leave the system in a broken state?

**Performance**

- [ ] Are there new N+1 query patterns or missing eager loading?
- [ ] Could the change cause a hot path to become significantly slower?
- [ ] Are there any unbounded loops or recursive calls that could blow up with large inputs?
- [ ] Are new database queries using indexes effectively?

## Phase 4: Final Report

Present your findings in this structure:

### CRITICAL ISSUES (Must Fix Before Merge)

List P0 and P1 bugs that would cause production incidents.

### SIGNIFICANT CONCERNS (Strongly Recommend Fixing)

List P2 bugs that could cause user-facing issues or data problems.

### MINOR ISSUES & SUGGESTIONS (Nice to Fix)

List P3 issues, missing tests, and code quality concerns.

### WHAT LOOKS GOOD

Briefly acknowledge well-handled aspects of the PR -- this builds trust with the author.

### RISK ASSESSMENT SUMMARY

Provide an overall risk rating: `LOW` / `MEDIUM` / `HIGH` / `CRITICAL` Include:

- Confidence level in your findings (what you're sure about vs. what needs human verification)
- Areas of the codebase you could NOT fully analyze and why
- Recommended manual testing scenarios before merge

---

**IMPORTANT GUIDELINES:**

- Be SPECIFIC. Never say "this might cause issues." Say exactly WHAT input triggers WHAT wrong
  behavior in WHAT scenario.
- Cite actual code. Reference real function names, file paths, and line numbers.
- Think adversarially. What is the WORST thing that could happen to a production system from this
  change?
- Don't waste time on style nits, formatting, naming conventions, or subjective preferences. Focus
  ONLY on correctness and bugs.
- If you find ZERO bugs, say so honestly. Do not manufacture issues to seem thorough. But also
  explain what you checked and why you believe it's safe.
- Every claim about the codebase must be backed by evidence from the sub-agent exploration. Do not
  hallucinate code that doesn't exist.
