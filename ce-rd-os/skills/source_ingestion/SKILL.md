---
name: source-ingestion
description: >
  Use this skill whenever new source material enters the workstream:
  uploaded files, URLs, paths to local folders, MCP-attached datasets,
  or pasted text blocks. Trigger when the user says "ingest this",
  "absorb these sources", "add to the corpus", "read this and apply",
  or attaches files at session start. Runs the DETECT, NORMALIZE,
  INTERROGATE, SCORE, ROUTE loop. Quarantines anything that cannot
  be conformed.
license: Apache-2.0
metadata:
  version: 0.1.0
  category: ingestion
compatibility:
  hosts:
    - claude-code
    - codex-cli
    - cursor
    - aider
    - continue-dev
    - notebooklm
    - claude-project
    - custom-gem
    - custom-gpt
---

# source_ingestion

The five-phase loop applied to every incoming source.

## DETECT

Identify what kind of source this is. The agent classifies by:

- **Format.** PDF, MD, HTML, TXT, JSON, YAML, CSV, code file, image,
  binary archive, MCP stream, web URL.
- **Provenance.** User-uploaded, project-knowledge, MCP-fetched,
  web-search-result, agent-generated.
- **Tier per system_directive source hierarchy.** Tier 1, 2, 3, or 4.
- **Packet shape.** Conformant, adjacent, or foreign. See
  `references/packet_shapes.md`.

Output of DETECT: a packet metadata record with `format, provenance,
tier, packet_shape` fields.

## NORMALIZE

Convert the source to a clean text representation the agent can read.

- PDF: text extraction, OCR if needed, structured table extraction.
- HTML: strip navigation, extract main content, preserve citations.
- Code: keep verbatim, classify by language, extract docstrings.
- Image: visual description plus any extractable text.
- Binary archives: list contents, extract relevant files, normalize
  each.

Output of NORMALIZE: clean markdown or text, with original formatting
preserved where load-bearing.

## INTERROGATE

Ask the source the load-bearing questions before scoring it.

The Socratic question patterns are in
`references/socratic_question_bank.md`. Cap at three questions per
ingestion turn so the agent and user can review answers without
overwhelm.

Standard interrogation set:

1. **What is this source's claim?** One sentence.
2. **What is the evidence?** Citation, methodology, sample size.
3. **What does it not cover?** Negative space matters as much as
   positive content.
4. **Who else has cited it?** Provenance signal.
5. **What would falsify it?** If nothing could falsify it, it is
   not Tier 2 evidence.

If the source cannot answer the interrogation (it is too short, too
vague, or the user does not know), the agent flags it and asks the
user how to proceed.

## SCORE

Apply the Trinity rubric (default boolean-atomic mode) to the source.

The 9 cells:

| | Coverage | Self-contained | Importance |
|---|---|---|---|
| Pathos (does this serve our mission?) | P-Cov | P-Self | P-Imp |
| Ethos (is the source itself credible?) | E-Cov | E-Self | E-Imp |
| Logos (does the rubric pass?) | L-Cov | L-Self | L-Imp |

Boolean-atomic: each cell is 0 or 1. Default threshold for ingestion:
all 9 cells must pass.

Lower thresholds (e.g., 7 of 9) are acceptable for adjacent packet
shapes (see `references/packet_shapes.md`) provided the missing cells
are flagged in the source's metadata record.

## ROUTE

Send the scored source to the right destination.

| Outcome | Destination |
|---|---|
| All 9 cells pass, conformant shape | `references/` if it is a paraphrase of a Tier-1 source, or directly cited inline. |
| 7-8 cells pass, conformant or adjacent shape | Inline use with explicit caveat about the missing cells. |
| Below 7 cells, any shape | Quarantine. See `references/quarantine_procedure.md`. |
| Foreign shape regardless of cells | Quarantine. The agent does not silently coerce foreign sources into the rubric. |
| Source claims rubric exemption ("trust me, this is legit") | Quarantine until the user provides the missing evidence. |

## Quarantine

Quarantined sources are placed in a project-side `QUARANTINE/` folder
with an explanatory README. The user can override quarantine via the
procedure in `references/quarantine_procedure.md`. Override requires
explicit user confirmation per turn.

The agent never silently overrides quarantine. The agent never
removes the quarantine warning from a source's metadata record.

## What this skill does NOT do

- Does not paraphrase or transform the source's content for the user
  unless explicitly asked. The user reads the original first.
- Does not auto-cite. Citations are added by the agent only after
  the source clears all 9 cells.
- Does not rewrite or summarize sources beyond a 30-word ceiling per
  source per response, per the system_directive output contract.
- Does not load the source's full body into the conversation if the
  source is over roughly 5000 lines. Instead, the agent registers
  the source and accesses it on demand via tool calls.

## Multi-turn handling

If the source set exceeds the host's context window, the agent:

1. Tells the user the limit was hit.
2. Saves a partial ingestion record as a host-side note.
3. Asks the user to delete the just-ingested sources from the host's
   active context.
4. Asks the user to re-add the next batch.
5. Resumes ingestion from the partial record.

This is the multi-turn pattern documented in `packets/PROCEED.md`.

## Citations

- arXiv:2507.17746, RaR, for the Coverage / Self-contained / Importance
  rubric design.
- arXiv:2510.07743, OpenRubrics, for synthetic rubric generation in
  novel domains.
- The packet-shape classification (conformant, adjacent, foreign) is
  documented in `references/packet_shapes.md`.
- The quarantine procedure is documented in
  `references/quarantine_procedure.md`.

End source_ingestion.
