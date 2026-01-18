# Prompts

A collection of prompts, rules, commands, and skills for AI-assisted development.

## Structure

```
prompts/
├── skills/             # Agent skills (for Claude and Cursor)
│   ├── react-best-practices/
│   └── web-design-guidelines/
├── cursor/
│   └── rules/          # Cursor rules (.cursorrules content)
├── claude/
│   ├── commands/       # Slash commands for Claude Code
│   └── system/         # System prompts for Claude Projects
└── shared/             # Platform-agnostic prompts and templates
```

## Setup

Run the setup script to install commands and skills:

```bash
./setup.sh
```

The script will:

- Install Claude commands to `~/.claude/commands/`
- Install skills to `~/.claude/skills/` and `~/.cursor/skills/`
- Skip items that are already up to date
- Ask before overwriting modified items (with diff option)

### Formatting

```bash
npm install
npm run format       # Format all markdown
npm run format:check # Check formatting
```

## Usage

### Skills

Skills are automatically discovered by Claude Code and Cursor from their respective skills directories.
After running `setup.sh`, skills will be available in both tools.

**Available skills:**

- **react-best-practices** - React/Next.js performance optimization (49 rules across 8 categories)
- **web-design-guidelines** - UI/accessibility/UX best practices (100+ rules, fetched dynamically)

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
