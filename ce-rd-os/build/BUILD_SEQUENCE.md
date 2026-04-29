# BUILD_SEQUENCE.md
## Ordered build checklist for CE_RD_OS v0.1

Format: each step has prerequisites, output, validation, parallelizable flag.
The receiving agent works through this top to bottom unless the Architect overrides.

---

## Phase 0: Repository initialization

### Step 0.1 Initialize repo
- **Prereq:** Q1 attribution decision (or default b)
- **Action:** Create local git repo. Configure user.name and user.email per Q1 decision.
- **Output:** `.git/` initialized with privacy-clean identity
- **Validation:** `git config user.email` does NOT contain personal email if Q1 != a
- **Parallelizable:** no, root step

### Step 0.2 Resolve open Qs
- **Prereq:** session start with Architect online OR 1 turn with no answer
- **Action:** Send Q1, Q2, Q3 to Architect. Wait one turn. If no answer, use defaults.
- **Output:** locked decisions logged in CHANGELOG.md
- **Validation:** CHANGELOG.md entry "v0.1.0-pre1: Q1=X, Q2=Y, Q3=Z (architect-decided | default)"
- **Parallelizable:** no

### Step 0.3 Resolve Appendix B gaps (parallel adjacent session)
- **Prereq:** Step 0.1 done
- **Action:** Spawn adjacent session with brief: "Search auditable repos for: CORAL self-learning agent (Harvard/MIT/Stanford), gitnexus, space-agent, oh-my-codex, meta-harness Stanford. Return short report with URL + license + audit verdict for each. 10-minute budget. If not found, return empty result, do not invent."
- **Output:** `references/open_research.md` with verified findings or "deferred to v0.2" stubs
- **Validation:** all 6 terms have a row in the table, even if "not found"
- **Parallelizable:** YES (runs in background while main build proceeds)

---

## Phase 1: Universal instruction files

### Step 1.1 AGENTS.md
- **Prereq:** Step 0.1, Step 0.2
- **Source content:** workstream MDs + research findings sections 3 (spec landscape), 7 (recommended scope), 8 (sub-agent abstraction)
- **Action:** Write AGENTS.md per agents.md format. Include:
  - One-line project description
  - Setup commands
  - Test commands (verify_self.sh)
  - Code style notes (markdown, no emdashes, paraphrase-first)
  - Architecture overview (skills/ + references/ + scripts/)
  - Privacy guard (point to verify_self.sh)
  - Sub-agent permissions for downstream agents
  - Build log section (initially empty)
- **Output:** `AGENTS.md` at repo root
- **Validation:** plain markdown, no YAML frontmatter, no schema requirement, parses without error
- **Parallelizable:** no, foundation file

### Step 1.2 CLAUDE.md and GEMINI.md (one-liner refs)
- **Prereq:** Step 1.1
- **Action:** Each file contains ONE LINE: "See AGENTS.md."
- **Output:** `CLAUDE.md`, `GEMINI.md`
- **Validation:** files exist, contain only the one-liner
- **Parallelizable:** YES, both at once

### Step 1.3 README.md (human-facing)
- **Prereq:** Step 0.2 (need Q1 for author field)
- **Action:** Write human-readable README. Include:
  - Project name (CE_RD_OS or rename per Architect)
  - Tagline: "First branch of an evolving compound-engineered R&D system."
  - What it does (one paragraph, 4 sentences max)
  - How to use (Track A1 GitHub clone, Track A2 zip download)
  - Quick start (2 commands)
  - Cite agents.md spec, agentskills.io spec, RaR paper, GEPA paper, Compound Engineering reference
  - License notice
  - "v0.1 - first ship" marker
- **Output:** `README.md`
- **Validation:** under 250 lines, public-safe content only, citations point to verifiable URLs
- **Parallelizable:** no

### Step 1.4 LICENSE files
- **Prereq:** Step 0.2 (need Q2)
- **Action:** Write LICENSE per Q2 decision. If dual-licensed, write LICENSE-DOCS too.
- **Output:** `LICENSE` (and `LICENSE-DOCS` if dual)
- **Validation:** Standard license text matches SPDX identifier (Apache-2.0, MIT, GPL-3.0, CC-BY-4.0)
- **Parallelizable:** YES with Step 1.3

