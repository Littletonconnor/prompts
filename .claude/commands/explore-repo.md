Perform a thorough exploration of this repository and give me a comprehensive understanding of it. Work through the following areas systematically:

## 1. Project Identity
- What is this project? What problem does it solve?
- What language(s) and major frameworks/libraries does it use?
- What is the license? How active is development (check recent git log)?

## 2. Entry Points & Build System
- Identify the main entry point(s) (e.g., main.go, index.ts, app.py, etc.)
- What is the build system? Read the build/config files (package.json, Cargo.toml, go.mod, Makefile, etc.)
- How do you build, run, and test the project?

## 3. Directory Structure
- Map out the top-level directory layout and explain what each major directory contains
- Identify where the core logic lives vs. configuration, tests, docs, scripts, etc.

## 4. Core Architecture
- What are the key modules/packages/components and how do they relate to each other?
- What architectural patterns are used (MVC, event-driven, plugin system, microservices, etc.)?
- Trace the main data/request flow through the system from input to output
- Identify the most important interfaces, traits, or abstract classes that define the system's contracts

## 5. Key Design Decisions
- What are the notable technical choices (database, queue, protocol, serialization format, etc.)?
- Are there any unusual or clever patterns worth calling out?
- What are the main extension points or plugin mechanisms, if any?

## 6. Summary
Finish with a concise mental model: a short paragraph I could use to explain this project's architecture to another engineer in under 60 seconds.

Use the Explore agent liberally to search across the codebase. Read key files directly. Prioritize depth on the core architecture over exhaustive coverage of every file.
