# AGENTS.md

CE_RD_OS v0.1.0. Compound Engineer R&D Operating System.

This file is the universal entry point for any AI coding or research agent
that opens this repository. Read this first. Then read the SKILL.md files
under `skills/` in any order.

## What this is

A setup-first, host-agnostic, model-agnostic scaffold for compound-engineered
research and development. First branch of an evolving system. Spec-conformant
to AGENTS.md (Linux Foundation Agentic AI Foundation) and Agent Skills
(agentskills.io, Anthropic).

The bundle ships in two forms from a single source of truth:

- Track A1, GitHub repo: clone into Claude Code, Codex CLI, Cursor, Aider,
  Continue.dev, Gemini CLI, Factory Droids, OpenHands.
- Track A2, 10-file text bundle zip: drag-drop into NotebookLM, Claude
  project, custom Gem, custom GPT.

`scripts/pack_text_bundle.sh` generates the zip from this repo.

## Setup commands

```
git clone https://github.com/0SxD/ce-rd-os.git
cd ce-rd-os
bash scripts/verify_self.sh
```

Expected output: `verify_self.sh: PASSED (privacy gate clean)` with exit 0.

To produce the text bundle:

```
bash scripts/pack_text_bundle.sh
```

Output lands at `dist/ce-rd-os-v0.1.0-text-bundle.zip`.

## Test commands

```
bash scripts/verify_self.sh
```

The script enforces:

1. Privacy blocklist clean (no internal codenames, no API keys, no
   personal-path leaks).
2. AGENTS.md present at repo root.
3. Each SKILL.md frontmatter validates against agentskills.io spec
   (name, description, length bounds).
4. LICENSE file present with recognized SPDX header.
5. CHANGELOG.md present with [Unreleased] and [0.1.0] sections.
6. Git config user.email matches the repo identity (not a system default).

Exit 0 means publish-ready. Exit 1 means stop and surface to the Architect.

## Code style

- Markdown for documentation, no em dashes or en dashes anywhere in any file.
- Paraphrase first. Direct quotes capped at 14 words, one quote per source
  maximum, in quotation marks with citation.
- No proprietary or internal-codename leakage. The privacy blocklist is the
  enforcement layer.
- YAML frontmatter on SKILL.md only. Plain markdown elsewhere.
- Shell scripts: bash, set -euo pipefail, portable POSIX where possible.

## Architecture overview

```
ce-rd-os/
  AGENTS.md                 this file, root governance
  CLAUDE.md                 3-line pointer to AGENTS.md
  GEMINI.md                 3-line pointer to AGENTS.md
  README.md                 human-facing readme
  LICENSE                   Apache-2.0
  LICENSE-DOCS              CC-BY-4.0 for documentation
  CHANGELOG.md              Keep a Changelog 1.1.0
  CONTRIBUTING.md           contribution loop
  NOTICES.md                upstream lineage and license attribution
  Makefile                  make verify, package, release, clean
  registry.yaml             skills registry (cookbook schema)
  authors.yaml              author entries
  .gitignore
  .github/workflows/
    verify.yml              run verify_self.sh on push and PR
    release.yml             run pack_text_bundle.sh and gh release create on v*.*.* tag
  packets/
    README.md               packet usage doc
    PROCEED.md              multi-turn handoff prompt for text-bundle hosts
  skills/
    system_directive/SKILL.md       identity, source hierarchy, confidence loop
    setup_intake/SKILL.md           irreducible setup parameters
    source_ingestion/SKILL.md       source detection and routing
    trinity_rubric/SKILL.md         9-cell Pathos/Ethos/Logos rubric
    workstream_creator/SKILL.md     meta-skill for spawning workstream files
    publish_bundle/SKILL.md         packing the dual-track output
  references/
    rar_paper_summary.md            arXiv 2507.17746 paraphrase
    gepa_integration.md             arXiv 2507.19457 + MLflow hook
    memory_options.md               none/mem0/letta/custom enum
    ml_backend_options.md           none/gepa_via_mlflow/openevolve/custom enum
    agentic_models.md               sub_agent.model_type comparison table
    socratic_question_bank.md       question patterns for setup intake
    packet_shapes.md                source-acceptance contracts
    quarantine_procedure.md         what to do with foreign sources
    notebooklm_migration.md         host-portability guidance
    open_research.md                v0.2 deferred items (Appendix B)
  scripts/
    verify_self.sh                  privacy and conformance gate
    pack_text_bundle.sh             text-bundle generator
  build/
    PRIVACY_BLOCKLIST.md            blocklist source for verify_self.sh (not shipped in text bundle)
    APPROVAL_GATE_TEMPLATE.md            architect verdict form (not shipped in text bundle)
    BUILD_SEQUENCE.md               build checklist (not shipped in text bundle)
  dist/
    ce-rd-os-v0.1.0-text-bundle.zip   generated artifact
```

