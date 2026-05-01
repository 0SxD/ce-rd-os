> **Status: Evaluation window (private under 0SxD).** This repository is staged
> for evaluation review. License terms in LICENSE govern; contents may move,
> change, or be withdrawn. See LICENSE before any use.

# agent-creator-agent

This repo is `agent-creator-agent`. Fork it, rename the clone `ce-rd-os`, and
you have CE_RD_OS v0.1.0 -- a compound-engineered R&D operating system. The
agent-creator-agent is the pattern; ce-rd-os is the first product it produces.
The fork-and-rename ritual is in `INSTALL_BOOTLEG.md`.

A setup-first, host-agnostic, model-agnostic scaffold for compound-engineered
research and development. Conformant to the AGENTS.md spec (Linux Foundation
Agentic AI Foundation) and the Agent Skills spec (Anthropic, agentskills.io).

## Status

v0.1.0. First public ship. Self-verifying, human-gated. Apache-2.0 for code,
CC-BY-4.0 for documentation. See `LICENSE` and `LICENSE-DOCS`.

## What it does

CE_RD_OS provides six composable skills that any AGENTS.md-aware coding
agent or any text-bundle host (NotebookLM, custom Gem, custom GPT, Claude
project) can run as a research and development scaffold.

The six skills:

1. **system_directive**: identity, source hierarchy, 100 percent confidence
   loop, Trinity rubric reference, output contract.
2. **setup_intake**: captures the irreducible parameters (mission, role,
   sources, rubric mode, sub-agent profile, memory option, ML backend
   option, loop bound) before any work begins.
3. **source_ingestion**: detect, normalize, interrogate, score, route
   incoming sources. Quarantines anything that cannot be conformed.
4. **trinity_rubric**: 9-cell evaluation grid (Pathos, Ethos, Logos by
   Coverage, Self-contained, Importance) grounded in arXiv:2507.17746
   (Rubrics as Rewards). Default mode is boolean-atomic. Optional
   ML backend hook for arXiv:2507.19457 (GEPA via MLflow) or OpenEvolve.
5. **workstream_creator**: meta-skill. Generates the workstream MD that
   the user fills with their research bundle, then routes to the other
   skills.
6. **publish_bundle**: agentskills.io conformant packing, AGENTS.md
   generation, dual-track output (GitHub repo plus 10-file text zip).

## How to use

### Track A1, GitHub repo (Claude Code, Codex, Cursor, Aider, Continue.dev)

```
git clone https://github.com/0SxD/ce-rd-os.git
cd ce-rd-os
bash scripts/verify_self.sh
```

Open the repo in your AI coding environment. The agent reads `AGENTS.md`
on its own and proceeds through the skills in dependency order.

### Track A2, text bundle (NotebookLM, Claude project, custom Gem, custom GPT)

```
cd ce-rd-os
bash scripts/pack_text_bundle.sh
```

Output: `dist/ce-rd-os-v0.1.0-text-bundle.zip`. Drag and drop into your
host. Then paste the prompt from `packets/PROCEED.md` to start the
multi-turn setup.

## Quick start

Two commands cover the common case:

```
bash scripts/verify_self.sh
bash scripts/pack_text_bundle.sh
```

The first verifies the repo is publish-ready. The second produces the
drop-in zip for any text-only host.

## Citations

This bundle composes (does not copy) from the following Tier-1 sources:

- agents.md, Linux Foundation Agentic AI Foundation, AGENTS.md spec.
- agentskills.io, Anthropic, Agent Skills spec, Apache-2.0 / CC-BY-4.0.
- arXiv:2507.17746, Rubrics as Rewards (RaR), MIT-affiliated authors.
- arXiv:2507.19457, GEPA, plus github.com/gepa-ai/gepa under Apache-2.0.
- arXiv:2510.07743, OpenRubrics.
- github.com/EveryInc/compound-engineering-plugin, MIT, plan-work-review-compound
  pattern, attribution-only.
- github.com/letta-ai/letta, Apache-2.0, agent runtime architectural reference.
- github.com/mem0ai/mem0, Apache-2.0, memory layer reference.

Full upstream lineage in `NOTICES.md`.

## License

Code: Apache-2.0. Documentation: CC-BY-4.0. Copyright 2026 0SxD.

This repo is dual-licensed. Apache-2.0 governs code and shell scripts;
CC-BY-4.0 governs documentation, SKILL.md bodies, and references. See
`LICENSE` and `LICENSE-DOCS` for full text.

## Contributing

See `CONTRIBUTING.md`. Pull requests and issues welcome. The repo runs
`scripts/verify_self.sh` on every push and PR; the gate must pass before
merge.

## Versioning

SemVer 2.0.0 plus Conventional Commits. Annotated tags. Release notes via
`gh release create`. See `CHANGELOG.md`.

End README.
