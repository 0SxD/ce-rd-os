# ce-rd-os

Compound Engineer R&D Operating System: a host-agnostic, model-agnostic scaffold of six composable skills for structured research and agent development.

## Status

Experimental. Maintained by Sage / 0SxD as part of an ongoing research portfolio focused on prompt engineering, agent skills, and LLM evaluation.

## What this is

CE_RD_OS is a six-skill scaffold that any AGENTS.md-aware coding agent or text-bundle host (NotebookLM, custom Gem, custom GPT, Claude project) can load as a structured R&D operating system. The skills enforce a strict intake-evaluate-publish loop grounded in formal rubric methodology. The intent is to study how structured prompt contracts affect agent output quality across different model families and hosting environments.

## Approach

- Six composable skills with defined dependency order (system_directive -> setup_intake -> source_ingestion -> trinity_rubric -> workstream_creator -> publish_bundle)
- Boolean-atomic evaluation by default; optional ML backend hook (MLflow, OpenEvolve) for continuous rubric refinement
- Conforms to the AGENTS.md spec (Linux Foundation Agentic AI Foundation) and the Agent Skills spec (Anthropic / agentskills.io)
- Dual delivery: GitHub repo (Track A1) and a 10-file text zip for text-only hosts (Track A2)
- Self-verifying: `scripts/verify_self.sh` gates every push

## Layout

- `skills/` - six SKILL.md files, one per composable skill
- `packets/` - pre-built context packets for each track
- `references/` - upstream lineage and architectural references
- `scripts/` - verify_self.sh, pack_text_bundle.sh, and support scripts
- `build/` - build-time artifacts including PRIVACY_BLOCKLIST.md (not shipped in Track A)
- `examples/` - example CLAUDE.md and agent boot sequence

## Usage / How to read this

Clone and verify:

```
git clone https://github.com/0SxD/ce-rd-os.git
cd ce-rd-os
bash scripts/verify_self.sh
```

To produce the text bundle for a text-only host:

```
bash scripts/pack_text_bundle.sh
```

Output: `dist/ce-rd-os-v0.1.0-text-bundle.zip`. Drop into NotebookLM, a Claude project, or a custom GPT. Then paste the prompt from `packets/PROCEED.md` to begin the multi-turn setup.

## Prior art and citations

- Rubrics as Rewards (RaR), arXiv:2507.17746 - grounds the `trinity_rubric` skill's boolean-atomic scoring grid
- OpenRubrics, arXiv:2510.07743 - rubric construction methodology reference
- Adaptive Precise Boolean Rubrics (Google), arXiv:2503.23339 - boolean decomposition pattern
- Checklists Are Better Than Reward Models (CMU/Apple), arXiv:2507.18624 - motivates the checklist-first evaluation contract
- Anthropic Skills spec / agentskills.io - governs SKILL.md frontmatter format
- AGENTS.md spec (Linux Foundation Agentic AI Foundation) - governs AGENTS.md at repo root

## License

Code: Apache-2.0. Documentation: CC-BY-4.0. Dual-licensed.
Apache-2.0 governs code and shell scripts. CC-BY-4.0 governs documentation, SKILL.md bodies, and references. See `LICENSE` and `LICENSE-DOCS` for full text.
Author: Sage / 0SxD

## Notes

This repo is part of an active R&D portfolio. Content may move, change, or be withdrawn. Issues and PRs welcome but reviews are best-effort.
