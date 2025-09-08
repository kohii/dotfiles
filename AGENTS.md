# Repository Guidelines

## Project Structure & Module Organization
- Dotfiles live under `home/` and mirror paths in `$HOME` (e.g., `home/.zshrc`, `home/.config/kitty/kitty.conf`). The list is tracked in `dotfiles.txt`.
- Provisioning scripts at repo root: `install.sh` (creates symlinks from `home/` to `$HOME`), `configure_macos.sh` (macOS defaults), and `launchd/` for LaunchAgents plists.
- Package setup: `home/Brewfile` for Homebrew apps and CLIs.

## Build, Test, and Development Commands
- `./install.sh` — Create/update symlinks defined in `dotfiles.txt` (from `home/`) and load LaunchAgents.
- `./configure_macos.sh` — Apply macOS preferences (idempotent; some changes restart Finder).
- `brew bundle --file home/Brewfile` — Install taps, formulae, and casks.
- Syntax checks (optional): `bash -n install.sh`, `bash -n configure_macos.sh`.

## Coding Style & Naming Conventions
- Shell: Bash with clear functions, 4‑space indentation, `#!/bin/bash` shebang, comments prefixed with `#`/`##` for sections.
- Paths: Keep dotfiles under `home/` and app configs under `home/.config/<app>/`.
- LaunchAgents: Use reverse‑DNS `tokyo.kohii.<name>.plist` in `launchd/`.
- Keep scripts idempotent and safe for re‑runs; prefer `mkdir -p`, `ln -snf` patterns.

## Testing Guidelines
- No formal test suite. Validate changes by:
  - Running `./install.sh` and confirming links (`ls -l ~/.zshrc`).
  - Checking script syntax: `bash -n <file>`; lint with `shellcheck <file>` if available.
  - Verifying macOS settings manually after `./configure_macos.sh`.

## Commit & Pull Request Guidelines
- Messages: short, present‑tense verbs (e.g., `add`, `tweak`, `improve`), scope if helpful: `tweak zsh: update aliases`.
- PRs should include: summary, affected files, validation steps (commands run), and screenshots for UI/macOS changes when relevant.
- Avoid disruptive defaults; prefer opt‑in additions over removals. Note any breaking behavior in the PR description.

## Security & Configuration Tips
- Do not commit secrets, tokens, or machine‑specific paths. Use placeholders and document overrides when necessary.
- If adding new dotfiles, update `dotfiles.txt` and provide safe defaults.

## Agent‑Specific Instructions
- Keep changes minimal and focused; do not rename existing files without need.
- Respect existing patterns in `install.sh` (symlink behavior, idempotency) and `Brewfile` (taps first, then formulae/casks).
- Test locally on macOS where possible; avoid commands requiring elevated privileges in scripts.
