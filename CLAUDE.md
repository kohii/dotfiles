# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS that automates the setup and configuration of a comprehensive development environment. The repository uses shell scripts to symlink configuration files from the repository to their appropriate locations in the user's home directory.

## Key Commands

### Installation and Setup
- `./install.sh` - Main installation script that symlinks all dotfiles, configures macOS settings, and installs Homebrew packages
- `./configure_macos.sh` - Applies macOS system preferences and configurations
- `brew bundle` - Installs all packages and applications listed in the Brewfile

### Repository Management
- The repository uses `ghq` for organizing git repositories under `~/dev/src/`
- Quick repository navigation: Use `Ctrl+s` in terminal to fuzzy find and navigate to repositories (peco integration)
- Claude assistant shortcut: `yolo` - Runs Claude with skipped permissions

### Development Tools
- Primary editor: Neovim (`nvim`)
- Shell: Zsh with Sheldon plugin manager
- Terminal: Kitty with tmux
- Version management: mise (for multiple runtime versions)
- Directory environments: direnv for project-specific environment variables

## Repository Structure

The repository follows a flat structure where most configuration files are at the root level and get symlinked to appropriate locations:

- **Shell Configuration**: `.zshrc`, `.zshenv` - Main Zsh configuration
- **Git Configuration**: `.gitconfig`, `.gitignore_global` - Git settings and global ignores
- **Editor Configuration**: `.config/nvim/` - Neovim configuration
- **Terminal Configuration**: `.config/kitty/`, `.tmux.conf` - Terminal and tmux settings
- **Package Management**: `Brewfile` - Homebrew bundle for macOS packages
- **Installation Scripts**: `install.sh`, `configure_macos.sh` - Setup automation
- **File Manifest**: `dotfiles.txt` - List of files to be symlinked during installation

## Development Workflow

1. **Making Changes**: Edit configuration files directly in this repository
2. **Testing Changes**: Changes take effect immediately for symlinked files
3. **Committing**: Use standard git workflow with the extensive git aliases configured
4. **Automated Updates**: LaunchD job fetches dotfiles updates every 30 minutes (tokyo.kohii.gitfetch.plist)

## Special Configurations

- **Claude AI Integration**: `.claude/settings.json` contains permissions for pnpm commands (lint, test, build)
- **Global Git Ignore**: `.gitignore_global` applies to all git repositories
- **SSH to HTTPS**: Git configuration automatically converts GitHub HTTPS URLs to SSH

## Notes for Claude

When working in this repository:
1. Configuration files should maintain compatibility with macOS
2. Shell scripts should use bash for the installation process, but user shell is Zsh
3. Symlinks are created from `~/dotfiles/` to `~/` - never modify files in home directory directly
4. The repository assumes Homebrew is available for package management
5. Changes to shell configuration files require running `relogin` (alias for `exec $SHELL -l`) to take effect