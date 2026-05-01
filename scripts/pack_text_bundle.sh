#!/usr/bin/env bash
# pack_text_bundle.sh
# Generates the 10-file text bundle zip from this repo.
# Output: dist/ce-rd-os-v0.1.0-text-bundle.zip

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

VERSION="$(awk '/^version:/ {print $2; exit}' registry.yaml || echo '0.1.0')"
BUNDLE_NAME="ce-rd-os-v${VERSION}-text-bundle"
STAGING_DIR="dist/${BUNDLE_NAME}"
ZIP_PATH="dist/${BUNDLE_NAME}.zip"

echo "pack_text_bundle.sh: generating ${ZIP_PATH}"
echo "==========================================="

# Clean staging.
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

# 1. AGENTS.md - copy verbatim.
cp AGENTS.md "$STAGING_DIR/AGENTS.md"
echo "  staged 1/10: AGENTS.md"

# 2. README.md - copy verbatim.
cp README.md "$STAGING_DIR/README.md"
echo "  staged 2/10: README.md"

# 3. SETUP.md - copy verbatim.
cp SETUP.md "$STAGING_DIR/SETUP.md"
echo "  staged 3/10: SETUP.md"

# 4-9. Extract each SKILL.md body into a flat file.
extract_skill() {
    local skill_dir="$1"
    local out_name="$2"
    local src="skills/${skill_dir}/SKILL.md"
    local dst="$STAGING_DIR/${out_name}"
    if [ ! -f "$src" ]; then
        echo "  ERROR: $src not found"; exit 1
    fi
    cp "$src" "$dst"
    # Add a footer note explaining the file's lineage in the text bundle.
    {
        echo ""
        echo "---"
        echo ""
        echo "Extracted from skills/${skill_dir}/SKILL.md in CE_RD_OS v${VERSION}."
        echo "Source repo: https://github.com/0SxD/ce-rd-os"
    } >> "$dst"
}

extract_skill system_directive system_directive.md
echo "  staged 4/10: system_directive.md"

extract_skill setup_intake setup_intake.md
echo "  staged 5/10: setup_intake.md"

extract_skill source_ingestion source_ingestion.md
echo "  staged 6/10: source_ingestion.md"

extract_skill trinity_rubric trinity_rubric.md
echo "  staged 7/10: trinity_rubric.md"

extract_skill workstream_creator workstream_creator.md
echo "  staged 8/10: workstream_creator.md"

extract_skill publish_bundle publish_bundle.md
echo "  staged 9/10: publish_bundle.md"

# 10. PROCEED.md from packets/.
cp packets/PROCEED.md "$STAGING_DIR/PROCEED.md"
echo "  staged 10/10: PROCEED.md"

# Zip it.
( cd dist && rm -f "${BUNDLE_NAME}.zip" && zip -qr "${BUNDLE_NAME}.zip" "${BUNDLE_NAME}/" )

# SHA-256 sidecar.
( cd dist && sha256sum "${BUNDLE_NAME}.zip" > "${BUNDLE_NAME}.zip.sha256" )

# Cleanup staging dir; the zip is the artifact.
rm -rf "$STAGING_DIR"

echo ""
echo "Bundle ready:"
ls -lh "$ZIP_PATH" "$ZIP_PATH.sha256"
echo ""
echo "Drop the zip into NotebookLM, Claude project, custom Gem, or custom GPT."
echo "Then paste packets/PROCEED.md as the first prompt."
