---
allowed-tools: Bash(git log:*), Bash(ls:*), Read, Glob, Grep
description: Understand a new open source repository's purpose and architecture
---

## Task

Perform a thorough exploration of this repository and produce a clear mental model of its architecture.

### 1. Project Identity

- What is this project? What problem does it solve?
- Language(s) and major frameworks/libraries
- License and development activity: !`git log --oneline -10`

### 2. Entry Points & Build System

- Identify the main entry point(s) (e.g., main.go, index.ts, app.py)
- Read the build/config files (package.json, Cargo.toml, go.mod, Makefile, etc.)
- How to build, run, and test the project

### 3. Directory Structure

Map the top-level layout and explain what each major directory contains:

```
!`ls -1`
```

### 4. Core Architecture

- Key modules/packages/components and how they relate
- Architectural patterns (MVC, event-driven, plugin system, pipeline, etc.)
- Main data/request flow from input to output
- Important interfaces, traits, or abstract classes that define the system's contracts

### 5. Key Design Decisions

- Notable technical choices (database, protocol, serialization, concurrency model)
- Unusual or clever patterns worth calling out
- Extension points or plugin mechanisms

### 6. Mental Model

Finish with a concise summary: a short paragraph an engineer could use to explain this project's architecture in under 60 seconds.

### Guidelines

- Prioritize depth on core architecture over exhaustive file coverage
- Read key files directly rather than guessing at contents
- Include specific file:line references for important code
