---
name: setup-intake
description: >
  Use this skill immediately after system_directive at session start.
  Captures the irreducible parameters needed to run any CE_RD_OS workstream:
  mission, role, sources, rubric mode, sub_agent profile, memory option,
  ML backend option, loop bound, output target. Trigger when the user says
  "set up", "let's begin", "what do you need from me to start", or when the
  agent recognizes a new workstream is being initiated. Asks at most three
  questions per turn.
license: Apache-2.0
metadata:
  version: 0.1.0
  category: setup
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

# setup_intake

Captures the irreducible parameters before any workstream begins.

## The 9 parameters

The agent walks the user through these 9 questions in order. At most
three questions per turn. The user can answer "default" to accept the
recommendation for any item.

### 1. Mission

What is the goal of this workstream? One sentence. The user describes
what success looks like.

Example: "Ship CE_RD_OS v0.1.0 to GitHub as a public, presentable,
privacy-clean dual-track artifact."

### 2. Role

What role should the agent take? One sentence.

Example: "Senior research engineer. Compound-engineering practitioner.
Conservative on scope, aggressive on quality."

### 3. Sources

Where does the source material live? List paths and URLs.

Example: "/mnt/project/research_findings.md, /mnt/uploads/handoff.md,
arXiv:2507.17746."

### 4. Rubric mode

How should outputs be evaluated against the Trinity rubric?

- `boolean` (default): each of the 9 cells is 0 or 1. Sum threshold for
  pass.
- `sparse_jump_3`: each cell is -1, 0, or +1.
- `scaled_0_1`: each cell is a continuous score 0.0 to 1.0.
- `ml_assisted`: scaled mode plus an ML backend (see parameter 7).

Default: `boolean`.

### 5. sub_agent profile

The agent runs sub-tasks under this profile. Three sub-parameters:

- `model_type`: enum from `claude_opus_4_7`, `claude_sonnet_4_6`,
  `claude_haiku_4_5`, `kimi_k2_6`, `minimax_m2_7`, `glm_5_1`,
  `qwen_3_6_plus`, or `other_via_openrouter`.
- `effort`: enum from `minimal`, `low`, `medium`, `high`.
- `loop_bound`: union type. One of:
  - `{type: count, count: <int 10..100>}`, fixed iteration count.
  - `{type: confidence, confidence_threshold: <float 0.5..0.99>}`,
    loop until confidence threshold met.
  - `{type: until_answer, until_answer: true}`, loop until user answers.

Default for routine work: `{model_type: claude_sonnet_4_6, effort: medium,
loop_bound: {type: count, count: 20}}`. See
`references/agentic_models.md` for guidance.

### 6. Memory option

How should state persist across turns or sessions?

- `none` (default): stateless. Recommended for first-time users.
- `mem0`: memory layer (github.com/mem0ai/mem0, Apache-2.0). Bolt-on,
  framework-agnostic.
- `letta`: agent runtime with Core / Recall / Archival memory tiers
  (github.com/letta-ai/letta, Apache-2.0).
- `custom`: user-supplied via MCP.

See `references/memory_options.md`.

### 7. ML backend option

For rubric refinement and prompt evolution.

- `none` (default): rubrics stay as defined.
- `gepa_via_mlflow`: arXiv:2507.19457, github.com/gepa-ai/gepa,
  Apache-2.0. Reflective prompt evolution via MLflow integration.
- `openevolve`: github.com/algorithmicsuperintelligence/openevolve.
  Evolutionary search over prompts and code.
- `custom`: user-supplied.

v0.1.0 ships the hook only. Implementations are deferred to v0.2.
See `references/ml_backend_options.md` and `references/gepa_integration.md`.

### 8. Loop bound (workstream-level)

Separate from the sub_agent loop_bound. Bounds the entire workstream.

- `{type: count, count: <int>}`: stop after N iterations.
- `{type: confidence, confidence_threshold: <float>}`: stop when the
  Trinity rubric aggregate score crosses threshold.
- `{type: until_answer, until_answer: true}`: stop when the architect
  signals done.

Default: `{type: until_answer, until_answer: true}`.

### 9. Output target

Where does the workstream's output go?

- `chat_only`: outputs render in this conversation, no files written.
- `repo`: outputs write to the current repo under the appropriate path.
- `text_bundle`: outputs target the 10-file text zip via publish_bundle.
- `dual`: both repo and text_bundle.

Default: `dual`.

## Intake procedure

1. Read system_directive (already loaded if you reached here).
2. Greet the user, state the 9 parameters above will be asked.
3. Ask in batches of three (1-3, then 4-6, then 7-9), or one at a time
   if the user prefers.
4. For each answer, confirm before proceeding.
5. After all 9, summarize the locked configuration and ask the user
   to approve before any workstream begins.
6. Save the locked configuration as a host-side note titled
   `ce_rd_os_setup.md`. The format is YAML matching the
   `sub_agent_default` block in `registry.yaml`.

## What the agent does NOT do during intake

- Does not start any workstream before all 9 parameters are locked.
- Does not assume defaults silently. If the user says "default", the
  agent confirms the default value before locking.
- Does not invent fields. The 9 parameters are the irreducible set
  for v0.1.0.
- Does not exceed three questions per turn.

## Citations

- arXiv:2507.17746, RaR. Coverage / Self-contained / Importance / Reference
  Guidance design principles inform the rubric mode parameter.
- arXiv:2507.19457, GEPA. Source for the `gepa_via_mlflow` option.
- github.com/letta-ai/letta, Apache-2.0. Source for the `letta` memory option.
- github.com/mem0ai/mem0, Apache-2.0. Source for the `mem0` memory option.
- The "no proprietary model name in identifier fields" pattern is
  documented in `references/agentic_models.md`.

End setup_intake.
