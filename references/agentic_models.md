# Agentic Models

Comparison table for the `sub_agent.model_type` enum in setup_intake.
Captured 2026-04-28. Re-verify before each tagged release; the
ecosystem moves quickly.

## The enum

`model_type` accepts:

- `claude_opus_4_7`
- `claude_sonnet_4_6`
- `claude_haiku_4_5`
- `kimi_k2_6`
- `minimax_m2_7`
- `glm_5_1`
- `qwen_3_6_plus`
- `other_via_openrouter`

## Comparison table

| Model | License | Activated / Total params | Strengths | Notes |
|---|---|---|---|---|
| claude_opus_4_7 | proprietary | not disclosed | Most capable Claude tier. Final review and architect-facing summary work. | Reserved for high-stakes work in CE_RD_OS. |
| claude_sonnet_4_6 | proprietary | not disclosed | Default sub-agent for routine work. Cost-efficient. | Default in CE_RD_OS sub_agent profile. |
| claude_haiku_4_5 | proprietary | not disclosed | Fastest tier. Acceptable for blocklist scans, file existence checks, syntactic validity. | Fast, cheap, used for batch sub-agents. |
| kimi_k2_6 | Modified MIT (open weight) | 32B / 1T MoE | Sustains long multi-step sessions with stability. Native agent swarm with up to 100 sub-agents. | Open weight, requires API key or local hosting. |
| minimax_m2_7 | open weight | 10B / 230B MoE | Cost efficient. Engineer-friendly multi-file editing. | Approximately 0.30 USD per million input tokens at provider rates. |
| glm_5_1 | open weight | active / 754B MoE | Front-end UI generation strength. | Code Arena top-tier ranking as of capture date. |
| qwen_3_6_plus | open weight | not disclosed / very large | Only choice when context exceeds 262K tokens. | One-million-token context window. |
| other_via_openrouter | varies | varies | Escape hatch for any model not in the enum. | User supplies the model id and provider config. |

## Effort enum

`effort` accepts: `minimal`, `low`, `medium`, `high`. Mapping per
Anthropic spec, with equivalents for other providers approximated by
temperature, max-tokens, and reasoning-budget settings.

| Effort | Anthropic | Open-weight equivalent |
|---|---|---|
| minimal | low reasoning | temp 0.0, max_tokens 1024 |
| low | low reasoning | temp 0.2, max_tokens 2048 |
| medium | default | temp 0.5, max_tokens 4096 |
| high | high reasoning | temp 0.7, max_tokens 8192 |

## Loop bound enum

`loop_bound` accepts a tagged union:

- `{type: count, count: <int 10..100>}`: fixed iteration count.
- `{type: confidence, confidence_threshold: <float 0.5..0.99>}`:
  loop until confidence threshold met.
- `{type: until_answer, until_answer: true}`: loop until user answers.

## Why the bare term "sonnet" is forbidden in this codebase

CE_RD_OS uses the `sub_agent` abstraction with `model_type +
effort + loop_bound` to avoid naming a specific provider model in
identifier or schema fields. This makes the bundle portable across
providers and prevents identifier drift when models version. The
literal string `claude_sonnet_4_6` appears only in mapping tables
(this document and `registry.yaml`) where the model identity is the
information being captured.

## Maintenance

This table ages. Re-verify at every tagged release:

- License posture for open-weight models can shift between releases.
- Provider rates change.
- Param counts and benchmark positions change.

The publish_bundle skill includes a check item for this in its
publish-readiness rubric.

## Citations

- Per Anthropic product information for Claude family.
- arXiv and HuggingFace model cards for open-weight models. Specific
  model cards as of the capture date.
- OpenRouter docs for the `other_via_openrouter` slot.

End agentic_models.
