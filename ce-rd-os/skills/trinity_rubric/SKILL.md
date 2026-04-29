---
name: trinity-rubric
description: >
  Use this skill whenever an output, a source, or a plan needs to be
  evaluated against the project's quality bar. Trigger when the agent
  finishes a draft and is about to surface it, when the user says
  "score this", "review this", "is this good enough to ship", or when
  the publish_bundle skill runs its publish-readiness check. The 9-cell
  Pathos / Ethos / Logos by Coverage / Self-contained / Importance grid
  grounded in arXiv:2507.17746. Default mode boolean-atomic. Optional
  ML backend hook for GEPA via MLflow or OpenEvolve.
license: Apache-2.0
metadata:
  version: 0.1.0
  category: evaluation
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

# trinity_rubric

The 9-cell evaluation engine for CE_RD_OS.

## The grid

| | Coverage | Self-contained | Importance |
|---|---|---|---|
| **Pathos** (mission and role) | does the work cover the stated mission? | can a reader understand the work without external context? | does this matter for the stated mission? |
| **Ethos** (sources and criteria) | are all relevant sources cited? | can a reader verify each citation directly? | are the citations the right ones, not adjacent? |
| **Logos** (rubric evaluation) | does the rubric itself cover all axes of quality? | can a reader apply the rubric without ambiguity? | does the rubric weight the right things? |

The three axes (Pathos, Ethos, Logos) and the three sub-axes
(Coverage, Self-contained, Importance) are orthogonal. The 9 cells
form the evaluation grid.

## Modes

### boolean (default)

Each cell scores 0 or 1. Threshold for pass: all 9 cells must score 1.
Used for mechanical checks (file-existence, frontmatter validity,
citation presence) and for ingest-time source acceptance.

### sparse_jump_3

Each cell scores -1, 0, or +1. Threshold: sum across the 9 cells must
be at least +5. Used for first-pass triage when a coarse signal is
sufficient.

### scaled_0_1

Each cell scores a continuous 0.0 to 1.0. Threshold: weighted sum
must clear an architect-set bar (default 0.85). Used for consequential
outputs where granular distinction matters.

### ml_assisted

scaled_0_1 plus an ML backend (GEPA via MLflow, OpenEvolve, or
custom). The backend evolves the rubric weights over multiple runs
based on observed agreement with the architect's verdicts. v0.1.0
ships the hook only; backends are deferred to v0.2. See
`references/gepa_integration.md` and `references/ml_backend_options.md`.

## Aggregation

Three aggregation strategies are supported:

- **All-pass** (default for boolean mode): all 9 cells must clear
  threshold.
- **Weighted sum** (default for scaled mode): each cell has a weight
  (default uniform 1/9), the weighted sum must clear threshold.
- **Geometric mean** (strict mode): all axes contribute multiplicatively.
  Any zero cell sinks the aggregate to zero.

The architect chooses the aggregation strategy at setup intake
(parameter 4: rubric mode).

## How to score a source or output

1. Identify the artifact (a SKILL.md draft, a reference document, a
   pull request, a release candidate).
2. Walk the 9 cells in order. For each, write one sentence rationale
   and a numeric score.
3. Compute the aggregate per the active mode.
4. If aggregate clears threshold: surface to architect with the
   filled grid.
5. If aggregate does not clear: identify the cell that sank the
   aggregate, surface that cell and its rationale to the architect,
   propose remediation, do not auto-iterate without architect input.

The agent never self-issues a release verdict. The architect issues
verdicts on consequential outputs via the approval gate at
`build/APPROVAL_GATE_TEMPLATE.md`.

## Mapping the 9 cells to common questions

This is the question framing the agent walks through, in plain English:

- **P-Coverage**: Does the artifact accomplish the mission?
- **P-Self-contained**: Can a stranger understand the artifact without
  external context?
- **P-Importance**: Does this matter for the mission, or is it a
  side-quest?
- **E-Coverage**: Are all relevant sources cited?
- **E-Self-contained**: Can the reader verify each citation directly,
  without intermediate sources?
- **E-Importance**: Are the citations the right ones, or are they
  adjacent and convenient?
- **L-Coverage**: Does the rubric itself cover all axes of quality
  for this artifact type?
- **L-Self-contained**: Can a different reader apply the rubric and
  get the same score?
- **L-Importance**: Does the rubric weight the right things, or is it
  optimizing for the wrong target?

## ML backend hook (v0.1.0 stub only)

The `ml_backend` parameter from setup_intake routes here. When set
to `gepa_via_mlflow`, the agent emits a JSON scoring record after
each architect verdict, conformant to the GEPA expected input
schema. MLflow's `genai.optimize_prompts` API can then evolve the
rubric weights over a corpus of past verdicts.

v0.1.0 implements the JSON emission only. The actual MLflow
integration is deferred to v0.2.

When `openevolve` is selected, the equivalent emission hook is
exposed but not yet wired. v0.2 work item.

## What this skill does NOT do

- Does not auto-evolve rubrics in v0.1.0.
- Does not score artifacts the architect has not asked to be scored.
- Does not self-issue release verdicts.
- Does not modify cell weights without architect input.

## Citations

- arXiv:2507.17746, RaR. Source for the four design principles
  (Coverage, Self-contained, Importance, Reference Guidance) that
  inform the sub-axes.
- arXiv:2503.23339, Adaptive Precise Boolean Rubrics. Boolean-atomic
  mode rationale.
- arXiv:2507.18624, Apple/CMU Checklists. Supporting evidence that
  boolean checklists outperform free-form judging on structured tasks.
- arXiv:2510.07743, OpenRubrics. Synthetic rubric generation pattern.
- arXiv:2507.19457, GEPA. ML backend reference for v0.2.

End trinity_rubric.
