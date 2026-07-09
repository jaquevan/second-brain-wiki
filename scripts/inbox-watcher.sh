#!/bin/bash
# Wiki Notes Inbox Watcher
# Processes new gemini-*.txt files from Notes Inbox into the second-brain wiki.
# Runs via cron every 2 hours on weekdays.

NOTES_INBOX="$HOME/Desktop/Notes Inbox"
PROCESSED="$NOTES_INBOX/processed"
WIKI_DIR="$HOME/second-brain/wiki"
SOURCES_DIR="$HOME/second-brain/sources"
LOG="$HOME/second-brain/wiki-ingest.log"
SKILL_DIR="$HOME/Desktop/second-brain-wiki"

mkdir -p "$PROCESSED" "$SOURCES_DIR"

FOUND=0
INGESTED=0

for file in "$NOTES_INBOX"/gemini-*.txt; do
    [ -f "$file" ] || continue
    
    basename=$(basename "$file")
    
    if [ -f "$PROCESSED/$basename" ]; then
        continue
    fi
    
    FOUND=$((FOUND + 1))
    
    echo "[$(date '+%Y-%m-%d %H:%M')] Processing: $basename" >> "$LOG"
    
    claude --print --model claude-sonnet-4-6 --max-budget-usd 0.50 \
        --append-system-prompt "You are running the second-brain-wiki skill. Read $SKILL_DIR/SKILL.md for instructions. Read $SKILL_DIR/references/config.md for configuration. Read $SKILL_DIR/references/wiki-page-template.md for the page template." \
        <<PROMPT
/second-brain-wiki Ingest this meeting transcript into my wiki:

$(cat "$file")
PROMPT
    
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        cp "$file" "$SOURCES_DIR/$basename"
        mv "$file" "$PROCESSED/$basename"
        INGESTED=$((INGESTED + 1))
        echo "[$(date '+%Y-%m-%d %H:%M')] OK: $basename ingested" >> "$LOG"
    else
        echo "[$(date '+%Y-%m-%d %H:%M')] FAIL: $basename (exit $EXIT_CODE)" >> "$LOG"
    fi
done

if [ $FOUND -gt 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M')] Done: $INGESTED/$FOUND files ingested" >> "$LOG"
fi
