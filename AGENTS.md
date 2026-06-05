# Agent Instructions: Gentoo Overlay Management

This document defines the automation workflows, engineering standards, and configuration schemas for this Gentoo Overlay. It is optimized for AI agents performing maintenance, package updates, or repository management.

## 1. Automation Workflow (CI/CD)

The repository employs a multi-repo orchestration for automated updates and dependency bundling:

| Step            | Component        | Action                                                                                              |
| :-------------- | :--------------- | :-------------------------------------------------------------------------------------------------- |
| **1. Monitor**  | `nvchecker`      | Periodically checks upstream versions based on `.github/workflows/overlay.toml`.                    |
| **2. Trigger**  | `bumpbot`        | Triggered on version mismatch; runs `nuclear06/bumpbot` (Go).                                       |
| **3. Dispatch** | GitHub Issues    | Creates issues in `gentoo-overlay` and `gentoo-deps` with required package metadata.                |
| **4. Bundle**   | `gentoo-deps` CI | Triggered by a `/approve` comment on the `gentoo-deps` issue. Generates vendor/dependency tarballs. |
| **5. Resolve**  | CI Response      | Posts the resulting tarball URL back to the issue for use in the ebuild.                            |

## 2. Engineering Standards

### Quality Control

- **Mandatory Linting**: Run `pkgcheck scan` or `pkgcheck ci` before every commit.
- **Verification**: Ensure EAPI 8 compliance for new packages unless otherwise specified.

### Commit Workflow

- **Tooling**: Use `pkgdev commit` for all changes.
- **Automation**: `pkgdev` handles automatic metadata updates, Manifest generation (if non-live), and basic formatting.

## 3. Package Onboarding (`overlay.toml`)

When adding a new package, you **must** update `.github/workflows/overlay.toml` to enable version tracking and dependency bundling.

### Configuration Schema

```toml
["category/package-name"]
source = "github" # or "gitea"
github = "owner/repo"
use_latest_release = true
prefix = 'v'
gentoo_deps_lang = "golang"
gentoo_deps_tag = "v{{newver}}"
gentoo_deps_p = "{{pn}}-{{newver}}"
gentoo_deps_repo = "owner/repo"
gentoo_deps_source_url = "https://example.com/repo.git" # Optional if source=github
gentoo_deps_disabled = false
```

### Field Reference

| Field                    |  Req  | Type / Values                                              | Description                                                                            |
| :----------------------- | :---: | :--------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| `gentoo_deps_lang`       | Yes\* | `golang`, `rust`, `dart`, `javascript`, `javascript(pnpm)` | Target language for dependency bundling.                                               |
| `gentoo_deps_tag`        | Yes\* | String (Template)                                          | Git tag/branch passed to `gentoo-deps`.                                                |
| `gentoo_deps_p`          | Yes\* | String (Template)                                          | The `P` (Name-Version) string for the dependency tarball.                              |
| `gentoo_deps_repo`       | Opt\* | `owner/repo`                                               | GitHub repository identifier.                                                          |
| `gentoo_deps_source_url` |  Opt  | Git URL                                                    | Clone URL (must end in `.git`). Mandatory for non-GitHub sources if `repo` is omitted. |
| `gentoo_deps_workdir`    |  No   | Path                                                       | Relative directory within the source for build operations.                             |
| `gentoo_deps_vendordir`  |  No   | Path                                                       | Output directory for `go mod vendor` (Golang only).                                    |
| `gentoo_deps_disabled`   |  No   | Boolean                                                    | Set `true` to skip `gentoo-deps` issue creation (default: `false`).                    |

**Constraints:**

- **Source Resolution**: At least one of `gentoo_deps_repo` or `gentoo_deps_source_url` must be effectively present.
- **GitHub Fallback**: If `source = "github"`, `gentoo_deps_source_url` is optional. If `gentoo_deps_repo` is also omitted, it automatically falls back to the top-level `github` field.
- **Git URL Requirement**: Any provided `gentoo_deps_source_url` must end with `.git`.

### Template Variables

The following fields support variable substitution:
`gentoo_deps_lang`, `gentoo_deps_tag`, `gentoo_deps_p`, `gentoo_deps_repo`, `gentoo_deps_source_url`, `gentoo_deps_workdir`, `gentoo_deps_vendordir`.

| Variable                   | Description                          |
| :------------------------- | :----------------------------------- |
| `{{name}}` / `{{package}}` | Full category/package name.          |
| `{{category}}`             | Package category.                    |
| `{{pn}}`                   | Package name without category.       |
| `{{newver}}`               | New version detected by `nvchecker`. |
| `{{oldver}}`               | Current version in the repository.   |
