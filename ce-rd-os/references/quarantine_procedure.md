# Quarantine Procedure

Procedure for handling foreign-shaped sources or any source the
trinity_rubric flags below threshold.

## When quarantine triggers

- A source's packet shape is `foreign` (per
  `references/packet_shapes.md`).
- A source scores below threshold on the trinity_rubric (default
  threshold: all 9 cells must pass for boolean mode).
- The user explicitly tags a source as quarantined.
- A source's provenance cannot be established.

## What quarantine looks like

The source is moved (or copied, if it lives in a non-mutable location)
to a project-side `QUARANTINE/` folder. A README at
`QUARANTINE/README.md` lists every quarantined source with:

- Original location.
- Date quarantined.
- Reason (foreign shape, low rubric score, provenance unverifiable, etc.).
- Architect override status (none, requested, granted, denied).

The agent never silently ingests a quarantined source. The agent never
removes the quarantine warning from a source's metadata record.

## Architect override procedure

If the user wants to use a quarantined source despite the flag:

1. **Surface the quarantine.** The agent quotes the quarantine reason
   from QUARANTINE/README.md.
2. **Ask the user the load-bearing question.** "This source is
   quarantined because <reason>. Are you sure you want to proceed
   with it for this workstream?"
3. **Wait for explicit confirmation.** "Yes, proceed" or equivalent.
   "Maybe" or hesitation is not confirmation.
4. **Log the override.** Append to QUARANTINE/README.md: "Override
   granted by architect on <date> for workstream <name>. Quarantine
   warning persists in source metadata."
5. **Proceed with caveats.** The agent uses the source but every
   downstream output that draws on it includes a caveat:
   "Note: this output draws on a quarantined source. See
   QUARANTINE/README.md."

## What override does NOT do

- Does not promote the source to conformant shape. The shape
  classification is permanent for that ingestion event.
- Does not remove the quarantine entry. Override is per-workstream,
  not global.
- Does not skip the trinity_rubric. The source is still scored.

## Examples of common quarantine triggers

- A user pastes a long block of text with no source attribution.
  Action: quarantine until user provides URL or origin.
- An MCP returns a JSON response with an unfamiliar schema. Action:
  quarantine until schema is documented.
- A search result links to a forum post. Action: classify as Tier 3
  per source_hierarchy. If the workstream needs Tier 2 sources, this
  goes to quarantine.
- A repository has no LICENSE file. Action: quarantine. Cannot use
  unlicensed material in CE_RD_OS outputs.

## Why this matters

Without explicit quarantine, the agent will quietly absorb foreign
sources, then produce outputs that look authoritative but are
unfounded. The quarantine mechanism makes the trust boundary explicit.

## Citations

- The quarantine pattern is a CE_RD_OS-specific safety convention.
  No external citation. The pattern is loosely analogous to the
  "approved versus unapproved data" convention in regulated
  environments.

End quarantine_procedure.
