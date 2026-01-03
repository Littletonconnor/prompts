---
allowed-tools: Read, Write, Bash, SubAgents, Ask
description: Interview, spec, plan, and execute a feature
argument-hint: [feature-name or "archive" or "resume <spec-name>"]
---

## Directory Structure

```sh
project-root/
├── spec.md                    # Active spec (priority if exists)
└── specs/
    ├── todo/                  # Queue (lowest number = next)
    │   ├── spec_01.md
    │   └── spec_dashboard.md  # Parked (status: in-progress)
    └── complete/              # Archived specs
```

## Autonomy Rules

**Do without asking:** Read files, search code, write/modify files in current directory

**Ask before:** Modifying files outside current directory, deleting anything

Don't ask "would you like me to..." - just do it if in scope.

## Task

$ARGUMENTS

---

## Finding Active Spec

1. If `spec.md` exists at root → use it
2. Else find lowest-numbered `specs/todo/spec_*.md` (skip `status: in-progress`)
3. If none found → offer to create one

## Context Loading

Before starting, read last 3-5 specs from `specs/complete/` to understand project patterns.

---

## Phase 1: Interview

**YOU MUST USE THE ASK TOOL** to interview me. Do not proceed without asking questions.

Ask me one question at a time about:

- Technical implementation details
- UI/UX considerations
- Concerns and tradeoffs
- Edge cases

**Rules:**

- Use the Ask tool for EVERY question - do not assume answers
- Ask non-obvious questions that require my input
- Go deep, don't accept surface-level answers
- Wait for my response before asking the next question
- Continue until spec is truly complete (usually 5-10 questions minimum)
- Only write final spec to file after interview is complete

**Scope creep:** If we identify out-of-scope ideas worth building:

1. Create `specs/todo/spec_{name}.md` with `status: in-progress` header
2. Jot notes there
3. Continue current interview

---

## Phase 2: Research & Plan

Once spec is written:

1. Research codebase - trace code paths, understand patterns
2. Present implementation plan:
   - Files to create/modify
   - Order of operations
   - Key implementation details
   - Risks and edge cases
3. Wait for approval

---

## Phase 3: Execute

When approved ("go", "approved", "do it"):

**FULLY AUTONOMOUS MODE - NO PROMPTING**

- Do NOT ask for confirmation
- Do NOT pause between steps
- Do NOT summarize and wait
- Just execute continuously until done

1. **Parallelize** - Determine which tasks can run simultaneously
2. **Dispatch** - Spawn subagents for parallel work, each with clear scope
3. **Coordinate** - As work completes, dispatch next wave
4. **Report** - Single summary when ALL work is complete

Plan approval = approval for all edits.

---

## Archive Command

When I say "archive" or "complete":

1. Determine next number from `specs/complete/`
2. Add header:

```yaml
---
spec: XX
date: YYYY-MM-DD
builds_on: [spec_01, spec_03] # if applicable
summary: |
  2-3 sentence summary
key_decisions:
  - Decision 1
  - Decision 2
---
```

3. Move to `specs/complete/spec_XX.md`
4. Renumber remaining `specs/todo/` starting at 01

---

## Resume Command

When I say "resume <spec-name>":

1. Read notes from parked spec
2. Remove `status: in-progress`, assign next number
3. Start fresh Phase 1 interview, using notes as context
