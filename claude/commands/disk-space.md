---
allowed-tools: Bash
description: Analyze disk usage and recommend cleanup actions
argument-hint: [directory or category]
---

## Task

Analyze disk space usage and identify cleanup opportunities: $ARGUMENTS

## Step 1: System Overview

Get the big picture first:

```bash
df -h /                    # Overall disk usage
du -sh ~ 2>/dev/null       # Home directory size
```

Report:
- **Total disk**: X GB
- **Used**: X GB (X%)
- **Available**: X GB

## Step 2: Scan Categories

Analyze each category systematically. For each, collect size and top offenders.

### 2.1 Large Files (>500MB)

```bash
find ~ -type f -size +500M 2>/dev/null | head -20
```

### 2.2 Node Modules

```bash
find ~ -name "node_modules" -type d -prune 2>/dev/null
```

### 2.3 Build Artifacts & Caches

Scan for:
- `.next/` - Next.js builds
- `dist/`, `build/` - Generic build output
- `.cache/` - Various tool caches
- `target/` - Rust/Java builds
- `.turbo/` - Turborepo cache
- `*.log` files over 100MB

### 2.4 Package Manager Caches

```bash
du -sh ~/.npm 2>/dev/null          # npm cache
du -sh ~/.yarn 2>/dev/null         # yarn cache
du -sh ~/.pnpm-store 2>/dev/null   # pnpm cache
du -sh ~/Library/Caches/pip 2>/dev/null  # pip cache
```

### 2.5 Docker (if installed)

```bash
docker system df 2>/dev/null
```

Check for:
- Dangling images
- Stopped containers
- Unused volumes
- Build cache

### 2.6 Homebrew (if installed)

```bash
brew cleanup --dry-run 2>/dev/null
du -sh "$(brew --cache)" 2>/dev/null
```

### 2.7 System Caches

```bash
du -sh ~/Library/Caches 2>/dev/null
du -sh ~/.Trash 2>/dev/null
```

## Step 3: Generate Report

Output findings in this format:

```markdown
## Disk Space Analysis

### Summary
| Metric | Value |
|--------|-------|
| Total Disk | X GB |
| Used | X GB (X%) |
| Available | X GB |

### Findings by Category

| Category | Size | Recoverable | Items |
|----------|------|-------------|-------|
| Large Files | X GB | X GB | X files |
| Node Modules | X GB | X GB | X directories |
| Build Artifacts | X GB | X GB | X items |
| Package Caches | X GB | X GB | - |
| Docker | X GB | X GB | X images/containers |
| Homebrew | X GB | X GB | X packages |
| System Caches | X GB | X GB | - |
| **Total Recoverable** | - | **X GB** | - |

### Top 10 Space Consumers
| # | Path | Size | Category |
|---|------|------|----------|
| 1 | /path/to/item | X GB | Type |
| ... | ... | ... | ... |
```

## Step 4: Cleanup Recommendations

Present a prioritized cleanup plan:

```markdown
### Recommended Cleanup Plan

#### Quick Wins (Low Risk, High Impact)
1. [ ] **Trash**: `rm -rf ~/.Trash/*` → X GB
2. [ ] **npm cache**: `npm cache clean --force` → X GB
3. [ ] **Homebrew**: `brew cleanup` → X GB

#### Moderate Impact (Review First)
4. [ ] **Docker**: `docker system prune -a` → X GB
5. [ ] **Old node_modules**: [list specific paths] → X GB

#### Manual Review Required
6. [ ] **Large files**: [list with context] → X GB
7. [ ] **Build artifacts**: [list project paths] → X GB
```

## Autonomy Rules

**Do autonomously:**
- Run all read-only commands (du, find, df, ls, docker system df)
- Scan any directory including hidden directories
- Generate reports and recommendations

**Ask before:**
- Deleting any files or directories
- Running cleanup commands (rm, prune, clean, etc.)
- Modifying any system settings

## Priority Guidelines

**Clean first** (safest):
- Trash
- Package manager caches
- Homebrew old versions

**Review then clean** (moderate):
- Docker unused resources
- node_modules in old projects
- Build artifacts

**Careful review** (risky):
- Large files (may be needed)
- System caches (may affect apps)

## Notes

- Sizes are estimates; actual recoverable space may vary
- Some caches regenerate automatically
- Docker volumes may contain important data
- Always verify before deleting
