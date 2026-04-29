# SETUP

How to use CE_RD_OS v0.1.0.

Two paths. Pick the one that matches your environment.

## Path A: GitHub repo (recommended for CLI environments)

You are using one of: Claude Code, Codex CLI, Cursor, Aider,
Continue.dev, Gemini CLI, Factory Droids, OpenHands, or any other
AGENTS.md-aware coding agent.

### Steps

1. Clone the repo.

   ```
   git clone https://github.com/0SxD/ce-rd-os.git
   cd ce-rd-os
   ```

2. Run the verifier to confirm the bundle is intact.

   ```
   bash scripts/verify_self.sh
   ```

   Expected output: `VERDICT: PROMOTE`, exit 0.

3. Open the repo in your AI coding environment.

4. The agent reads `AGENTS.md` automatically. You do not need to
   paste it.

5. Tell the agent your goal in plain language. The agent will load
   `skills/system_directive/SKILL.md` first, then walk you through
   `skills/setup_intake/SKILL.md` to lock the 9 setup parameters.

6. Once setup is locked, the agent runs through the active
   workstream using the skills you have selected.

### Optional: install the pre-commit hook

```
make install-hooks
```

This adds a git pre-commit hook that runs `verify_self.sh` on every
commit. Recommended.

## Path B: Text bundle (for NotebookLM, Claude project, custom Gem, custom GPT)

You are using a host that does not support shell scripts but does
support uploading source files.

### Steps

1. Get the text bundle zip. Either:
   - Generate it yourself: `bash scripts/pack_text_bundle.sh`.
     Output lands at `dist/ce-rd-os-v0.1.0-text-bundle.zip`.
   - Or download the latest release zip from the GitHub releases
     page.

2. Unzip locally. You should see 10 markdown files.

3. Drop all 10 files into your host's source-knowledge area:
   - **NotebookLM**: add as sources.
   - **Claude project**: upload to project knowledge.
   - **Custom Gem**: upload as knowledge files.
   - **Custom GPT**: upload as knowledge files.

4. Paste the contents of `PROCEED.md` as your first message to the
   host.

5. The host reads `AGENTS.md`, then `system_directive.md`, then
   walks you through `setup_intake.md`.

## What you get either way

- Six composable skills under `skills/` (or as flat files in the text
  bundle).
- A self-verifying privacy and conformance gate (CLI only).
- A 9-cell Trinity rubric for evaluating outputs.
- A dual-track publishing flow that produces both a GitHub repo
  release and a text bundle from a single source of truth.
- Apache-2.0 / CC-BY-4.0 licensing. Permissive and compatible with
  all upstream sources used.

## Troubleshooting

### `verify_self.sh: FAILED`

The output names which row failed. Common causes:

- **Missing `AGENTS.md`** at root: regenerate from the repo.
- **Em or en dashes** in markdown: search and replace with commas
  or hyphens.
- **Privacy blocklist hit**: a forbidden term entered the bundle.
  Check `build/PRIVACY_BLOCKLIST.md` for the term and remove it.
- **registry.yaml mismatch**: a skill was added or removed without
  updating `registry.yaml`.

### Host does not allow file upload

Some hosts limit knowledge file count. Concatenate the 6 skill files
into one combined `skills.md` and upload that plus AGENTS.md and
PROCEED.md (3 files total).

### Agent goes off-script

If the agent stops following `AGENTS.md`, paste the system_directive
contents directly into the chat with the prefix:
"Reload governance from system_directive.md and continue."

## Where to look for what

| If you want... | Look at |
|---|---|
| The full governance | AGENTS.md |
| The setup parameters | skills/setup_intake/SKILL.md |
| The evaluation rubric | skills/trinity_rubric/SKILL.md |
| How to ingest sources | skills/source_ingestion/SKILL.md |
| How to publish a bundle | skills/publish_bundle/SKILL.md |
| Why a paper is cited | references/<paper_name>.md |
| What is deferred to v0.2 | references/open_research.md and CHANGELOG.md [Unreleased] |
| The license attribution | NOTICES.md |

End SETUP.
