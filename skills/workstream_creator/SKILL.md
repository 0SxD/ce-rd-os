---
name: workstream-creator
description: >
  Use this skill to spawn a new workstream MD file when the user
  introduces a research thread, a build target, or a project area
  that needs its own scoped scaffold. Trigger when the user says
  "new workstream", "spin up a separate effort for X", "I want to
  track X separately", "create a workstream for Y", or when the
  setup_intake skill detects that the current goal does not fit in
  any existing workstream. Generates a workstream MD that the user
  fills with their research bundle, then routes to the other skills.
license: Apache-2.0
metadata:
  version: 0.1.0
  category: meta
compatibility:
  hosts:
    - claude-code
    - codex-cli
    - cursor
    - aider
    - continue-dev
    - notebooklm
    - claude-project
    - custom-gem
    - custom-gpt
---

# workstream_creator

Meta-skill. Generates a new workstream MD file with the standard
structure other skills can route to.

## When to spawn a workstream

Use a workstream when the user has:

- A scoped research thread that will run for more than one session.
- A specific deliverable (a paper, a repo, a bundle, a report) with
  a defined audience and timeline.
- Source material that does not fit the active workstream.
- A topic that needs its own Trinity rubric configuration.

Do not spawn a workstream for a single-turn question. Workstreams
are sessions, not turns.

## Workstream MD template

When this skill runs, it produces a new file at
`workstreams/<short_name>/WORKSTREAM.md` with the structure below.

```
# WORKSTREAM: <short_name>

## 0. Header

- Created: <ISO 8601 timestamp>
- Architect: <handle>
- Scope window: <one sentence>
- Status: <draft | active | paused | complete | archived>

## 1. Mission

<One sentence. What does success look like?>

## 2. Role

<What role should the agent take? Which persona, which level of
seniority, which conservatism profile?>

## 3. Sources

<List paths and URLs. Each source gets a one-line provenance and
tier annotation.>

## 4. Rubric mode

<boolean | sparse_jump_3 | scaled_0_1 | ml_assisted>

## 5. sub_agent profile

```yaml
sub_agent:
  model_type: <enum>
  effort: <enum>
  loop_bound:
    type: <count | confidence | until_answer>
    count: <int>          # if type=count
    confidence_threshold: <float>  # if type=confidence
    until_answer: <bool>  # if type=until_answer
```

## 6. Memory option

<none | mem0 | letta | custom>

## 7. ML backend option

<none | gepa_via_mlflow | openevolve | custom>

## 8. Loop bound (workstream-level)

<one of: count | confidence | until_answer>

## 9. Output target

<chat_only | repo | text_bundle | dual>

## 10. Trinity rubric configuration

The 9-cell grid for this workstream. Custom weights, if any, listed here.

## 11. Sub-skills used

List the SKILL.md files this workstream pulls in.

## 12. Active turn log

| Turn | Date | Actor | Summary |
|---|---|---|---|

## 13. Architect verdicts received

| Date | Verdict | Notes |
|---|---|---|

## 14. Termination criteria

<When is this workstream done?>
```

## Workstream lifecycle

1. **Spawn.** This skill creates the workstream MD with all sections
   stubbed.
2. **Lock setup.** The user fills sections 1 through 9 via setup_intake.
3. **Active.** The workstream runs through its sub-skills. Each turn
   logs to section 12.
4. **Verdict.** The architect issues verdicts via approval gates.
   Each verdict logs to section 13.
5. **Termination.** When section 14 criteria are met, the workstream
   moves to `workstreams/<short_name>/ARCHIVED.md` and the active file
   is removed.

## Workstream registry

All active workstreams are listed in `workstreams/REGISTRY.md`.
The workstream_creator updates the registry when spawning.

## What this skill does NOT do

- Does not skip setup_intake. Every new workstream must go through it.
- Does not auto-name workstreams. The user provides the short name.
- Does not move workstream files between active and archived without
  architect approval.
- Does not duplicate work that is already covered by another workstream.
  It checks the registry first.

## Citations

- The workstream pattern is informed by the Compound Engineering
  plugin's plan-work-review-compound 4-phase loop (EveryInc, MIT,
  attribution-only).
- The lifecycle phases mirror standard agile workstream conventions.
- The 9-parameter setup is defined in `skills/setup_intake/SKILL.md`.

End workstream_creator.
