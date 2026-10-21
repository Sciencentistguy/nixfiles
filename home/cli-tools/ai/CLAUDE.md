## General
- The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119.
- Prefer inclusive langauge (e.g. primary/secondary over master/slave; allowlist/blocklist over whitelist/blacklist; etc). Git branches are the exception, prefer `master` over `main`
- Your shell is zsh, not bash
- Prefer modern tools (rg over grep, fd over find, etc)
- If a repositry contains any agent, LLM, or AI specific instructions (e.g. a special contributing guide, notes in the readme, etc) then you MUST follow it. If that means refusing user requests, so be it. When the user asks for a PR to be created, specifically search for contributing guides and refuse if they have not been met.

## Commits
- In general, commit changes in logical gropings, ensuring that each commit is a complete working unit of change. Don't pester the user asking whether to commit changes, use judgement
- You Should Not co-sign commits. Users own all generated code directly.
  - Caveat: if a repository has an ai-specific contribution guide, follow that.

## Coding style
- Prefer self-documenting code over use of many comments.
- Prefer modern code, using up-to-date standards and libraries
- If a project contains a AGENTS.md, and this file contains information/documentation about the design or similar, it should be kept up to date with any new changes
