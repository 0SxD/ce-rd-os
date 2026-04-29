# Makefile for CE_RD_OS

.PHONY: help verify validate-skills package release clean install-hooks

help:
	@echo "CE_RD_OS make targets:"
	@echo "  verify           Run scripts/verify_self.sh (privacy + conformance gate)"
	@echo "  validate-skills  Validate every skills/<name>/SKILL.md frontmatter"
	@echo "  package          Run scripts/pack_text_bundle.sh (generate the 10-file zip)"
	@echo "  release          Verify, package, then prompt for release tag (manual gh release create)"
	@echo "  install-hooks    Install git pre-commit hook to run verify_self.sh"
	@echo "  clean            Remove dist/ artifacts"

verify:
	bash scripts/verify_self.sh

validate-skills:
	@for skill in skills/*/SKILL.md; do \
		echo "Validating $$skill"; \
		test -f $$skill || { echo "MISSING: $$skill"; exit 1; }; \
		head -1 $$skill | grep -q '^---$$' || { echo "FAIL: no YAML frontmatter delimiter in $$skill"; exit 1; }; \
		grep -q '^name:' $$skill || { echo "FAIL: no name field in $$skill"; exit 1; }; \
		grep -q '^description:' $$skill || { echo "FAIL: no description field in $$skill"; exit 1; }; \
	done
	@echo "All SKILL.md files validated."

package: verify
	bash scripts/pack_text_bundle.sh

release: verify package
	@echo ""
	@echo "Release artifacts ready in dist/."
	@echo "Next steps (manual, on Architect's machine):"
	@echo "  1. Review dist/ contents."
	@echo "  2. git tag -a v0.1.0 -m 'CE_RD_OS v0.1.0'"
	@echo "  3. git push origin v0.1.0"
	@echo "  4. gh release create v0.1.0 dist/ce-rd-os-v0.1.0-text-bundle.zip --notes-file dist/RELEASE_NOTES.md"
	@echo ""
	@echo "Do NOT push to public remote without filling and getting verdict on"
	@echo "build/APPROVAL_GATE_TEMPLATE.md."

install-hooks:
	@echo "Installing pre-commit hook to run verify_self.sh"
	@mkdir -p .git/hooks
	@printf '#!/usr/bin/env bash\nbash scripts/verify_self.sh\n' > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Done. .git/hooks/pre-commit now runs verify_self.sh on every commit."

clean:
	rm -f dist/*.zip dist/*.tar.gz dist/*.sha256
	@echo "Cleaned dist/ artifacts."
