# Open Research

Items deferred from v0.1.0 to v0.2 pending user-directed research.
Each row will be resolved by the architect's NotebookMCP connection
in a future session.

| # | Term | Status | Recommended action |
|---|---|---|---|
| 1 | CORAL (self-learning agent, Harvard / MIT / Stanford) | unverified | Spawn an adjacent session: search "CORAL self-learning agent 2025 Harvard MIT Stanford". If the architect can identify the canonical repo or paper, add to references/. If not surfaced in 10 minutes of focused search, defer to the next research turn. |
| 2 | gitnexus | unverified | Same procedure. Searching GitHub for "gitnexus" as project or org name. |
| 3 | space-agent | unverified | Same procedure. |
| 4 | oh-my-codex | unverified | May be the architect's own project or a small fork. Architect to confirm visibility before public reference. |
| 5 | meta-harness (Stanford) | unverified | Probably a Stanford CRFM evaluation harness or CS329A course material. Architect to confirm exact name. |
| 6 | Hermes (which one) | ambiguous | Two candidates: (1) Nous Research Hermes function-calling model family; (2) Hermes Agent runtime referenced by Kimi K2.6 release. Architect to disambiguate. |

## Why these items are deferred

The v0.1.0 ship targets the architect's grant-application timeline
and Track A audience. The 6 items above were mentioned in source-session
conversation but could not be verified to Tier-1 source standard within
the v0.1.0 build window. Deferring keeps v0.1.0 clean and lets v0.2
add them with proper citations.

## Resolution path for v0.2

The architect has indicated they will use a NotebookMCP connection
to search for these items in a focused research pass. The session
that runs the pass will:

1. Read this document for the list.
2. Run searches via NotebookMCP, MCP-connected web search, or
   manually-curated source corpus.
3. For each item: produce a verified-with-URL row OR a
   "deferred-further" note explaining why the item still cannot be
   sourced.
4. Update this document with the results.
5. Add references/<item>.md for any newly resolved items.
6. Bump CHANGELOG.md to note the resolution.

## Source hierarchy for Appendix B resolution

Resolution must follow the source hierarchy in
`skills/system_directive/SKILL.md`:

- Tier 1: arXiv preprints, official repository, institutional
  reports.
- Tier 2: peer-reviewed and official documentation.
- Tier 3: reputable engineering blogs, conference talks.
- Tier 4: general web search (last resort, with explicit caveat).

If an item cannot reach Tier 2 confidence, it stays deferred.

## What this document is NOT

- Not a list of features deferred. That list is in CHANGELOG.md
  under [Unreleased].
- Not a research task list for the architect. The architect chooses
  which items to resolve and when.
- Not a guarantee any item will be in v0.2. Some may stay deferred
  indefinitely or be removed from scope.

End open_research.
