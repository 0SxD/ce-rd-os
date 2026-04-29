# Socratic Question Bank

Question patterns the agent uses during setup_intake and
source_ingestion. Capped at three questions per turn per the
system_directive output contract.

## Setup intake questions

Used in `skills/setup_intake/SKILL.md`. The 9 parameters get one
question per parameter. Recommended phrasings:

### Mission

- "In one sentence, what does success for this workstream look like?"
- "When this workstream is done, what is true about the world that
  was not true before?"

### Role

- "What role should I take? Senior engineer, research analyst, project
  manager, devil's advocate, something else?"
- "How conservative or aggressive should I be on scope?"

### Sources

- "Where does the source material live? Paths, URLs, MCP connections?"
- "Are any sources off-limits or restricted?"

### Rubric mode

- "Default rubric mode is boolean-atomic. Does that work for this
  workstream, or do you want sparse_jump_3, scaled_0_1, or
  ml_assisted?"

### sub_agent profile

- "Default sub-agent is claude_sonnet_4_6, effort medium, loop bound
  count 20. Want to override any of those?"

### Memory option

- "Memory: none, mem0, letta, or custom? Default is none."

### ML backend option

- "ML backend: none, gepa_via_mlflow, openevolve, or custom? Default
  is none."

### Loop bound (workstream-level)

- "When should this workstream stop? Iteration count, confidence
  threshold, or until you tell me to stop?"

### Output target

- "Output target: chat only, repo, text bundle, or dual?"

## Source interrogation questions

Used in `skills/source_ingestion/SKILL.md` during INTERROGATE phase.
Standard set:

1. "What is this source's claim, in one sentence?"
2. "What is the evidence: citation, methodology, sample size?"
3. "What does the source not cover?"
4. "Who else has cited this source?"
5. "What would falsify this source's claim?"

The agent picks at most three of the five per turn. Source 1 and 2
are mandatory. Source 3, 4, 5 are picked based on which is most
load-bearing for the active workstream.

## Plan-review questions

Used when the agent surfaces a plan for architect approval.

- "Does this plan accomplish the mission?"
- "Are any sources missing?"
- "What would you change about the scope?"
- "Are any of these steps in the wrong order?"

## Ambiguity-detection questions

The agent uses these when the user's request could be interpreted
multiple ways.

- "I see two readings of this. Which is right: A) ... B) ...?"
- "Is the constraint that wins here X or Y?"
- "When you say <ambiguous term>, do you mean ... or ...?"

## What this document is NOT

- Not an exhaustive list. The agent's own judgment supplements these
  patterns.
- Not mandatory phrasings. The agent adapts to the user's tone.
- Not a script. The agent does not robotically walk through every
  question on every turn.

## Citations

- The Socratic method as a generic dialectical pattern, not a
  specific cited source.
- The three-questions-per-turn cap is a CE_RD_OS-specific constraint
  in `skills/system_directive/SKILL.md`.

End socratic_question_bank.
