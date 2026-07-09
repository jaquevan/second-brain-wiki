# Second Brain Wiki Configuration

Edit this file to configure the skill for your environment.

---

## Paths

| Path | Default | Description |
|------|---------|-------------|
| Wiki directory | `~/second-brain/wiki/` | Where wiki pages live |
| Sources directory | `~/second-brain/sources/` | Raw source files are stored here |
| Inbox directory | `~/Desktop/Second Brain Inbox/` | Drop files here for processing |

---

## Active Projects

List your current projects/areas of focus here. The skill uses these
to find connections when ingesting new content.

Format: `- **project-name** — brief description of what it involves`

- **example-project** — describe what this project is about
- **another-project** — key topics and technologies involved

---

## Calendar Integration

| Setting | Value |
|---------|-------|
| Calendar name | `primary` |
| Auto-ingest meetings | `false` |
| Minimum meeting duration | `15 min` |
| Require notes/transcript | `true` |

When auto-ingest is enabled, the skill processes calendar events that
have attached notes, transcripts, or linked Google Docs. Events without
substantive content are skipped.

---

## MCP Integrations (Optional)

| Integration | MCP Server | Used for |
|-------------|-----------|----------|
| Google Docs | `user-google-workspace` | Extracting doc content |
| Google Calendar | `user-google-workspace` | Meeting ingestion |
| Slack | Slack MCP server | Channel message ingestion |

If an MCP server is not configured, the skill skips that input type
and tells the user what's unavailable.
