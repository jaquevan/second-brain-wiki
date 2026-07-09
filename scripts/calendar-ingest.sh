#!/bin/bash
# Wiki Calendar Ingest
# Fetches today's completed calendar events and ingests those with notes.
# Runs via cron every hour on weekdays.

WIKI_DIR="$HOME/second-brain/wiki"
LOG="$HOME/second-brain/wiki-ingest.log"
SKILL_DIR="$HOME/Desktop/second-brain-wiki"

echo "[$(date '+%Y-%m-%d %H:%M')] Calendar ingest started" >> "$LOG"

claude --print --model claude-sonnet-4-6 --max-budget-usd 0.50 \
    --append-system-prompt "You are running the second-brain-wiki skill. Read $SKILL_DIR/SKILL.md for instructions. Read $SKILL_DIR/references/config.md for configuration. Read $SKILL_DIR/references/wiki-page-template.md for the page template." \
    <<'PROMPT'
/second-brain-wiki Ingest my recent calendar events.

Check today's calendar events that have already ended. For each event with substantive notes, a description beyond just the title, or a linked Google Doc:

1. Check if a wiki page already exists for this meeting (by date + title)
2. If already ingested, skip it
3. If new: create a wiki page, cross-link, update index and log
4. Skip events shorter than 15 minutes
5. Skip recurring meetings with no notes added

Report what was ingested and what was skipped.
PROMPT

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M')] Calendar ingest OK" >> "$LOG"
else
    echo "[$(date '+%Y-%m-%d %H:%M')] Calendar ingest FAIL (exit $EXIT_CODE)" >> "$LOG"
fi
