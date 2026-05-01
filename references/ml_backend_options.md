# ML Backend Options

The `ml_backend` parameter in setup_intake takes one of four values:
`none`, `gepa_via_mlflow`, `openevolve`, or `custom`. This document
describes each option and its current implementation status.

## none (default)

- **What it is**: rubrics stay as defined in
  `skills/trinity_rubric/SKILL.md`. No automated refinement.
- **When to use**: most v0.1.0 deployments. The Trinity rubric is
  hand-tuned by the architect and does not need ML refinement.
- **Status in v0.1.0**: fully supported.

## gepa_via_mlflow

- **What it is**: reflective prompt and rubric evolution via GEPA
  (arXiv:2507.19457, github.com/gepa-ai/gepa, Apache-2.0). Wired
  through MLflow's `mlflow.genai.optimize_prompts` API.
- **When to use**: the user has accumulated a corpus of architect
  verdicts (recommended minimum 50) and wants to evolve rubric
  weights based on observed performance.
- **Status in v0.1.0**: hook only. The trinity_rubric skill emits
  the JSON record format described in `references/gepa_integration.md`.
  Actual MLflow + GEPA integration is v0.2 work.

## openevolve

- **What it is**: evolutionary search over prompts and code. Reports
  +23 percent accuracy on HotpotQA in published benchmarks.
- **Source**: github.com/algorithmicsuperintelligence/openevolve. License
  needs verification before adoption.
- **When to use**: alternative to GEPA. The user prefers evolutionary
  search over reflective prompt evolution.
- **Status in v0.1.0**: hook stub only. License verification and
  integration are v0.2 work.

## custom

- **What it is**: user-supplied ML backend. Exposed via MCP.
- **When to use**: the user has an existing prompt-optimization
  pipeline and wants to plug it in.
- **Status in v0.1.0**: stub. The user implements the MCP server
  themselves.

## Selection guidance for v0.1.0

For most v0.1.0 deployments, `none` is the right choice. The hooks
for the other backends exist so v0.2 work does not require breaking
changes.

## What this document does NOT do

- Does not advise on which backend will work better for a given
  domain. Defer to the published benchmarks and the user's empirical
  experience.
- Does not implement any of the backends in v0.1.0.
- Does not vendor GEPA, OpenEvolve, or MLflow code.

## Citations

- arXiv:2507.19457, GEPA paper.
- github.com/gepa-ai/gepa, Apache-2.0.
- github.com/algorithmicsuperintelligence/openevolve.
- mlflow.org, official documentation.
- arXiv on PromptBreeder (research-only, not in the v0.1.0 enum but
  mentioned as adjacent prior art).
- arXiv:2603.21520, MemAPO. Memory-driven prompt optimization.
- arXiv:2603.18620, Learning to Self-Evolve.

End ml_backend_options.
