# Prompts

A collection of prompts, rules, and commands for AI-assisted development.

## Structure

```
prompts/
├── cursor/
│   └── rules/          # Cursor rules (.cursorrules content)
├── claude/
│   ├── commands/       # Slash commands for Claude Code
│   └── system/         # System prompts for Claude Projects
└── shared/             # Platform-agnostic prompts and templates
```

## Setup

### Claude Commands

Symlink commands to make them available as `/command` in Claude Code:

```bash
ln -sf $(pwd)/claude/commands/* ~/.claude/commands/
```

### Formatting

```bash
npm install
npm run format       # Format all markdown
npm run format:check # Check formatting
```

## Usage

### Claude Commands

Each `.md` file in `claude/commands/` becomes a slash command. Use `$ARGUMENTS` as a placeholder for
user input.

### Cursor Rules

Copy rules from `cursor/rules/` into your project's `.cursorrules` file or Cursor settings.

### Shared Prompts

Reference or copy prompts from `shared/` into any AI tool—these are platform-agnostic templates and
frameworks.

## Contributing

1. Add new prompts in the appropriate directory
2. Run `npm run format` before committing
3. Keep prompts focused and reusable
