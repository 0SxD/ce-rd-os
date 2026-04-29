# packets/

This directory holds artifacts that are useful at runtime to a host
or downstream agent, but are not core skills or references.

## Contents

### PROCEED.md

The first-prompt template for text-bundle hosts (NotebookLM, Claude
project, custom Gem, custom GPT). Paste it after dropping the 10-file
bundle into the host's knowledge area.

The PROCEED prompt:

1. Tells the host to read AGENTS.md and system_directive.md before
   anything else.
2. Tells the host to run setup_intake next.
3. Restates the load-bearing constraints (no em dashes, 14-word quote
   cap, three questions per turn, architect-only verdicts, multi-turn
   context handling).

### Vendored release zip (added at release time)

When `make release` runs, the release.yml workflow stages the release
zip and its SHA-256 sidecar here as well, in addition to publishing
to GitHub releases. The zip-filename-equals-directory-name convention
follows vercel-labs.

Files added at release time:

- `ce-rd-os-v0.1.0-text-bundle.zip` (the same zip as in
  `dist/`, vendored here for inline reference).
- `ce-rd-os-v0.1.0-text-bundle.zip.sha256` (the sidecar).

These are gitignored by default (see `.gitignore`) and only present
in the actual release tree.

## When to use what

| Situation | Use |
|---|---|
| First time setup in a text host | PROCEED.md |
| Distributing the bundle to a colleague | the zip in dist/ or the GitHub release |
| Verifying the bundle has not been tampered with | the .sha256 sidecar |
| Setting up in a CLI environment | git clone, do not use packets/ |

End packets/README.
