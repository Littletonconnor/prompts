# Dependency Audit

Audit project dependencies for security vulnerabilities, outdated packages, and upgrade
opportunities.

## Step 1: Detect Package Manager

Check for dependency files:

- `package.json` / `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock` → Node.js
- `requirements.txt` / `Pipfile` / `pyproject.toml` → Python
- `Gemfile` / `Gemfile.lock` → Ruby
- `go.mod` → Go
- `Cargo.toml` → Rust

## Step 2: Security Scan

Run the appropriate audit command:

```bash
# Node.js
npm audit --json
# or
pnpm audit --json

# Python
pip-audit --format json

# Ruby
bundle audit check

# Go
govulncheck ./...
```

Extract:

- Critical vulnerabilities (fix immediately)
- High severity (fix this sprint)
- Medium/Low (plan for later)

## Step 3: Outdated Packages

```bash
# Node.js
npm outdated --json

# Python
pip list --outdated --format json

# Ruby
bundle outdated
```

Categorize by update type:

| Type                  | Risk   | Examples                                  |
| --------------------- | ------ | ----------------------------------------- |
| Patch (1.0.0 → 1.0.1) | Low    | Bug fixes, security patches               |
| Minor (1.0.0 → 1.1.0) | Medium | New features, usually backward compatible |
| Major (1.0.0 → 2.0.0) | High   | Breaking changes, requires migration      |

## Step 4: Priority Assessment

Score each outdated package:

**Upgrade Immediately:**

- Has known vulnerability (any severity)
- Security-related package (auth, crypto, etc.)
- 3+ major versions behind

**Upgrade Soon:**

- 1-2 major versions behind
- Transitive dependency of vulnerable package
- Deprecated or unmaintained

**Upgrade When Convenient:**

- Minor/patch updates only
- Dev dependencies
- No security implications

## Step 5: Output

### Vulnerability Summary

| Package | Current | Severity | CVE | Fix Version |
| ------- | ------- | -------- | --- | ----------- |
| ...     | ...     | ...      | ... | ...         |

### Outdated Packages

| Package | Current | Latest | Type  | Priority |
| ------- | ------- | ------ | ----- | -------- |
| ...     | ...     | ...    | Major | High     |

### Upgrade Plan

**Phase 1: Security Fixes** (do first)

```bash
# Commands to fix vulnerabilities
npm update package-name
```

**Phase 2: Major Upgrades** (one at a time)

For each major upgrade:

1. Read changelog/migration guide
2. Check for breaking changes
3. Update package
4. Run tests
5. Fix any breaks
6. Commit

**Phase 3: Minor/Patch Updates** (batch together)

```bash
# Safe to batch
npm update
```

### Test Strategy

After each upgrade phase:

- [ ] Run full test suite
- [ ] Check for deprecation warnings in console
- [ ] Smoke test critical paths
- [ ] Review bundle size changes (for frontend)
