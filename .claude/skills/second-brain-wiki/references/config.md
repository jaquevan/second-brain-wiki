# Second Brain Wiki Configuration

This file configures the skill for Evan's environment. Edit paths and
projects as your work evolves.

---

## Paths

| Path | Value | Description |
|------|-------|-------------|
| Wiki directory | `~/second-brain/wiki/` | Where wiki pages live |
| Sources directory | `~/second-brain/sources/` | Raw source files stored here |
| Inbox directory | `~/Desktop/Second Brain Inbox/` | Drop files here for processing |

---

## Active Projects

These are your current projects and areas of focus. The skill uses these
to find connections when ingesting new content.

- **evaluator-super-agent** — automated prototype quality assessment using persona-driven walkthroughs, 7-dimension rubric scoring, actor/evaluator separation
- **prototype-creator** — generates clickable prototypes from RFEs, tiered AC classification, Playwright automation
- **agent-eval-harness** — framework for evaluating AI skill quality, eval.yaml configs, judges, scoring pipelines
- **ai-sdlc-pipeline** — three-phase pipeline: RFE Creator (WHAT) → Prototype Creator (SHOW) → Strat Creator (HOW)
- **my-cursor-claw** — personal workspace with 20+ skills, MCP connections, notetaking, automations
- **decision-kit** — Decision Driven Development toolkit, /strategize, /decide, /journal
- **automated-usability-testing** — simulated usability testing tool, persona YAML files, evaluate-flow protocol
- **archie** — UX research agent for the RHOAIUX team
- **rhoai-prototypes** — RHOAI prototype collection for evaluation

---

## Calendar Integration

| Setting | Value |
|---------|-------|
| Calendar name | `primary` |
| Auto-ingest meetings | `true` |
| Minimum meeting duration | `15 min` |
| Require notes/transcript | `true` |
| Skip recurring without notes | `true` |

Events that qualify for auto-ingestion:
- Have attached meeting notes or a description with substance (not just "Weekly sync")
- Have a linked Google Doc (agenda, transcript, action items)
- Duration is 15+ minutes
- Are not recurring meetings that had no notes added

---

## MCP Integrations

| Integration | MCP Server | Used for |
|-------------|-----------|----------|
| Google Docs | `user-google-workspace` | Extracting doc content |
| Google Calendar | `user-google-workspace` | Meeting ingestion |
| Slack | `project-0-my-cursor-claw-slack` | Channel message ingestion |

---

## Cross-Link Priority

When multiple connections exist, prioritize these categories (from the
wiki index):

1. **Red Hat AI-SDLC** — pipeline components, RFE/prototype/strat flow
2. **Evaluation & Quality** — rubrics, heuristics, eval harness
3. **Tools & Skills** — decision kit, cursor claw, skill overlays
4. **Meetings** — meeting notes with action items and decisions
5. **Standups** — sprint progress and blockers
6. **Session Logs** — what was built and shipped
