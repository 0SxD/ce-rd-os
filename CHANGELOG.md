# Changelog

All notable changes to CE_RD_OS are documented in this file.

The format is based on [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Items in flight for v0.2:

- Resolve Appendix B research gaps (CORAL self-learning agent, gitnexus,
  space-agent, oh-my-codex, meta-harness, Hermes disambiguation) via the
  user-directed NotebookMCP connection.
- Optional ML backend implementations (none -> gepa_via_mlflow, openevolve).
- Three-agent hostile audit skill (red-team review).
- Domain-expert agent stubs (teacher, lesson plan, product dev, analytical
  thought).

## [0.1.0] - 2026-04-28

### Added

- AGENTS.md root governance file, conformant to the Linux Foundation
  Agentic AI Foundation specification.
- Six skills under `skills/`, each conformant to the Anthropic Agent Skills
  specification (agentskills.io):
  - `system_directive`: identity, source hierarchy, confidence loop.
  - `setup_intake`: irreducible setup parameters with sub_agent abstraction.
  - `source_ingestion`: detect, normalize, interrogate, score, route loop.
  - `trinity_rubric`: 9-cell Pathos/Ethos/Logos rubric grounded in arXiv:2507.17746.
  - `workstream_creator`: meta-skill for spawning workstream files.
  - `publish_bundle`: dual-track packing (GitHub repo plus 10-file text zip).
- Reference documents under `references/`:
  - `rar_paper_summary.md`, paraphrase of arXiv:2507.17746.
  - `gepa_integration.md`, paraphrase of arXiv:2507.19457 plus MLflow hook.
  - `memory_options.md`, four-option enum (none, mem0, letta, custom).
  - `ml_backend_options.md`, four-option enum.
  - `agentic_models.md`, sub_agent.model_type comparison table.
  - `socratic_question_bank.md`, intake question patterns.
  - `packet_shapes.md`, three-shape source-acceptance contracts.
  - `quarantine_procedure.md`, foreign-source isolation procedure.
  - `notebooklm_migration.md`, host-portability guidance.
  - `open_research.md`, deferred Appendix B items.
- Scripts under `scripts/`:
  - `verify_self.sh`, privacy and conformance gate.
  - `pack_text_bundle.sh`, generates the 10-file text zip.
- Build artifacts under `build/`:
  - `PRIVACY_BLOCKLIST.md`, the blocklist source for verify_self.sh.
  - `APPROVAL_GATE_TEMPLATE.md`, the architect verdict form.
  - `BUILD_SEQUENCE.md`, the ordered build checklist.
- Top-level files: README.md, CLAUDE.md (3-line pointer), GEMINI.md
  (3-line pointer), CONTRIBUTING.md, NOTICES.md, .gitignore, registry.yaml,
  authors.yaml, Makefile, .github/workflows/{verify.yml, release.yml},
  packets/{README.md, PROCEED.md}.

### Decisions

- Q1 attribution: anonymous-with-handle. GitHub handle `0SxD`. Legal name
  appears nowhere except where the Architect chooses to add it at
  publication time.
- Q2 license: Apache-2.0 for code, CC-BY-4.0 for documentation.
- Q3 must-haves: six skills as listed. Deferred to v0.2 / Track B:
  ce_loop full implementation, ML backend implementations, hostile_audit
  skill, NotebookLM-reskin web app, Letta runtime mode, Hermes integration,
  domain-expert agents.

### Composition lineage

This bundle composes (does not copy) from:

- AGENTS.md spec, Linux Foundation Agentic AI Foundation.
- Agent Skills spec, Anthropic, Apache-2.0 / CC-BY-4.0.
- Compound Engineering plugin, EveryInc, MIT, attribution-only reference.
- Rubrics as Rewards (RaR), arXiv:2507.17746.
- GEPA, arXiv:2507.19457 plus github.com/gepa-ai/gepa, Apache-2.0.
- OpenRubrics, arXiv:2510.07743.
- Letta, github.com/letta-ai/letta, Apache-2.0, architectural reference.
- Mem0, github.com/mem0ai/mem0, Apache-2.0.

Full attribution in `NOTICES.md`.

### Known limitations

- v0.1.0 ships the ML backend hook only. Implementations are deferred to v0.2.
- v0.1.0 does not include the three-agent hostile audit. Deferred to v0.2.
- Six items in `references/open_research.md` are deferred to v0.2 pending
  the user-directed NotebookMCP research pass.

[Unreleased]: https://github.com/0SxD/ce-rd-os/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/0SxD/ce-rd-os/releases/tag/v0.1.0
