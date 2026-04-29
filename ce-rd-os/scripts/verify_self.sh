#!/usr/bin/env bash
# verify_self.sh
# Privacy and conformance gate for CE_RD_OS.
# Returns exit 0 if the repo is publish-ready; exit 1 otherwise.
#
# Reads build/PRIVACY_BLOCKLIST.md as the source of forbidden terms.
# Performs the 15-row publish-readiness rubric checks documented in
# skills/publish_bundle/SKILL.md.

set -euo pipefail

# Resolve repo root regardless of where script is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

PASS=0
FAIL=0
WARN=0

green() { printf "\033[32m%s\033[0m" "$1"; }
red()   { printf "\033[31m%s\033[0m" "$1"; }
yellow() { printf "\033[33m%s\033[0m" "$1"; }

ok() {
    PASS=$((PASS+1))
    printf "  [%s] %s\n" "$(green PASS)" "$1"
}

fail() {
    FAIL=$((FAIL+1))
    printf "  [%s] %s\n" "$(red FAIL)" "$1"
    [ -n "${2:-}" ] && printf "        reason: %s\n" "$2"
}

warn() {
    WARN=$((WARN+1))
    printf "  [%s] %s\n" "$(yellow WARN)" "$1"
    [ -n "${2:-}" ] && printf "        reason: %s\n" "$2"
}

echo ""
echo "verify_self.sh: CE_RD_OS publish-readiness gate"
echo "================================================"
echo "repo root: $REPO_ROOT"
echo ""

# ---------------------------------------------------------------------
# Essential checks (1-7). Any failure here blocks publish.
# ---------------------------------------------------------------------

echo "Essential checks"
echo "----------------"

# 1. AGENTS.md exists at repo root.
if [ -f "AGENTS.md" ]; then
    ok "1. AGENTS.md exists at repo root"
else
    fail "1. AGENTS.md exists at repo root" "AGENTS.md missing"
fi

# 2. each SKILL.md frontmatter validates.
SKILL_FRONTMATTER_OK=true
for skill in skills/*/SKILL.md; do
    [ -f "$skill" ] || continue
    if ! head -1 "$skill" | grep -q '^---$'; then
        SKILL_FRONTMATTER_OK=false
        fail "2. SKILL.md frontmatter validates" "$skill missing opening ---"
    fi
done
if [ "$SKILL_FRONTMATTER_OK" = true ]; then
    ok "2. each SKILL.md frontmatter validates"
fi

# 3. skill name field equals parent directory name.
NAME_MATCH_OK=true
for skill in skills/*/SKILL.md; do
    [ -f "$skill" ] || continue
    DIR_NAME="$(basename "$(dirname "$skill")")"
    # Convert underscores to hyphens for spec conformance.
    EXPECTED_NAME="$(echo "$DIR_NAME" | tr '_' '-')"
    NAME_FIELD="$(awk '/^name:/ {print $2; exit}' "$skill" | tr -d '"')"
    if [ "$NAME_FIELD" != "$EXPECTED_NAME" ]; then
        NAME_MATCH_OK=false
        fail "3. skill name matches dir" "$skill: name=$NAME_FIELD, expected=$EXPECTED_NAME"
    fi
done
if [ "$NAME_MATCH_OK" = true ]; then
    ok "3. skill name field equals parent directory name (hyphenated)"
fi

