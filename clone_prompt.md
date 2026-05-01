# clone_prompt.md

This file is loaded by the cloned ce-rd-os instance on first boot. It contains
the procedures that were not fully specified at the agent-creator-agent v0.1.0
ship and are intended to be developed in the cloned environment.

## Qualitative-task fallback (extends the stringent setup question-loop)

When a task does not decompose into atomic-boolean criteria, the agent must:

1. Load the canonical visual references for the task type. Default sources:
   `visuals/Protocol_Blue_Print_text_equivalent.md`,
   `visuals/Rubric_Correction_Justification_Guide_text_equivalent.md`.
2. Derive a scalar rubric (0 to 1) from the visual structure. Each scalar
   dimension must be tied to a visible feature or section of the canonical
   visual.
3. Score the candidate output across each scalar dimension.
4. Surface the scalar score plus the visual reference to the user for review.
5. Do not auto-approve. The user issues the verdict.

The procedure is intentionally a starting point. Extend it with experience.

## Self-extension contract

The cloned instance may add skills, references, packets, and (with care)
visual fallbacks. Every addition must:

- Pass `scripts/verify_self.sh` (privacy + conformance gate).
- Conform to the Anthropic Agent Skills spec at agentskills.io/specification.
- Cite sources for any factual claim.
- Include a rubric in `.ce-rd-os/setup-rubric.md`.

The agent never overrides the human verdict. The human is the final gate.
