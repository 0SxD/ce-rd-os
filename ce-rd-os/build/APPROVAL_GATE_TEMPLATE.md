# APPROVAL_GATE_TEMPLATE

The Trinity approval gate. Filled by the receiving agent at the end
of the build sequence. The architect is the sole issuer of the final
verdict. The agent never self-issues. The agent fills the document,
surfaces it, and waits.

---

## Header (agent fills)

- Build version: ____
- Build date: ____
- Receiving agent identity: ____  (Claude Code CLI, Codex CLI, Cursor, Aider, etc.)
- Source session reference: ____
- Architect handle: ____
- Q-decisions used:
  - Q1 (attribution): ____
  - Q2 (license): ____
  - Q3 (must-haves): ____
- Open research status: ____  (resolved with citations, partially resolved, deferred)

---

## Section 1: Pathos (mission and execution)

Agent answers each item honestly. No claims of completion that are
not true.

### 1.1 Was the stated mission accomplished?

Mission per the active workstream:

```
[paste the one-sentence mission from setup_intake here]
```

Agent claim: ____  (yes, partially, no)

Evidence:

- Repo state: ____  (path or URL)
- Text bundle path: ____
- Files shipped: ____  (count)
- Files deferred: ____  (count)
- verify_self.sh exit code: ____
- pack_text_bundle.sh exit code: ____

### 1.2 Did the agent operate within the stated scope?

- Public-track only: ____  (yes, leakage detected, unsure)
- Private-track exclusion verified: ____
- Internal codename exclusion verified: ____
- All renames per privacy blocklist Section H applied: ____  (yes, partial, no)
- Q1 / Q2 / Q3 decisions logged in CHANGELOG: ____

If any "no" or "leakage detected" answer appears: agent stops and
writes a remediation plan in Section 4.

### 1.3 What did the agent NOT do?

Agent lists explicitly. Honesty required. Examples:

- Did not implement the optional ML backend (out of scope per Q3 default).
- Did not resolve N items in references/open_research.md (deferred to v0.2).
- Did not push to public remote (waiting on this gate).

---

## Section 2: Ethos (sources and evidence)

### 2.1 Source hierarchy compliance

Per system_directive: arXiv, official documentation, auditable
repos, institutional or laboratory reports, official user docs.

Agent confirms ALL citations in the bundle fall within this hierarchy:
____  (yes, exceptions listed below)

Exceptions, if any:

| File | Source | Tier | Reason for exception | Architect approval needed |
|---|---|---|---|---|
| | | | | |

### 2.2 Citation verification

For each claim in README.md, AGENTS.md, and references/:

- Citations present: ____  (count)
- Citations broken (404): ____  (count, run a link checker)
- Citations to retracted papers: ____  (count)
- Citations to non-Tier-1 sources without architect approval: ____  (must be 0)

### 2.3 Quote and paraphrase compliance

Per the output contract in system_directive:

- Direct quotes per source: max 1, under 14 words, in quotation marks.
- Paraphrase-first: must be the dominant pattern.
- No long (30+ word) summaries of any one source.

Agent confirms compliance: ____  (yes, violations listed)

### 2.4 License attribution

For every incorporated pattern or named tool:

- Compound Engineering plugin pattern: cited as MIT, attribution-only,
  no code copied: ____
- AGENTS.md spec: cited as Linux Foundation Agentic AI Foundation: ____
- Agent Skills spec: cited as Apache-2.0 / CC-BY-4.0: ____
- Rubrics as Rewards: cited as arXiv:2507.17746: ____
- GEPA paper plus repo: cited as arXiv:2507.19457 plus Apache-2.0: ____
- Letta architecture: cited as Apache-2.0 reference, no code copied: ____
- Mem0: cited as Apache-2.0 reference, no code copied: ____
- All other sources: ____

### 2.5 Privacy gate (verify_self.sh) result

Final run output, last execution:

```
[paste verify_self.sh stdout here]
```

Exit code: ____
Hits: ____  (must be 0 for green light)

### 2.6 License compatibility check

- All upstream licenses verified compatible with Apache-2.0: ____
- No GPL or AGPL code incorporated: ____
- NOTICES.md updated with current upstream attributions: ____

---

## Section 3: Logos (rubric evaluation)

The Trinity 3x3 rubric applied to the bundle itself.

Score each cell 0 (fail) or 1 (pass) in boolean mode. For scaled
mode, 0.0 to 1.0.

### 3.1 The 9-cell grid

|  | Coverage | Self-contained | Importance |
|---|---|---|---|
| Pathos (mission) | __ | __ | __ |
| Ethos (sources) | __ | __ | __ |
| Logos (rubric) | __ | __ | __ |

### 3.2 Cell rationales

One sentence each. No jargon. No displacive summaries.

- Pathos-Coverage: ____
- Pathos-Self-contained: ____
- Pathos-Importance: ____
- Ethos-Coverage: ____
- Ethos-Self-contained: ____
- Ethos-Importance: ____
- Logos-Coverage: ____
- Logos-Self-contained: ____
- Logos-Importance: ____

### 3.3 Aggregate

- Boolean mode threshold: 9/9 must pass for green light.
- If any cell scores 0: agent does not issue green light, lists
  remediation in Section 4.

Aggregate result: ____  (9/9 PASS, sub-9 with remediation needed)

### 3.4 Compound Engineering 14-reviewer pass results

If a multi-reviewer pass was run:

- Total findings: ____
- P0 (blocking): ____
- P1 (important): ____
- P2 (nice-to-have): ____
- All P0 resolved: ____
- All P1 resolved or explicitly deferred to next version: ____

If P0 or unresolved P1 remain: agent does not issue green light.

---

## Section 4: Remediation plan

For each deficit found in Sections 1, 2, or 3:

| Deficit | Severity | Proposed fix | Effort estimate | Architect input needed |
|---|---|---|---|---|
| | | | | |

If the remediation plan is non-empty: agent loops back to the
relevant build phase, fixes, re-runs verify_self.sh, re-fills
Sections 1 through 3, and re-submits this gate.

---

## Section 5: Handoff summary for architect

One paragraph, max 6 sentences. Architect reads this first.

Template:

> CE_RD_OS [version] build is at [phase]. Q-decisions: Q1=[__],
> Q2=[__], Q3=[__]. Privacy gate: [PASSED, FAILED]. Trinity rubric:
> [9/9, sub-9]. [N] files shipped, [M] deferred. Recommended verdict:
> [APPROVE, REVISIONS, REJECT]. Specific items needing architect
> attention: [list, max 3]. Awaiting verdict before [push to public
> remote, continuation handoff].

Agent fills:

> ____

---

## Section 6: Architect verdict (architect-only)

DO NOT FILL. Architect fills.

- [ ] APPROVED. Agent proceeds to push and publish.
- [ ] REVISIONS. Architect lists revisions below. Agent applies and
      re-submits.
- [ ] REJECTED. Architect provides reason. Agent packages state into
      a fresh handoff packet, surfaces, stops.

Architect signature line:

- Verdict: ____
- Architect identity verification: ____  (token, signature, or "n/a")
- Date: ____
- Conditions or revisions, if any: ____

---

## Section 7: Build log (append-only)

Each verify_self.sh run, each major decision, each architect
interaction logged here for audit.

```
[YYYY-MM-DD HH:MM] [actor] [event]
```

Initialize with the receiving session start time.

---

End APPROVAL_GATE_TEMPLATE.
