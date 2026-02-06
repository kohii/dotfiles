---
name: git-worktree
description: Git worktreeを専用ブランチで作成する。
---

# Git Worktree

利用可能なコマンド:

## 新規ブランチでworktreeを作成
```bash
git wtab <branch-name>
```
- 指定名で新規ブランチを作成しworktreeを追加
- worktreeは`../${repo_name}-worktree/${branch_name}`に作成される
- `setup-project.sh`が存在すれば自動実行

## 既存ブランチをworktreeに追加
```bash
git wtac <branch-name>
```
- 既存ブランチ（origin/<branch-name>）をworktreeに追加
- worktreeは`../${repo_name}-worktree/${branch_name}`に作成される
- `setup-project.sh`が存在すれば自動実行

## worktreeとブランチを削除
```bash
git wtd <branch-name>
```
- worktreeを削除し、ブランチも強制削除（`-D`）
- `../${repo_name}-worktree/${branch_name}`から削除される
