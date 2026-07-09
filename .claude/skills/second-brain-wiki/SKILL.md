---
name: second-brain-wiki
description: >-
  Ingests sources into a personal knowledge wiki with automatic cross-linking.
  Accepts raw text, file paths, URLs, Google Docs, Slack messages, or calendar
  events. Creates wiki pages, builds connections between pages, and maintains
  an index and changelog. Also provides context retrieval from the wiki when
  other skills or conversations need background knowledge. Use when the user
  says "ingest this", "add this to my wiki", "save this to second brain",
  "wiki this", "process my inbox", "check my inbox", "what do I know about",
  "context on", "background on", or drops content and wants it filed.
compatibility: >-
  Requires filesystem access and a configured wiki directory. Optional
  integrations: Google Workspace MCP (for Google Docs and Calendar ingestion),
  Slack MCP (for channel message ingestion). Works on macOS and Linux.
---

# Second Brain Wiki

Turns any source into a cross-linked wiki page in your personal knowledge
base. One prompt, full integration.

The wiki lives at a configurable path (default: `~/second-brain/wiki/`).
Read `references/config.md` for setup.

---

## Mode Detection

This skill operates in two modes based on the user's intent:

1. **Ingest mode** (Steps 1-8): User provides content to add to the wiki
2. **Context mode** (Step 9): User asks what the wiki knows about a topic

Trigger phrases for each mode:

| Mode | Trigger phrases |
|------|----------------|
| Ingest | "ingest this", "add to wiki", "wiki this", "save to second brain", "process inbox" |
| Context | "what do I know about", "context on", "background on", "wiki context for" |

---

## Step 0: Check the Inbox

If the user says "process my inbox", "check my inbox", or "ingest my inbox":

1. Read the inbox path from `references/config.md`
2. List all files in the inbox directory
3. Process each file through Steps 1-7
4. After successful ingestion, move the original file to the `sources/`
   directory (keeps the inbox clean)
5. If the inbox is empty, tell the user

---

## Step 1: Detect the input type

| Input type | How to handle |
|---|---|
| Inbox file | Read from inbox directory, move to sources/ after |
| Raw pasted text | Save to `sources/YYYY-MM-DD-slug.md` |
| File path (local) | Read the file directly |
| Google Doc URL | Extract via Google Workspace MCP |
| Slack reference | Extract via Slack MCP `search_messages` |
| URL (web) | Fetch and extract text content |
| Calendar event | Extract via Calendar MCP (see Step 1b) |
| HTML file | Read and extract text content |

---

## Step 1b: Calendar Event Ingestion

When processing calendar events (triggered by "ingest my meetings",
"wiki my calendar", or via automation):

1. Fetch events from the configured calendar using the Calendar MCP
2. For each event with notes, attachments, or a transcript:
   - Extract the event title, date, attendees, and notes/description
   - If a linked Google Doc or transcript exists, fetch its content
3. Create a wiki page with the meeting date and title as the slug
4. Cross-link with attendee pages and topic pages

---

## Step 2: Read existing wiki pages

Scan the wiki directory for all `.md` files (excluding `index.md` and
`log.md`). Read each file's first 10 lines to get titles and topic
summaries for cross-linking decisions.

---

## Step 3: Create the wiki page

Write a new file at `<wiki-dir>/<slug>.md` using the template in
`references/wiki-page-template.md`.

Rules for the page:
- Filename slug: lowercase, hyphens, date-prefixed for temporal content
- Title matches the core topic (not the source filename)
- Content is bullet-point summaries, not essays
- Cross-links use relative markdown links: `[Title](slug.md)`
- Every page has Related and Sources sections

---

## Step 4: Update existing pages with back-links

For each related wiki page identified in Step 3, add a link back to
the new page in its "Related" section (if not already present).

---

## Step 5: Update index.md

Add the new page under the appropriate category in `index.md`. Create
a new category if none of the existing ones fit. Keep categories
alphabetical.

---

## Step 6: Update log.md

Append an entry to `log.md` using this format:

```
## YYYY-MM-DD — Ingested: <source name>
- Created: <slug>.md — <one-line summary>
- Cross-linked with: <list of updated pages>
- Category: <category in index>
```

---

## Step 7: Relate to user context

Read `references/config.md` for the user's active projects and areas
of focus. Before confirming, check if the new content connects to any
of these projects. If it does, add cross-links in both directions.

The value of the wiki is in connections. Even tangential relationships
(an article about a technique used in a project, a meeting where a
topic was briefly discussed) should be linked.

---

## Step 8: Confirm

Tell the user:
- What page was created (with path)
- What existing pages were cross-linked
- How it connects to their active work (if applicable)
- Suggest 1-2 related pages they might want to read

---

## Step 9: Context Retrieval

When the user asks "what do I know about X" or another skill needs
wiki context:

1. Search wiki page titles and first-line summaries for keyword matches
2. Read the full content of matching pages (up to 5 most relevant)
3. Follow cross-links one level deep to gather related context
4. Return a structured summary:
   - Direct matches (pages about the topic)
   - Related context (pages linked to matches)
   - Knowledge gaps (what the wiki doesn't cover yet)

This mode is read-only. It does not create or modify pages.

---

## Anti-Patterns

- Do NOT create a new page if one already exists for the same topic or a
  closely overlapping topic. If "Vector Similarity Search" content overlaps
  substantially with an existing "Vector Databases" page, merge the new
  information into the existing page. Check titles AND content for overlap
  before deciding to create vs update.
- Do NOT write multi-paragraph prose. Wiki pages are nodes with bullet
  summaries, not articles. If you're writing more than 5 sentences in a
  row, you're writing an article.
- Do NOT force cross-links without genuine conceptual connections. "Both
  are about technology" is not a connection. "Both use embeddings for
  similarity search" is.
- Do NOT duplicate source content verbatim. Summarize and link back to
  the source file in `sources/`.
- Do NOT create pages with only a title and no content. Every page needs
  at least 3 bullet points of substance.
- Do NOT use the log as a diary. Log entries are structured records of
  what changed, not reflections.
