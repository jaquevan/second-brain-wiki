# Context Retrieval Reference

How the context mode (Step 9) works when the wiki is queried for
background knowledge.

---

## Search Strategy

1. **Title match**: Check page filenames and H1 titles for keyword overlap
2. **Summary scan**: Read first 3 lines of each page for topic relevance
3. **Cross-link traversal**: Follow Related links one level from matches
4. **Recency weight**: Prefer recently ingested pages when relevance is equal

---

## Output Format (Context Mode)

When returning context to the user or another skill:

```markdown
## Wiki Context: <query>

### Direct Matches
- **<Page Title>** (<slug>.md) — <first-line summary>
  Key points: <2-3 most relevant bullets from the page>

### Related Context
- **<Page Title>** (<slug>.md) — connected via [<linking page>]
  Relevant because: <why this is useful context>

### Knowledge Gaps
- <topic or sub-topic the wiki doesn't cover yet>
- <suggested source to fill the gap, if obvious>
```

---

## Good Context Response

```markdown
## Wiki Context: prototype evaluation

### Direct Matches
- **Prototype Creator** (prototype-creator.md) — Generates and evaluates
  UI prototypes using persona-driven walkthroughs
  Key points: tiered AC classification, Playwright automation, UX rubric scoring

- **Evaluator Super Agent** (evaluator-super-agent.md) — Orchestrates
  multi-persona evaluation of prototypes
  Key points: actor/evaluator separation, 7-dimension rubric, HTML reports

### Related Context
- **Nielsen's Heuristics** (nielsens-heuristics.md) — connected via
  [Evaluator Super Agent]
  Relevant because: the evaluation rubric is based on these heuristics

### Knowledge Gaps
- No page on prototype fidelity levels (lo-fi vs hi-fi evaluation)
- Consider ingesting: PatternFly component evaluation criteria
```

---

## Bad Context Response

```
I found some pages that might be related to your query about prototypes.
The prototype-creator page talks about creating prototypes. The evaluator
page is also related. Let me know if you want more details!
```

**Why it's bad:**
- Vague ("might be related", "also related")
- No structured format
- No key points extracted
- No knowledge gaps identified
- Reads like a chatbot, not a retrieval system
