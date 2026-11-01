# VS Code extension template

This is @grgar's template for VS Code extensions.  
It's probably not useful for anyone else (at the moment at least).

The main changes are:

- using tabs, obviously
- adding a Makefile, they're great

## Releasing

Releases run entirely in GitHub Actions ([release.yml](.github/workflows/release.yml)), triggered by pushing a `v*` tag. Either:

- run `make release` locally — computes the next version from `git describe`, tags the current commit, and pushes the tag, or
- run the **Release** workflow from the Actions tab, which does the same remotely on the branch you run it from (an unsigned tag by the github-actions bot).

The workflow then tests, packages, publishes to the Visual Studio Marketplace, and creates a GitHub release with generated notes and the `.vsix` attached. `CHANGELOG.md` is generated from GitHub release notes at build time and ships only inside the `.vsix`, where the Marketplace renders it as the changelog tab — it's never committed. Likewise the `version` in `package.json` is just a `0.0.0` placeholder: each release is packaged with the version from its tag.

Pull requests are built by [ci.yml](.github/workflows/ci.yml), which runs the tests and uploads a `.vsix` (versioned `x.y.z-pr.<PR>.<run>`) as a workflow artifact. Download it from the run's summary page and install it with `code --install-extension`.

Required repository secrets:

- `VSCE_PAT` — Azure DevOps personal access token with the Marketplace **Manage** scope
- `OVSX_PAT` (optional) — [open-vsx.org](https://open-vsx.org) token; if set, the extension is also published to Open VSX (the namespace must be claimed once first)
