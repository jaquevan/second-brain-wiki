# Wiki Page Template

Use this template when creating new wiki pages. Copy the structure,
fill in the bracketed fields.

---

## Template

```markdown
# <Page Title>

<One-sentence summary of what this page covers.>

## Key Points

- <Bullet point 1: a concrete fact, concept, or takeaway>
- <Bullet point 2>
- <Bullet point 3>
- <Additional bullets as needed, max 10>

## Related

- [<Related Page Title>](<related-slug>.md) — <one-line reason for connection>
- [<Another Related Page>](<slug>.md) — <connection reason>

## Sources

- <path/to/source/file or URL where this came from>
- Ingested: <YYYY-MM-DD>
```

---

## Good Example

```markdown
# Retrieval Augmented Generation

Technique that grounds LLM responses in retrieved documents rather than
relying solely on training data.

## Key Points

- Combines a retriever (vector search) with a generator (LLM)
- Reduces hallucination by providing source documents as context
- Trade-off: retrieval quality limits generation quality
- Common stack: embeddings → vector DB → reranker → LLM prompt
- Works best when source corpus is well-chunked and up-to-date

## Related

- [Vector Databases](vector-databases.md) — the retrieval layer in RAG pipelines
- [Agent Eval Harness](agent-eval-harness.md) — uses embedding similarity for judge calibration

## Sources

- ~/second-brain/sources/what-is-rag.md
- Ingested: 2026-06-10
```

---

## Bad Example

```markdown
# RAG

Retrieval Augmented Generation (RAG) is a technique in artificial intelligence
that combines information retrieval with text generation. It was first proposed
by Lewis et al. in 2020. The basic idea is that instead of relying solely on
what a language model learned during training, you can augment it with relevant
documents retrieved at inference time.

This approach has several advantages. First, it reduces hallucination because
the model can reference actual documents. Second, it allows the model to access
up-to-date information that wasn't in its training data. Third, it provides
transparency because you can trace responses back to source documents.

There are several implementations of RAG available today...
```

**Why it's bad:**
- Reads like a Wikipedia article, not a wiki node
- No bullet summaries (walls of prose)
- No Related section (isolated page, no connections)
- No Sources section (where did this come from?)
- Title is an acronym without expansion
- Contains filler ("There are several..." "This approach has...")
