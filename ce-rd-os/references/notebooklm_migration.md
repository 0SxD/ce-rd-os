# NotebookLM Migration

How the CE_RD_OS bundle deploys to a text-only host (NotebookLM,
Claude project, custom Gem, custom GPT).

## Inventory

The text bundle (Track A2) consists of 10 markdown files at the root
of `dist/ce-rd-os-v0.1.0-text-bundle.zip`:

1. AGENTS.md
2. README.md
3. SETUP.md
4. system_directive.md
5. setup_intake.md
6. source_ingestion.md
7. trinity_rubric.md
8. workstream_creator.md
9. publish_bundle.md
10. PROCEED.md

The first three are governance and setup. The next six are the
extracted bodies of the SKILL.md files. PROCEED.md is the multi-turn
handoff prompt the user pastes after dropping the zip into the host.

## Classify

Identify the host:

- **NotebookLM**: Google's source-grounded notebook. Strong at
  staying on-source, weaker at multi-step agent workflows. Caps:
  per-source size, total notebook size.
- **Claude project**: Anthropic's project workspace. Allows file
  upload to project-knowledge, persistent context across chats in
  the project.
- **Custom Gem**: Google Gemini's customizable assistant. Supports
  uploaded source files.
- **Custom GPT**: OpenAI's customizable assistant. Supports uploaded
  knowledge files.

Each host has different limits on file count, file size, and
total knowledge base size. Check the host's current limits before
dropping the bundle.

## Compose

The 10-file bundle is designed to fit common host limits as of
April 2026. If the host requires fewer files, the user can:

- Concatenate the 6 skill files into one combined `skills.md`. Loses
  some progressive disclosure benefit; gains compactness.
- Drop SETUP.md if the user is comfortable starting straight from
  PROCEED.md.

## Interrogate

After upload, the user pastes the PROCEED.md prompt as the first
message. The host:

1. Reads AGENTS.md.
2. Reads system_directive.md.
3. Asks the user the first three setup_intake questions.
4. Continues through setup_intake one batch of three questions per
   turn.
5. Saves the locked configuration as a host-side note.

## Write

Once setup is locked, the host runs through the workstream:

1. source_ingestion.md applies to incoming sources.
2. trinity_rubric.md scores outputs.
3. workstream_creator.md spawns new workstreams as needed.
4. publish_bundle.md is generally not used in text-only hosts (those
   hosts cannot run shell scripts), but the patterns it documents
   (verify-then-pack, fill approval gate, surface to architect) still
   apply.

## License compatibility for hosted text bundles

| Host | Storage | License compatibility |
|---|---|---|
| NotebookLM | Google's storage | CC-BY-4.0 documentation is compatible. |
| Claude project | Anthropic's storage | Same. |
| Custom Gem | Google's storage | Same. |
| Custom GPT | OpenAI's storage | Same. |

CE_RD_OS code (Apache-2.0) is generally not used in text-only hosts,
because those hosts do not execute shell scripts. The text bundle is
documentation only.

## Limitations of text-only deployment

- No `verify_self.sh` execution. Privacy gate must be checked
  manually by the user.
- No `pack_text_bundle.sh` execution. The bundle is consumed, not
  regenerated.
- No git operations. Versioning is per-host.
- Limited multi-step agent workflows. Some workstreams that work in
  Claude Code or Codex CLI need to be re-scoped for the smaller
  context and capability budget.

The Track A1 GitHub repo is the recommended deployment when the user
has access to a CLI environment. The text bundle is the fallback for
text-only hosts.

## Citations

- AGENTS.md spec, agents.md, Linux Foundation Agentic AI Foundation.
- Agent Skills spec, agentskills.io, Anthropic.
- Host product documentation (NotebookLM, Claude, Gemini, GPT) per
  each host's official docs as of capture date.

End notebooklm_migration.
