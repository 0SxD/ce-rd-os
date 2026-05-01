# INSTALL_BOOTLEG

This file is the fork-and-rename ritual for turning `agent-creator-agent` into
`ce-rd-os`, the first agent it creates. The pattern is recursive: this repo
contains the spec, and the spec is what produces ce-rd-os.

## What you get

A `ce-rd-os` repo under your account that is byte-equivalent to this one,
ready to be extended with your own skills, references, and packets.

## Ritual

1. Fork or clone this repo.
2. Rename the local folder to `ce-rd-os`.
3. Update the remote: `git remote set-url origin https://github.com/<your-handle>/ce-rd-os.git`
4. Run `bash scripts/verify_self.sh`. Confirm VERDICT: PROMOTE.
5. Run `make package VERSION=v0.1.0`.
6. Push and tag.

## Stringent setup question-loop (REQUIRED before any work begins on ce-rd-os)

Run the loop in `skills/setup_intake/SKILL.md` with these atomic-boolean rules:

- Each parameter is a yes/no answer or an enum selection.
- The loop produces a rubric of pass/fail criteria the user can verify.
- Zero assumption: if any answer is unclear, the loop stops and asks. No defaults
  are inserted silently.
- Maximum 3 questions per turn.
- The output is a saved checklist in `.ce-rd-os/setup-rubric.md` that the agent
  uses to gate every subsequent task. Tasks failing the rubric are blocked.

## When the task is qualitative (scalar 0 to 1, not boolean)

If a task does not decompose into atomic-boolean criteria, the agent falls back
to the visual-prompt protocol: load the canonical visual references for the
task type, derive a scalar rubric from the visual structure, and surface the
scalar score plus the visual reference for human review. This is the only
non-boolean rubric path. See `clone_prompt.md` for the full procedure.

## What this enables

Anyone can take this and run it. The recursive self-clone is intentional and
serves as both the demonstration of the workflow and the starting point for
extending the system with new skills, references, and packets.