## Privacy guard

`scripts/verify_self.sh` reads `build/PRIVACY_BLOCKLIST.md` and refuses to
green-light any commit that contains a blocklisted term. The blocklist
covers internal codenames, API key shapes, personal-path leaks, and
contract-restricted terms. Run before every commit.

If the script reports a blocklist hit, do not push. Surface the hit to the
Architect via the approval_gate template at `build/APPROVAL_GATE_TEMPLATE.md`.

## Sub-agent permissions for downstream agents

This bundle authorizes downstream agents (Claude Code, Codex CLI, Cursor,
Aider, etc.) to:

- Spawn parallel sub-agents to draft individual skill bodies, reference
  documents, and reviewer reports.
- Run an adjacent research session to resolve `references/open_research.md`
  deferred items, returning a single output file per session.
- Use a 14-reviewer compound-engineering pass (per the EveryInc plugin
  pattern, MIT, attribution-only) on the bundle before tagging a release.

Constraints:

- Sub-agent output rolls back to a single coordinating agent for synthesis.
- The approval_gate at `build/APPROVAL_GATE_TEMPLATE.md` is filled by the agent
  but the verdict is issued by the Architect only.
- No agent self-issues a release verdict.

Default sub-agent for routine work: `model_type: claude_sonnet_4_6`,
`effort: medium`, `loop_bound: {type: count, count: 20}`. Reserve
`model_type: claude_opus_4_7` for final review and Architect-facing
summaries. `model_type: claude_haiku_4_5` is acceptable for blocklist
scans and syntactic validity checks. The `sub_agent` abstraction is
defined in `skills/setup_intake/SKILL.md`.

## Multi-turn handoff awareness

Hosts with limited context windows (NotebookLM, custom Gem, custom GPT)
should follow `packets/PROCEED.md` for the multi-turn handoff pattern.
The pattern is: read AGENTS.md first, ask setup_intake questions one at a
time, save intermediate state as host-side notes, ask the user to delete
and re-add sources between passes when context fills. Do not attempt to
process the whole bundle in one response.

## Build log

Append-only log of major decisions and reviewer findings. Entries are
timestamped, signed with the actor, and never deleted.

```
2026-04-28 init     v0.1.0 build initiated. Q1=anonymous-with-handle,
                    Q2=Apache-2.0 + CC-BY-4.0, Q3=six-skills-as-listed.
                    Source session: Claude Opus 4.7 (Claude.ai project).
                    Receiving session: Claude Code CLI (next session).
```

## License

- Code, scripts, configuration files: Apache License 2.0 (see `LICENSE`).
- Documentation, SKILL.md bodies, references: CC-BY-4.0 (see
  `LICENSE-DOCS`).

Upstream attribution and incorporated patterns are listed in `NOTICES.md`.

## Citations

Core sources for this bundle, all Tier-1 (arXiv, official documentation,
auditable repo, institutional):

- AGENTS.md spec, Linux Foundation Agentic AI Foundation, agents.md
- Agent Skills spec, Anthropic, agentskills.io
- Compound Engineering plugin, EveryInc, MIT, attribution-only reference
- Rubrics as Rewards (RaR), arXiv:2507.17746
- GEPA, arXiv:2507.19457, github.com/gepa-ai/gepa, Apache-2.0
- OpenRubrics, arXiv:2510.07743
- Letta, github.com/letta-ai/letta, Apache-2.0, architectural reference
- Mem0, github.com/mem0ai/mem0, Apache-2.0
- OpenEvolve, github.com/algorithmicsuperintelligence/openevolve

End AGENTS.md.
