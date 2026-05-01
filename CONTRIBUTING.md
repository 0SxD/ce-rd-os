# Contributing to CE_RD_OS

Pull requests and issues welcome.

## Before you submit

1. Run `bash scripts/verify_self.sh`. It must exit 0.
2. Make sure no em dashes or en dashes appear in any markdown you touch.
3. Add a CHANGELOG entry under `[Unreleased]`.
4. Use Conventional Commits for the commit message.

## Pull request convention

Title: `feat: short description` or `fix:` or `docs:` or `chore:`
following Conventional Commits 1.0.

Body: paragraph-length explanation of what, why, and how this conforms
to the Trinity rubric. If the change touches a SKILL.md, run the skill
validator and paste the output in the PR body.

## License grant

By submitting a contribution to this repository, you agree that your
contribution is licensed under the Apache License 2.0 for code and
the Creative Commons Attribution 4.0 International license for
documentation. See `LICENSE` and `LICENSE-DOCS`.

This is the standard Apache-2.0 contributor agreement under Section 5
of the license.

## Code style

- Markdown for documentation, no em or en dashes.
- Direct quotes capped at 14 words, one per source maximum, in
  quotation marks with a citation.
- YAML frontmatter on SKILL.md only; plain markdown elsewhere.
- Shell scripts: `#!/usr/bin/env bash`, `set -euo pipefail`, portable
  POSIX where possible.

## Privacy gate

`scripts/verify_self.sh` reads `build/PRIVACY_BLOCKLIST.md` and refuses
to green-light any commit that contains a blocklisted term. The blocklist
covers internal codenames, API key shapes, and personal-path leaks.
If your contribution introduces a new term that should be blocked, add
it to `build/PRIVACY_BLOCKLIST.md` in the same PR.

## Issue templates

When filing an issue, include:

- The skill or reference document affected.
- The output of `bash scripts/verify_self.sh`.
- Your host environment (Claude Code, Codex CLI, NotebookLM, etc.).
- Whether the issue blocks the v0.1.0 publish-readiness gate or is a
  v0.2 item.

End CONTRIBUTING.
