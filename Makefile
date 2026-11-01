# @grgar's VS Code extension makefile (https://github.com/grgar/vscode-template)

.SUFFIXES:
version = $(shell (git describe 2>/dev/null || echo v0.0.0.0) | tr "-" "." | awk -F. -vOFS=. '{if (NF>3) $$3++; print $$1,$$2,$$3}' | cut -c 2-)
name = $(notdir $(CURDIR))
vsce-flags =
suffix =

.PHONY: install package release

install: ${name}-${version}-dev.vsix
	code --install-extension ${name}-${version}-dev.vsix

.INTERMEDIATE: ${name}-${version}-dev.vsix
${name}-${version}-dev.vsix:
	npx vsce package ${vsce-flags} ${version}-dev --no-git-tag-version --no-update-package-json

package:
	npx vsce package ${vsce-flags} ${version}${suffix} --no-git-tag-version --no-update-package-json

# Creates the version commit + tag and pushes them; the Release workflow
# (.github/workflows/release.yml) takes over from the tag push.
release:
	npm version ${version}
	git push origin main v${version}