### Step 1.5 CHANGELOG.md
- **Prereq:** Step 0.2
- **Action:** Initialize Keep-a-Changelog format with v0.1.0 entry citing Q-decisions
- **Output:** `CHANGELOG.md`
- **Validation:** parses as Keep-a-Changelog, has [Unreleased] and [0.1.0] sections
- **Parallelizable:** YES

---

## Phase 2: Skill bodies (parallel sub-agent dispatch)

The 6 skills can be authored in parallel by 6 sub-agents, each pointed at the corresponding workstream MD.

### Step 2.1 system_directive
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_protocol_governance.md + research findings section 9 (multi-turn awareness) + the renamed protocol content (derived from system_directive blueprint but with all blocklisted terms replaced)
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/system_directive/SKILL.md` per agentskills.io spec. YAML frontmatter (name: system-directive, description: ...). Body contains identity, source hierarchy, 100-percent confidence loop, Trinity rubric reference, output contract.
- **Output:** `skills/system_directive/SKILL.md`
- **Validation:** frontmatter valid, name lowercase-hyphens, description has both what + when, body under 500 lines
- **Parallelizable:** YES

### Step 2.2 setup_intake
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_setup_intake.md + sub-agent abstraction spec from research findings section 8
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/setup_intake/SKILL.md`. Captures: goal, mode, rubric_type, sources, output_target, host, tier, deadline, sub_agent (model_type + effort + loop_bound), memory option, ml_backend.
- **Output:** `skills/setup_intake/SKILL.md`
- **Validation:** frontmatter valid, intake captures the 11 parameters, Socratic max 3 questions per turn enforced
- **Parallelizable:** YES

### Step 2.3 source_ingestion
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_research_ingestion.md + the user's uploaded ingest skill (treat as example, re-derive generic)
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/source_ingestion/SKILL.md`. DETECT / NORMALIZE / INTERROGATE / SCORE / ROUTE loop. Reference packet_shapes.md and quarantine_procedure.md from references/.
- **Output:** `skills/source_ingestion/SKILL.md`
- **Validation:** frontmatter valid, references resolve, no contracting-restricted terminology
- **Parallelizable:** YES

### Step 2.4 trinity_rubric
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_rubric_design.md + research findings section 2c (rubric engines) + section 6 (Trinity loop concrete spec)
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/trinity_rubric/SKILL.md`. 9-cell Trinity grid (Trinity rubric x Coverage/Self-contained/Importance). Modes: boolean, sparse-jump-3, scaled-0-1. ML backend hook (none | gepa | openevolve | custom).
- **Output:** `skills/trinity_rubric/SKILL.md`
- **Validation:** frontmatter valid, 9 cells defined, mode enum complete, ML hook documented but not implemented
- **Parallelizable:** YES

