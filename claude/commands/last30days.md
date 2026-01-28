# last30days: Research Any Topic from the Last 30 Days

Research ANY topic across Reddit, X, and the web. Surface what people are actually discussing,
recommending, and debating right now. 30 days of research, 30 seconds of work.

The user's input is: $ARGUMENTS

## Step 1: Parse User Intent

Before doing anything, parse the user's input for:

1. **TOPIC**: What they want to learn about
2. **TARGET TOOL** (if specified): Where they'll use the prompts (e.g., "ChatGPT", "Midjourney",
   "Claude")
3. **QUERY TYPE**:
   - **PROMPTING** - "X prompts", "prompting for X" - user wants techniques and copy-paste prompts
   - **RECOMMENDATIONS** - "best X", "top X", "what X should I use" - user wants a LIST of specific
     things
   - **NEWS** - "what's happening with X", "X news" - user wants current events
   - **GENERAL** - anything else - user wants broad understanding

Common patterns:

- `[topic] for [tool]` - tool IS specified
- `[topic] prompts for [tool]` - tool IS specified
- Just `[topic]` - tool NOT specified, that's OK
- "best [topic]" or "top [topic]" - QUERY_TYPE = RECOMMENDATIONS

**Do NOT ask about target tool before research.** If not specified, ask AFTER showing results.

## Step 2: Research via WebSearch

Run **4-6 WebSearch queries** to cover the topic thoroughly. Choose queries based on QUERY_TYPE:

**If RECOMMENDATIONS** ("best X", "top X"):

- `best {TOPIC} recommendations 2026`
- `{TOPIC} list examples`
- `most popular {TOPIC} reddit`
- `{TOPIC} recommendations site:reddit.com`

**If NEWS** ("what's happening with X"):

- `{TOPIC} news 2026`
- `{TOPIC} announcement update 2026`
- `{TOPIC} reddit discussion`

**If PROMPTING** ("X prompts", "prompting for X"):

- `{TOPIC} prompts examples 2026`
- `{TOPIC} techniques tips`
- `{TOPIC} reddit prompts`
- `{TOPIC} best practices`

**If GENERAL**:

- `{TOPIC} 2026`
- `{TOPIC} discussion reddit`
- `{TOPIC} guide recommendations`
- `{TOPIC} twitter discussion`

**CRITICAL RULES:**

- **USE THE USER'S EXACT TERMINOLOGY** - don't substitute terms based on your own knowledge
- Include "reddit" in at least 2 queries to surface community discussions
- Include "twitter" or "x.com" in at least 1 query to surface X posts
- Run all WebSearch calls in parallel for speed
- **Do NOT output "Sources:" lists** - they are noise

## Step 3: Synthesize Findings

**Ground your synthesis in the ACTUAL research content, not your pre-existing knowledge.**

Read the research output carefully. Pay attention to:

- **Exact product/tool names** mentioned
- **Specific quotes and insights** from the sources
- **What the sources actually say**, not what you assume

### If RECOMMENDATIONS:

Extract SPECIFIC NAMES, not generic patterns. Count mentions, note which sources recommend each.
List by popularity.

### For all types:

Identify from the ACTUAL RESEARCH OUTPUT:

- **PROMPT FORMAT** recommended (JSON, structured params, natural language, keywords)
- Top 3-5 patterns/techniques across multiple sources
- Specific keywords, structures, or approaches mentioned BY THE SOURCES
- Common pitfalls mentioned BY THE SOURCES

## Step 4: Display Results

**If RECOMMENDATIONS** - Show specific things mentioned:

```
Most mentioned:
1. [Specific name] - mentioned {n}x (r/sub, @handle, blog.com)
2. [Specific name] - mentioned {n}x (sources)
3. [Specific name] - mentioned {n}x (sources)
...

Notable mentions: [other things with 1-2 mentions]
```

**If PROMPTING/NEWS/GENERAL** - Show synthesis and patterns:

```
What I learned:

[2-4 sentences synthesizing key insights FROM THE ACTUAL RESEARCH OUTPUT.]

KEY PATTERNS I'll use:
1. [Pattern from research]
2. [Pattern from research]
3. [Pattern from research]
```

**Then show stats:**

```
---
Research complete!
- Web: {n} pages from {domains}
- Top sources: {sources}
```

**Then invite the user:**

```
---
Share your vision for what you want to create and I'll write a thoughtful prompt you can copy-paste directly into {TARGET_TOOL}.
```

**If TARGET_TOOL is still unknown**, ask now (not before research).

**After displaying this, STOP and WAIT for the user to respond.**

## Step 5: When User Shares Their Vision

Write a **single, highly-tailored prompt** using your research expertise.

### Match the FORMAT the research recommends:

- Research says "JSON prompts" -> Write the prompt AS JSON
- Research says "structured parameters" -> Use structured key: value format
- Research says "natural language" -> Use conversational prose
- Research says "keyword lists" -> Use comma-separated keywords

### Output Format:

```
Here's your prompt for {TARGET_TOOL}:

---

[The actual prompt IN THE FORMAT THE RESEARCH RECOMMENDS]

---

This uses [brief 1-line explanation of what research insight you applied].
```

### Quality Checklist:

- FORMAT MATCHES RESEARCH
- Directly addresses what the user said they want to create
- Uses specific patterns/keywords discovered in research
- Ready to paste with zero edits (or minimal [PLACEHOLDERS] clearly marked)

## Step 6: Stay in Expert Mode

After delivering a prompt:

```
---
Expert in: {TOPIC} for {TARGET_TOOL}
Based on: {n} web pages from {domains}

Want another prompt? Just tell me what you're creating next.
```

For follow-up questions:

- **Do NOT run new WebSearches** - you already have the research
- **Answer from what you learned** - cite the sources
- Only do new research if the user asks about a DIFFERENT topic
