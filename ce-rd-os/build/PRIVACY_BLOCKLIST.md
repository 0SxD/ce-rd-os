# PRIVACY_BLOCKLIST.md

Hard constraint: any term in this list appearing in any Track A (public) file fails the build.
Run via `scripts/verify_self.sh` before every commit.
This file itself is a build-time reference and is NOT shipped in Track A.

---

## Section A: personal identifiers (private to Architect)

```
Austin B. Green
Austin Green
@austin_green       (or whatever real GitHub handle, fill in via Q1)
sage_architect      (internal alias, do not expose)
```

Substitution rule: replace with the Q1-decided attribution. If Q1 = (b) handle-only, the GitHub handle goes in author fields ONLY in LICENSE / AGENTS.md / package metadata. If Q1 = (d) anonymous, all author fields say "ce-rd-os-contributors".

---

## Section B: internal project codenames (Track B private)

These are HumanX project canon. None ship in Track A v0.1.

```
HumanX
HumanX_Master_Capture
FateX
FateX_xDx
SageX
0sXai
WikiLLM
OpenBrain
Open Brain
Wiki_Log
Wiki Log
WIKI_LLM
PEL gate              (rename to "review_gate" or "approval_gate" in public docs)
PEL approval
PEL_GATE
pathos_ethos_logos    (in public docs say "Trinity rubric" or "Pathos-Ethos-Logos rubric"; the snake_case codename stays Track B)
143_protocol          (renamed to system_directive)
143 protocol
zero_trust_zero       (Track B identity verification, do not expose)
ztz3                  (same)
3ztz                  (same)
SFF_2026              (grant codename, private)
SFF 2026
```

---

## Section C: Mercor-related terms (legal hygiene)

User has explicitly stated NO references to this contracting work in any public artifact.

```
Mercor
mercor
Pavilion
pavilion
Emporium
emporium
rubric criteria       (Mercor terminology; if used in public docs, use "rubric items" or "rubric cells" instead)
criterion tags
autoreviewer          (Mercor terminology; use "automated review" in public)
factual_error
hallucination_check   (only as Mercor-specific term; generic use of "hallucination" is fine)
antihack
contextual_benchmarking
trade_off_tag
durability_tag
lab_test_tag
spec_baseline_tag
user_sentiment_tag
grounding URLs        (Mercor terminology; use "source URLs" instead)
```

Note: generic words like "rubric", "review", "trade-off" are fine standalone. The blocklist targets the Mercor-specific COMPOUND terms above, not generic vocabulary.

---

## Section D: model names that need rename per Architect

```
sonnet                (forbidden as identifier; use sub_agent.model_type. The literal string "claude_sonnet_4_6" is allowed in mapping tables ONLY)
sonnet_ok             (column name from skills.md; rename to subagent_compatible)
opus                  (forbidden as bare identifier; use claude_opus_4_7 or sub_agent.model_type)
haiku                 (forbidden as bare identifier; use claude_haiku_4_5)
```

Exception: in references/agentic_models.md, model names appear in a comparison table with explicit version strings. That use is allowed.

---

## Section E: model claims that must include a citation

These statements need an arXiv or official-doc citation if used in public docs. If the citation is missing, the statement gets flagged.

```
"state of the art"     (without benchmark + date)
"best in class"        (without benchmark)
"outperforms"          (without specific benchmark and percentage)
"groundbreaking"
"revolutionary"
"first of its kind"
```

These are evaluator-flag-bait per the source_hierarchy mandate. Replace with paraphrased benchmark-cited statement or remove.

---

## Section F: API keys and credentials patterns

Regex patterns the verify_self.sh script must scan for:

