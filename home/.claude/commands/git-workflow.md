---
description: "Create branch, commit, push, and create PR with GitHub Actions monitoring"
---

# Git Workflow Automation

## Git context
- Current branch: !`git rev-parse --abbrev-ref HEAD`
- Repository url: !`git config --get remote.origin.url`
- Git status: !`git status --porcelain`

## Instructions

Create a new branch, commit changes, push to remote, create a pull request, and monitor GitHub Actions checks. Help fix issues if checks fail.

Branch name: $ARGUMENTS

- If a branch name is provided, use it.
- If no branch name is provided and the current branch is `main`, `develop`, `master` or `release`, decide an appropriate branch name.
  - If the repository's organization is `bw-company`, use prefix `kohii/`.
- Otherwise, use the current branch. (No need to create a new branch.)

PR content:

- If the repository's organization is `bw-company`, write the title and description in Japanese. 
- Run linter before committing.
