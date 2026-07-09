# Second Brain Wiki

A personal knowledge management skill for AI coding agents. Ingests any source (text, files, Google Docs, Slack messages, calendar events) into a cross-linked wiki, then provides context retrieval when you need background knowledge.

## What It Does

**Ingest mode**: Give it content, it creates a wiki page with bullet-point summaries, cross-links to related pages, updates the index, and logs the change.

**Context mode**: Ask what you know about a topic, it searches your wiki and returns structured context with direct matches, related pages, and knowledge gaps.

## Directory Structure

```
second-brain-wiki/
├── SKILL.md                      # Main skill instructions
├── references/
│   ├── config.md                 # User configuration (paths, projects, integrations)
│   ├── wiki-page-template.md     # Page template with good/bad examples
│   └── context-retrieval.md      # Context mode output format and examples
├── scripts/
│   └── (future: automation scripts)
└── README.md
```

## Setup

1. Copy this skill into your agent's skills directory (e.g., `.cursor/skills/second-brain-wiki/` or `.claude/skills/second-brain-wiki/`)

2. Create the wiki directory:
```bash
mkdir -p ~/second-brain/{wiki,sources}
touch ~/second-brain/wiki/index.md ~/second-brain/wiki/log.md
```

3. Create the inbox (optional):
```bash
mkdir -p ~/Desktop/"Second Brain Inbox"
```

4. Edit `references/config.md` to set your paths, active projects, and MCP integrations

## Usage

### Ingest content
- "ingest this" + paste text
- "add this to my wiki" + file path
- "wiki this" + Google Doc URL
- "process my inbox" (processes all files in inbox)
- "ingest my meetings" (processes calendar events with notes)

### Retrieve context
- "what do I know about [topic]"
- "context on [topic]"
- "background on [topic]"

## Optional Integrations

| Integration | What it enables |
|-------------|----------------|
| Google Workspace MCP | Google Docs extraction, Calendar event ingestion |
| Slack MCP | Slack message/thread ingestion |

The skill works without these integrations. It just won't be able to ingest from those sources. Local files, pasted text, and URLs always work.

## Calendar Auto-Ingestion

When configured, the skill can automatically process calendar events that have:
- Attached meeting notes or descriptions
- Linked Google Docs (agendas, transcripts)
- Sufficient duration (configurable, default 15min+)

Set `Auto-ingest meetings: true` in `references/config.md` to enable.

## Design Principles

- **Wiki pages are nodes, not articles.** Bullet summaries, not prose paragraphs.
- **Value lives in connections.** Every page should link to at least one other page.
- **Sources are preserved.** Raw content goes to `sources/`, wiki pages are derived summaries.
- **The index is the map.** Categories in `index.md` make the wiki navigable.
- **The log is the changelog.** Every modification is recorded with what changed and why.

## Contributing

This skill follows the [Agent Skills specification](https://agentskills.io/specification.md). When making changes:

1. Keep SKILL.md under 200 lines (currently ~160)
2. Put data and examples in `references/`
3. Keep the anti-patterns section current with observed failure modes
4. Run eval before submitting changes: see `eval.yaml`

## License

MIT