```
sk-[a-zA-Z0-9]{48}                  OpenAI key shape
sk-ant-[a-zA-Z0-9]{32,}              Anthropic key shape
ghp_[a-zA-Z0-9]{36,}                 GitHub personal access token
github_pat_[a-zA-Z0-9_]{82}          GitHub fine-grained token
xoxb-[a-zA-Z0-9-]{50,}               Slack bot token
AIzaSy[a-zA-Z0-9_-]{33}              Google API key
AKIA[A-Z0-9]{16}                     AWS access key
glpat-[a-zA-Z0-9_-]{20}              GitLab token
```

Plus generic env-var-leak patterns:

```
[A-Z_]+_API_KEY=[^x]                 any API key assigned a real value
PASSWORD=                            any password assignment
SECRET=                              any secret assignment
TOKEN=[^x]                           any token with real value
```

Test fixtures using `xxx` or `your_key_here` or `${VAR}` placeholder are allowed.

---

## Section G: file path leaks

```
/mnt/project/        (source-session-only path, not for public docs)
/mnt/user-data/      (same)
/Users/[a-zA-Z0-9]+  (personal home directory leak)
/home/[a-zA-Z0-9]+   (personal home directory leak)
C:\\Users\\[a-zA-Z0-9]+   (Windows personal home leak)
```

Public docs use generic paths like `~/projects/ce-rd-os/` or `./skills/`.

---

## Section H: PEL/Trinity rename map for public docs

Internal term -> Public term:

```
143_protocol             -> system_directive
143 protocol             -> system protocol
PEL gate                 -> approval_gate
PEL approval             -> review approval
pathos_ethos_logos       -> trinity_rubric (snake_case for code, Trinity Rubric for prose)
sonnet                   -> sub_agent.model_type
sonnet_ok                -> subagent_compatible
zero_trust_zero          -> (do not expose; identity verification stays Track B)
0sXai                    -> ce-rd-os
HumanX                   -> (do not expose)
WikiLLM                  -> (do not expose)
```

---

## Section I: image and visual leaks

```
.jpg files in repo with EXIF metadata containing personal info
.png screenshots showing internal project codenames in window titles
PDF metadata with author name (run `pdftk file.pdf dump_data` to verify)
```

Strip EXIF from any image asset before commit. PDF assets need metadata wiped.

---

## Section J: verify_self.sh pseudocode

```bash
#!/usr/bin/env bash
set -euo pipefail

BLOCKLIST_FILE="$(dirname "$0")/../PRIVACY_BLOCKLIST.md"
EXCLUDE='--exclude-dir=.git --exclude-dir=node_modules --exclude=PRIVACY_BLOCKLIST.md'

extract_terms() {
    awk '/^```$/{p=!p; next} p && !/^[[:space:]]*$/ && !/^#/ {print $1}' "$BLOCKLIST_FILE" \
        | grep -v '^$' | sort -u
}

FAIL=0
while IFS= read -r term; do
    if grep -r $EXCLUDE -F "$term" . > /dev/null 2>&1; then
        echo "BLOCKLIST HIT: $term"
        grep -r $EXCLUDE -Fn "$term" . | head -3
        FAIL=1
    fi
done < <(extract_terms)

if [ "$FAIL" -eq 1 ]; then
    echo "verify_self.sh: FAILED (privacy blocklist hits found above)"
    exit 1
fi

# Frontmatter validation, license check, etc. follow

echo "verify_self.sh: PASSED (privacy gate clean)"
exit 0
```

The receiving agent should harden this skeleton (regex patterns from Section F need actual grep -P or rg, the `extract_terms` function is illustrative; agent writes the production version).

---

## Section K: false positive handling

If a blocklist term has a legitimate use in public docs (e.g., the word "Mercor" in a citation to a Mercor public paper), the agent must:

1. Surface the false positive to Architect via PEL gate
2. Architect approves a per-file allowlist exception
3. Allowlist exception is documented in `.privacy-allowlist.md` (gitignored from public, kept in Track B)
4. verify_self.sh reads the allowlist and skips approved instances

Default behavior: blocklist wins, no allowlist exceptions until Architect signs off.

---

End PRIVACY_BLOCKLIST v1.
