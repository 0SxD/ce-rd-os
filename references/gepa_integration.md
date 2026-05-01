# GEPA Integration

Source: arXiv:2507.19457 plus github.com/gepa-ai/gepa (Apache-2.0).

This document explains how the optional `gepa_via_mlflow` ML backend
hook in CE_RD_OS connects to the GEPA reflective prompt evolution
system. v0.1.0 ships the hook only. The actual integration is
deferred to v0.2.

## What GEPA does

GEPA (Gradient-free Evolutionary Prompt Adaptation) evolves prompts
and rubrics by reflecting on past performance and generating
candidate variants. It is gradient-free, meaning it does not require
training a model; it operates at the prompt and rubric level only.

GEPA integrates with MLflow, Pydantic AI, Comet ML Opik, OpenAI
Cookbook, HuggingFace Cookbook, and Google ADK.

## The MLflow hook point

MLflow exposes a `mlflow.genai.optimize_prompts` API. Given a corpus
of past evaluations (prompt, output, rubric score) and a target rubric,
the API can call GEPA under the hood to produce evolved prompt or
rubric variants.

## CE_RD_OS connection

When `ml_backend: gepa_via_mlflow` is set in setup_intake, the
trinity_rubric skill emits a JSON record after each architect verdict.
The record format:

```json
{
  "timestamp": "<ISO 8601>",
  "workstream": "<short_name>",
  "artifact_id": "<sha256_or_path>",
  "rubric_cells": {
    "P-Cov": <score>, "P-Self": <score>, "P-Imp": <score>,
    "E-Cov": <score>, "E-Self": <score>, "E-Imp": <score>,
    "L-Cov": <score>, "L-Self": <score>, "L-Imp": <score>
  },
  "aggregate": <score>,
  "architect_verdict": "approved | revisions | rejected",
  "architect_notes": "<string>"
}
```

The records accumulate in `mlflow_records/` (gitignored). When the
user has enough records (recommended minimum 50), they can call
`mlflow.genai.optimize_prompts` against the records to produce
candidate rubric weight updates.

## Integration steps (v0.2 work)

1. Install MLflow: `pip install mlflow>=2.10.0`.
2. Install GEPA: `pip install gepa-ai>=0.1.0`.
3. Configure MLflow tracking URI (local SQLite by default).
4. Set `ml_backend: gepa_via_mlflow` in the active workstream.
5. After each architect verdict, the trinity_rubric skill emits the
   JSON record described above.
6. Periodically run the optimization step against the corpus.
7. Review the candidate rubric weight updates with the architect.
8. Merge approved updates into the active rubric configuration.

v0.1.0 implements step 5 only (JSON emission). Steps 1 through 4 and
6 through 8 are v0.2 work items.

## License compatibility

GEPA is Apache-2.0. CE_RD_OS code is Apache-2.0. Compatible.

MLflow is Apache-2.0. Compatible.

## Alternatives

If the user prefers not to use GEPA, the `ml_backend` parameter
supports `openevolve` (see `references/ml_backend_options.md`) or
`custom` (user-supplied implementation via MCP).

## What this document does NOT do

- Does not implement the integration.
- Does not vendor GEPA code.
- Does not bundle MLflow.
- Does not advise on production MLflow deployments. Refer to
  mlflow.org docs for that.

## Citation block

- arXiv:2507.19457, GEPA paper.
- github.com/gepa-ai/gepa, Apache-2.0.
- mlflow.org, official documentation for `mlflow.genai.optimize_prompts`.

End gepa_integration.
