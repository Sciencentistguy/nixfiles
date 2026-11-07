## General
- Interpret the keywords "MUST", "SHOULD", "MAY" and their variants as described in RFC 2119.
- Use inclusive language (primary/secondary, allowlist/blocklist). Git branches are the exception: prefer `master` over `main`.
- The shell is zsh, not bash.
- Prefer modern tools (`rg` over `grep`, `fd` over `find`, etc).
- Nix is installed; for any CLI tool that is missing, use `nix-shell -p <pkg>` rather than `nix shell`.
- Nix projects are flake-based: `git add` new files before building, as flakes ignore untracked files.
- Read only the parts of a file you need (`offset`/`limit`); avoid re-reading whole files.

## Atuin
- The atuin MCP server is available. Proactively use it to find previous commands and agent sessions rather than asking the user or guessing.
- Search command history for how something was last invoked, whether it succeeded, and why it failed.
- Search threads when a task refers to earlier work ("last time", "again", "continue").

## Repository instructions
- You MUST follow any agent, LLM, or AI-specific instructions in a repository (contributing guides, readme notes, etc), even if that means refusing a user request.
- Before creating a PR, search for contributing guides and refuse if their requirements are not met.

## Commits
- Commit in logical groupings, each a complete working unit. Use judgement; don't ask whether to commit.
- You SHOULD NOT co-sign commits; the user owns all generated code. Exception: a repository's AI-specific contribution guide takes precedence, so check for one before committing.

## Coding style
- Prefer self-documenting code over comments.
- Prefer modern code, standards, and libraries.
- If a project has an AGENTS.md that documents its design, keep it up to date with changes.