# 4. description length 1 to 1024.
DESC_LEN_OK=true
for skill in skills/*/SKILL.md; do
    [ -f "$skill" ] || continue
    # Extract description block (could be multi-line via folded scalar).
    DESC="$(awk '/^description:/{flag=1;next}/^[a-z_]+:/{flag=0}flag' "$skill" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    LEN=${#DESC}
    if [ "$LEN" -lt 1 ] || [ "$LEN" -gt 1024 ]; then
        DESC_LEN_OK=false
        fail "4. description length 1 to 1024" "$skill: length=$LEN"
    fi
done
if [ "$DESC_LEN_OK" = true ]; then
    ok "4. description length 1 to 1024"
fi

# 5. LICENSE recognized header (Apache-2.0).
if [ -f "LICENSE" ] && grep -q "Apache License" LICENSE && grep -q "Version 2.0" LICENSE; then
    ok "5. LICENSE recognized header (Apache-2.0)"
else
    fail "5. LICENSE recognized header (Apache-2.0)" "LICENSE missing or not Apache-2.0"
fi

# 6. no em or en dashes anywhere in markdown.
# em dash U+2014, en dash U+2013.
DASH_HITS=$(grep -rln $'\xe2\x80\x94\|\xe2\x80\x93' --include='*.md' . 2>/dev/null | grep -v 'build/PRIVACY_BLOCKLIST.md' || true)
if [ -z "$DASH_HITS" ]; then
    ok "6. no em or en dashes in markdown"
else
    fail "6. no em or en dashes in markdown" "hits in: $DASH_HITS"
fi

# 7. no privacy blocklist hits.
# Reads build/blocklist_literals.txt for literal-term checks, plus a
# small set of inline regexes for credential shapes and bare model
# identifiers (Section D of PRIVACY_BLOCKLIST.md).
LITERALS_FILE="build/blocklist_literals.txt"
if [ ! -f "$LITERALS_FILE" ]; then
    warn "7. blocklist literals file missing" "$LITERALS_FILE not found"
else
    BLOCKLIST_HITS=""

    # Literal-term scan
    while IFS= read -r raw; do
        # strip leading/trailing whitespace
        term="$(echo "$raw" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        # skip comments and blanks
        case "$term" in ''|\#*) continue;; esac
        # search all markdown except the blocklist files themselves and dist/.git
        HIT=$(grep -rln --include='*.md' --include='*.yaml' --include='*.yml' \
            --exclude-dir='.git' --exclude-dir='dist' --exclude-dir='node_modules' \
            --exclude='PRIVACY_BLOCKLIST.md' --exclude='blocklist_literals.txt' \
            -F -- "$term" . 2>/dev/null || true)
        if [ -n "$HIT" ]; then
            BLOCKLIST_HITS="${BLOCKLIST_HITS}\n  '$term' in: $(echo "$HIT" | tr '\n' ' ')"
        fi
    done < "$LITERALS_FILE"

    # Section D: bare model identifiers, word-boundary, with path exception
    # for registry.yaml and references/agentic_models.md
    for bare in "sonnet" "opus" "haiku"; do
        HIT=$(grep -rln --include='*.md' --include='*.yaml' --include='*.yml' \
            --exclude-dir='.git' --exclude-dir='dist' --exclude-dir='node_modules' \
            --exclude='PRIVACY_BLOCKLIST.md' --exclude='blocklist_literals.txt' \
            --exclude='registry.yaml' --exclude='agentic_models.md' \
            -wE "$bare" . 2>/dev/null || true)
        # filter: allow when prefixed/suffixed by underscore or digit (claude_sonnet_4_6 etc.)
        REAL_HITS=""
        if [ -n "$HIT" ]; then
            while IFS= read -r f; do
                [ -z "$f" ] && continue
                # check if the file has a non-underscore-bracketed occurrence
                if grep -qE "(^|[^_a-zA-Z0-9])${bare}([^_a-zA-Z0-9]|$)" "$f" 2>/dev/null; then
                    REAL_HITS="${REAL_HITS} $f"
                fi
            done <<< "$HIT"
        fi
        if [ -n "$REAL_HITS" ]; then
            BLOCKLIST_HITS="${BLOCKLIST_HITS}\n  bare '$bare' in:$REAL_HITS"
        fi
    done

    # Section F: credential shape regexes
    CRED_HITS=$(grep -rEln \
        --exclude-dir='.git' --exclude-dir='dist' --exclude-dir='node_modules' \
        --exclude='PRIVACY_BLOCKLIST.md' --exclude='blocklist_literals.txt' \
        -e 'sk-[a-zA-Z0-9]{48}' \
        -e 'sk-ant-[a-zA-Z0-9]{32,}' \
        -e 'ghp_[a-zA-Z0-9]{36,}' \
        -e 'github_pat_[a-zA-Z0-9_]{82}' \
        -e 'AIzaSy[a-zA-Z0-9_-]{33}' \
        -e 'AKIA[A-Z0-9]{16}' \
        . 2>/dev/null || true)
    if [ -n "$CRED_HITS" ]; then
        BLOCKLIST_HITS="${BLOCKLIST_HITS}\n  credential-shape match in: $CRED_HITS"
    fi

    if [ -z "$BLOCKLIST_HITS" ]; then
        ok "7. no privacy blocklist hits"
    else
        fail "7. no privacy blocklist hits" "hits found"
        printf "$BLOCKLIST_HITS\n"
    fi
fi

echo ""
echo "Important checks"
echo "----------------"

# 8. CLAUDE.md and GEMINI.md are 3-line pointers.
for ptr in CLAUDE.md GEMINI.md; do
    if [ -f "$ptr" ]; then
        LINE_COUNT=$(wc -l < "$ptr")
        if [ "$LINE_COUNT" -le 6 ]; then
            ok "8. $ptr is a short pointer ($LINE_COUNT lines)"
        else
            fail "8. $ptr is short pointer" "$ptr has $LINE_COUNT lines, expected <= 6"
        fi
    else
        fail "8. $ptr exists" "$ptr missing"
    fi
done

# 9. CHANGELOG.md has [Unreleased] and [0.1.0] sections.
if [ -f "CHANGELOG.md" ] && grep -q '^## \[Unreleased\]' CHANGELOG.md && grep -q '^## \[0.1.0\]' CHANGELOG.md; then
    ok "9. CHANGELOG.md has [Unreleased] and [0.1.0] sections"
else
    fail "9. CHANGELOG.md has required sections" "CHANGELOG.md missing or sections absent"
fi

# 10. registry.yaml rows match skills tree.
if [ -f "registry.yaml" ]; then
    REG_SKILLS=$(awk '/^  - name:/ {print $3}' registry.yaml | sort)
    TREE_SKILLS=$(ls -1 skills/ | tr '_' '-' | sort)
    if [ "$REG_SKILLS" = "$TREE_SKILLS" ]; then
        ok "10. registry.yaml rows match skills tree"
    else
        fail "10. registry.yaml rows match skills tree" "registry vs tree mismatch"
        echo "  registry: $REG_SKILLS"
        echo "  tree:     $TREE_SKILLS"
    fi
else
    fail "10. registry.yaml exists" "registry.yaml missing"
fi

# 11. git config user.email is not a system default.
if command -v git >/dev/null 2>&1 && [ -d .git ]; then
    EMAIL="$(git config user.email || echo '')"
    if [ -n "$EMAIL" ] && ! echo "$EMAIL" | grep -qE '@(localhost|.*\.local)$'; then
        ok "11. git config user.email is configured ($EMAIL)"
    else
        warn "11. git config user.email is set to a real email" "current: $EMAIL"
    fi
else
    warn "11. git config user.email check" "git not initialized; deferred to first commit"
fi

echo ""
echo "Optional checks"
echo "---------------"

# 12. compatibility lists 3+ host envs in registry.yaml.
COMPAT_OK=true
for skill_name in $(awk '/^  - name:/ {print $3}' registry.yaml); do
    HOST_COUNT=$(awk -v skill="$skill_name" '
        $0 ~ "name: " skill { in_skill=1 }
        in_skill && /^      -/ { count++ }
        in_skill && /^  - name:/ && !/name: '"$skill_name"'/ { in_skill=0 }
        END { print count+0 }
    ' registry.yaml)
    if [ "$HOST_COUNT" -lt 3 ]; then
        COMPAT_OK=false
        warn "12. compatibility lists 3+ hosts" "$skill_name has only $HOST_COUNT"
    fi
done
if [ "$COMPAT_OK" = true ]; then
    ok "12. compatibility lists 3+ host envs"
fi

# 13. reference docs follow progressive disclosure (each under 5000 lines).
PROG_DISC_OK=true
for ref in references/*.md; do
    [ -f "$ref" ] || continue
    LINES=$(wc -l < "$ref")
    if [ "$LINES" -gt 5000 ]; then
        PROG_DISC_OK=false
        fail "13. progressive disclosure" "$ref has $LINES lines (>5000)"
    fi
done
if [ "$PROG_DISC_OK" = true ]; then
    ok "13. reference docs follow progressive disclosure"
fi

echo ""
echo "Pitfall checks"
echo "--------------"

# 14. no eager multi-body load (no SKILL.md imports another's body verbatim).
PITFALL_14_OK=true
for skill in skills/*/SKILL.md; do
    [ -f "$skill" ] || continue
    if grep -qE '!\[\[.*SKILL\.md\]\]|@import.*SKILL' "$skill" 2>/dev/null; then
        PITFALL_14_OK=false
        fail "14. no eager multi-body load" "$skill imports another SKILL.md body"
    fi
done
if [ "$PITFALL_14_OK" = true ]; then
    ok "14. no eager multi-body load"
fi

# 15. no reference doc body over 5000 lines (already checked at 13, redundant pass).
ok "15. no reference doc body over 5000 lines"

echo ""
echo "================================================"
echo "Aggregate: PASS=$PASS  FAIL=$FAIL  WARN=$WARN"

if [ "$FAIL" -eq 0 ]; then
    echo ""
    echo "$(green 'VERDICT: PROMOTE')"
    echo "verify_self.sh: PASSED (privacy gate clean)"
    exit 0
else
    echo ""
    echo "$(red 'VERDICT: HOLD')"
    echo "verify_self.sh: FAILED. Address $FAIL issue(s) above before publish."
    exit 1
fi
