# NOTICES

Upstream lineage and license attribution for CE_RD_OS v0.1.0.

This bundle composes (does not copy code from) the following upstream
sources. Each row lists the source, license, and how this bundle uses it.

## Specifications

| Source | License | Use in this bundle |
|---|---|---|
| AGENTS.md spec | Linux Foundation Agentic AI Foundation, public spec | `AGENTS.md` at repo root conforms to the spec. Pure markdown, no schema, monorepo nesting supported. |
| Agent Skills spec | Anthropic, Apache-2.0 / CC-BY-4.0 | Each `skills/<name>/SKILL.md` conforms to the YAML frontmatter format (name, description, optional license, optional metadata, optional compatibility). |
| Keep a Changelog | CC-BY-4.0 | `CHANGELOG.md` follows the 1.1.0 format. |
| Conventional Commits | CC-BY-3.0 | Commit messages and PR conventions per `CONTRIBUTING.md`. |
| Semantic Versioning 2.0.0 | CC-BY-3.0 | Version tagging convention. |

## Patterns referenced (no code copying)

| Source | License | Use in this bundle |
|---|---|---|
| Compound Engineering plugin (EveryInc) | MIT | The plan-work-review-compound 4-phase loop is named in `skills/system_directive/SKILL.md` and `references/`. The bundle does not vendor or copy plugin code. Users opt into the plugin at their host's marketplace. |
| every-marketplace (EveryInc) | MIT | Cross-platform plugin distribution pattern referenced in `references/notebooklm_migration.md`. |
| Vercel agent-skills | Apache-2.0 | The 3-line CLAUDE.md pointer pattern is mirrored. The repo layout (registry.yaml + skills/ tree) is mirrored. |
| openai-cookbook | MIT | `registry.yaml` schema is mirrored from the cookbook layout. |
| anthropics/claude-cookbooks | Apache-2.0 | Same as above. |

## Research papers cited

| Citation | Use |
|---|---|
| arXiv:2507.17746, Rubrics as Rewards (RaR) | Trinity rubric design grounded in the four RaR principles: Coverage, Self-contained, Importance, Reference Guidance. Paraphrased in `references/rar_paper_summary.md`. |
| arXiv:2507.19457, GEPA | Optional ML backend pattern. Documented in `references/gepa_integration.md`. The bundle does not implement GEPA in v0.1.0; it exposes the hook only. |
| arXiv:2510.07743, OpenRubrics | Synthetic rubric generation pattern. Cited in `references/rar_paper_summary.md`. |
| arXiv:2503.23339, Adaptive Precise Boolean Rubrics | Boolean-atomic mode rationale in `skills/trinity_rubric/SKILL.md`. |
| arXiv:2507.18624, Apple/CMU Checklists | Cited in `references/rar_paper_summary.md` as supporting evidence for boolean checklists outperforming free-form judging on certain tasks. |

## Auditable repositories referenced

| Repo | License | Use |
|---|---|---|
| github.com/gepa-ai/gepa | Apache-2.0 | Reference implementation for the optional ML backend hook. Not vendored. |
| github.com/letta-ai/letta | Apache-2.0 | Architectural reference for the `memory_options.md` Letta runtime entry. Not vendored. |
| github.com/mem0ai/mem0 | Apache-2.0 | Architectural reference for the `memory_options.md` Mem0 layer entry. Not vendored. |
| github.com/algorithmicsuperintelligence/openevolve | open source, license verify before adoption | Optional ML backend reference in `references/ml_backend_options.md`. Not vendored. |
| github.com/EveryInc/compound-engineering-plugin | MIT | Pattern reference per "Patterns referenced" above. Not vendored. |
| github.com/upstash/context7 | MIT | Optional MCP for official-docs fetching, mentioned in `references/notebooklm_migration.md`. Not bundled. |

## License compatibility check

The Apache License 2.0 governing CE_RD_OS code is compatible with all
of the upstream licenses listed above:

- Apache-2.0 + Apache-2.0: identical, fully compatible.
- Apache-2.0 + MIT: MIT is permissive, compatible. Where this bundle
  references MIT-licensed patterns (Compound Engineering plugin, OpenAI
  cookbook), no code is copied; only the structural pattern is mirrored.
- Apache-2.0 + CC-BY-3.0 / CC-BY-4.0: compatible for documentation.

The CC-BY-4.0 governing CE_RD_OS documentation is compatible with the
documentation licenses of all upstream specs.

No GPL or AGPL code is incorporated in v0.1.0. (Khoj at github.com/khoj-ai/khoj
is AGPL-3.0; it is mentioned in research findings but not used or referenced
in this bundle's runtime code or shipped documentation.)

## Attribution requirement

When redistributing CE_RD_OS or works derived from it, retain:

1. The full text of `LICENSE` (Apache-2.0).
2. The full text of `LICENSE-DOCS` (CC-BY-4.0).
3. This `NOTICES.md` file.
4. The citation block in `README.md`.

This satisfies Apache-2.0 Section 4(c) for code redistribution and the
CC-BY-4.0 attribution clause for documentation redistribution.

## Maintenance items

Two factual claims age and need re-verification at each tagged release:

- The current adoption count for the AGENTS.md spec (currently cited
  as "60,000+ projects" in `references/`).
- The current star count for upstream repos referenced.

The publish_bundle skill includes a check item for these in its
publish-readiness rubric.

End NOTICES.