### Step 2.5 workstream_creator
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_workstream_creator.md (already a meta-skill template)
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/workstream_creator/SKILL.md`. Contains the workstream template at the bottom for users to spawn new workstreams.
- **Output:** `skills/workstream_creator/SKILL.md`
- **Validation:** frontmatter valid, template self-references correctly
- **Parallelizable:** YES

### Step 2.6 publish_bundle
- **Prereq:** Phase 1 done
- **Source:** WORKSTREAM_publish_bundle.md + research findings section 3 (convergence pattern) + section 4 (two-track delivery)
- **Sub-agent:** claude_sonnet_4_6, effort medium
- **Action:** Write `skills/publish_bundle/SKILL.md`. Generates AGENTS.md, packs text bundle, runs verify_self.sh, produces release notes.
- **Output:** `skills/publish_bundle/SKILL.md`
- **Validation:** frontmatter valid, references pack_text_bundle.sh, references verify_self.sh, SemVer 2.0.0 + Conventional Commits noted
- **Parallelizable:** YES

---

## Phase 3: References folder

### Step 3.1 RaR summary (rar_paper_summary.md)
- **Prereq:** Phase 2 done
- **Source:** research findings section 2c
- **Action:** Paraphrase the 4 RaR design principles (Coverage / Self-contained / Importance / Reference Guidance). Cite arXiv 2507.17746. Show the 9-cell Trinity mapping.
- **Output:** `references/rar_paper_summary.md`
- **Validation:** no quotes longer than 14 words, citation present, no displacive summary (under 30 words quoted continuous)
- **Parallelizable:** YES

### Step 3.2 GEPA integration (gepa_integration.md)
- **Prereq:** Phase 2 done
- **Source:** research findings section 2f
- **Action:** Document GEPA arXiv 2507.19457, the gepa-ai/gepa repo (Apache 2.0), MLflow integration via mlflow.genai.optimize_prompts API, and how the trinity_rubric ML hook plugs in.
- **Output:** `references/gepa_integration.md`
- **Validation:** citation present, MLflow API name accurate, integration steps numbered
- **Parallelizable:** YES

### Step 3.3 Memory options (memory_options.md)
- **Prereq:** Phase 2 done
- **Source:** research findings section 2b
- **Action:** Document the 4-option enum (none / mem0 / letta / custom) with tradeoffs.
- **Output:** `references/memory_options.md`
- **Parallelizable:** YES

### Step 3.4 ML backend options (ml_backend_options.md)
- **Prereq:** Phase 2 done
- **Source:** research findings section 2f
- **Action:** Document the ml_backend enum (none / gepa_via_mlflow / openevolve / custom).
- **Output:** `references/ml_backend_options.md`
- **Parallelizable:** YES

### Step 3.5 Packet shapes (packet_shapes.md)
- **Prereq:** Phase 2 done
- **Source:** user's uploaded packet-shapes.md (genericize, no contracting-restricted refs, no internal codenames)
- **Action:** Re-derive 3 packet shapes (conformant / adjacent / foreign) generically.
- **Output:** `references/packet_shapes.md`
- **Parallelizable:** YES

### Step 3.6 Quarantine procedure (quarantine_procedure.md)
- **Prereq:** Phase 2 done
- **Source:** user's uploaded quarantine-procedure.md (genericize)
- **Action:** Re-derive QUARANTINE.md template + override procedure.
- **Output:** `references/quarantine_procedure.md`
- **Parallelizable:** YES

### Step 3.7 Socratic question bank (socratic_question_bank.md)
- **Prereq:** Phase 2 done
- **Source:** user's uploaded socratic-question-bank.md (genericize)
- **Action:** Re-derive load-bearing question patterns. Cap at 3 questions per turn (system_directive constraint).
- **Output:** `references/socratic_question_bank.md`
- **Parallelizable:** YES

### Step 3.8 NotebookLM migration (notebooklm_migration.md)
- **Prereq:** Phase 2 done
- **Source:** user's uploaded notebooklm-migration.md (genericize)
- **Action:** Re-derive INVENTORY/CLASSIFY/COMPOSE/INTERROGATE/WRITE loop + license compatibility table.
- **Output:** `references/notebooklm_migration.md`
- **Parallelizable:** YES

### Step 3.9 Open research stubs (open_research.md)
- **Prereq:** Step 0.3 returned
- **Source:** Step 0.3 adjacent session output
- **Action:** Document Appendix B status (CORAL, gitnexus, etc.). For each, either: verified-with-URL, or deferred-to-v0.2.
- **Output:** `references/open_research.md`
- **Parallelizable:** YES (depends on 0.3, but 0.3 runs in parallel)

### Step 3.10 Agentic models reference (agentic_models.md)
- **Prereq:** Phase 2 done
- **Source:** research findings section 2e
- **Action:** Document the model landscape table (Kimi K2.6, MiniMax M2.7, GLM-5.1, Qwen 3.6 Plus, Claude Opus 4.7, Sonnet 4.6, Haiku 4.5). For each: license, params, agent capability, citation.
- **Output:** `references/agentic_models.md`
- **Parallelizable:** YES

---

## Phase 4: Scripts

### Step 4.1 verify_self.sh
- **Prereq:** Phase 1, Phase 2, Phase 3 done. PRIVACY_BLOCKLIST.md present.
- **Action:** Implement the script per the pseudocode in PRIVACY_BLOCKLIST.md section J. Add: AGENTS.md syntactic check, SKILL.md frontmatter validation per agentskills.io spec (name regex, description length), license file presence check, CHANGELOG.md presence check.
- **Output:** `scripts/verify_self.sh`, executable
- **Validation:** runs cleanly on the in-progress repo and detects intentional test violations (insert "a blocklisted term" in a test branch, verify it catches it)
- **Parallelizable:** no, gates Phase 5

### Step 4.2 pack_text_bundle.sh
- **Prereq:** Step 4.1 passing
- **Action:** Script that produces the 10-file zip:
  1. AGENTS.md
  2. README.md
  3. SETUP.md
  4. system_directive.md (extracted from skills/system_directive/SKILL.md)
  5. setup_intake.md (same)
  6. source_ingestion.md (same)
  7. trinity_rubric.md (same)
  8. workstream_creator.md (same)
  9. publish_bundle.md (same)
  10. PROCEED.md
- **Output:** `scripts/pack_text_bundle.sh`, executable
- **Validation:** produces `dist/ce-rd-os-v0.1.0-text-bundle.zip` with exactly 10 files at the root of the zip (no nested folders)
- **Parallelizable:** no, gates Phase 6

---

## Phase 5: User-facing handoff files

### Step 5.1 SETUP.md (user instructions)
- **Prereq:** Phase 1-4 done
- **Action:** Write user-facing setup guide. Two paths: (a) GitHub clone for Claude Code / Codex / Cursor / Aider, (b) zip drop into NotebookLM / Project / Gem / GPT.
- **Output:** `SETUP.md`
- **Validation:** both paths have copy-paste-ready commands or actions, under 200 lines
- **Parallelizable:** YES with 5.2

### Step 5.2 PROCEED.md (multi-turn host prompt)
- **Prereq:** Phase 1-4 done
- **Source:** research findings section 9
- **Action:** Write the multi-turn handoff prompt template per research findings section 9.
- **Output:** `PROCEED.md`
- **Validation:** under 50 lines, copy-paste-ready, clear multi-turn instructions
- **Parallelizable:** YES with 5.1

---

## Phase 6: Validation and release prep

### Step 6.1 Run verify_self.sh
- **Prereq:** all prior phases
- **Action:** Run script. If FAIL: surface, fix, re-run.
- **Output:** green log
- **Validation:** exit code 0
- **Parallelizable:** no

### Step 6.2 Run pack_text_bundle.sh
- **Prereq:** Step 6.1 green
- **Action:** Generate the zip.
- **Output:** `dist/ce-rd-os-v0.1.0-text-bundle.zip`
- **Validation:** zip has 10 files, total under 500 KB, unzip + drop into a test NotebookLM project, host can read AGENTS.md
- **Parallelizable:** no

### Step 6.3 Compound Engineering 14-reviewer pass (optional but recommended)
- **Prereq:** Steps 6.1, 6.2 done
- **Action:** Apply the EveryInc compound-engineering-plugin pattern: spawn 14 reviewer sub-agents (security, performance, architecture, simplicity, etc.) on the bundle. Triage findings by priority.
- **Output:** review report appended to AGENTS.md "Build log"
- **Validation:** all P0/P1 findings resolved, P2 findings either resolved or deferred to v0.2 with rationale
- **Parallelizable:** YES (14 reviewers run concurrently)

### Step 6.4 Tag and release notes
- **Prereq:** 6.1, 6.2 green; 6.3 if run
- **Action:** Tag v0.1.0. Write release notes citing all decisions, defaults used, and Track A scope.
- **Output:** git tag v0.1.0, RELEASE_NOTES_0.1.0.md
- **Parallelizable:** no

---

## Phase 7: Architect approval gate (Trinity)

### Step 7.1 Fill APPROVAL_GATE_TEMPLATE.md
- **Prereq:** Phase 6 done
- **Action:** Fill the Trinity rubric sections per APPROVAL_GATE_TEMPLATE.md.
- **Output:** filled approval gate document, posted to Architect
- **Validation:** all 3 sections present, claim-evidence pairs cited, no agent-self-issued verdict
- **Parallelizable:** no

### Step 7.2 Wait for Architect verdict
- **Prereq:** 7.1 submitted
- **Action:** wait. Do not push to public remote. Do not act on the bundle further until verdict.
- **Output:** Architect verdict: APPROVED / REVISIONS / REJECTED
- **Parallelizable:** no, blocking

### Step 7.3 Act on verdict
- If APPROVED: push to public GitHub remote, publish release, attach zip to release, notify Architect.
- If REVISIONS: implement fixes, re-run verify_self.sh, return to 7.1.
- If REJECTED: package what you have into HANDOFF_PACKET_v2.md, surface to Architect, do NOT push.

---

## Termination

Build is complete when one of:
- Step 7.3 APPROVED path completes (public ship done)
- HANDOFF_PACKET_v2.md is generated and Architect acknowledges receipt (continuation arc)
- Architect issues a stop signal at any point

Do NOT push to public remote without 7.2 APPROVED verdict.

---

End BUILD_SEQUENCE v1.
