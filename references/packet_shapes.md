# Packet Shapes

Source-acceptance contracts used in `skills/source_ingestion/SKILL.md`
during the DETECT phase. Three shapes: conformant, adjacent, foreign.

## Definitions

### Conformant packet

A source that arrives in the format CE_RD_OS expects:

- Markdown or plain text body.
- A `# Title` H1 heading at the top.
- Sections delimited by H2 (`##`) headings.
- Citations clearly marked, either inline (`[Author, Year]`) or in
  a `## Citations` or `## References` section at the end.
- All claims attributable to a citation or marked as personal
  knowledge.

A conformant packet can be ingested directly. The agent paraphrases
where needed and routes the result to the appropriate destination.

### Adjacent packet

A source that arrives in a related but non-conformant format:

- Markdown but missing standard headings.
- Plain text without explicit citation markers.
- HTML with embedded styling and navigation noise.
- PDF text extraction with broken paragraph reflow.

Adjacent packets need normalization (NORMALIZE phase) before INTERROGATE
and SCORE can run. The agent flags the missing structure in the source
metadata record but does not block ingestion.

### Foreign packet

A source that arrives in an incompatible format:

- Code with no documentation.
- Image with no extractable text.
- Audio or video without transcript.
- Binary archive with no declared content.
- Source where provenance cannot be established.
- Source where citations cannot be verified at all.

Foreign packets are routed to quarantine. See
`references/quarantine_procedure.md`.

## Shape detection

The agent walks this checklist during DETECT:

1. Is the format text-readable without specialized tools? If no,
   foreign.
2. Is there a clear title or topic header? If no, adjacent.
3. Are claims separable from opinion or speculation? If no, adjacent.
4. Are citations or provenance markers present? If no, adjacent for
   text sources, foreign for unverifiable sources.
5. Does the source claim authority (institutional, peer-reviewed) that
   can be verified by URL or DOI? If no, drop one tier.

The agent records the shape decision in the source's metadata record
and surfaces the rationale to the user before proceeding past
DETECT.

## What the shapes mean for routing

| Shape | Default route | Override authority |
|---|---|---|
| Conformant | Direct ingestion to references/ or inline use | Architect can quarantine via QUARANTINE.md |
| Adjacent | NORMALIZE then ingest, with caveat in metadata | Architect can promote to conformant after manual review |
| Foreign | Quarantine | Architect can override per quarantine_procedure.md |

## Why the shapes matter

The shapes are a load-bearing safety mechanism. Without them, the
agent will silently coerce foreign sources into the rubric and produce
plausible-looking but unfounded outputs. The shapes force the agent
to acknowledge a source's actual structure before proceeding.

## Citations

- The packet-shape pattern is a CE_RD_OS-specific convention. No
  external citation, but the underlying intuition (acceptance contracts
  for incoming data) is widely used in robust software engineering.

End packet_shapes.
