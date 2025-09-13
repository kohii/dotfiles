---
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git status:*), Bash(git branch:*)
argument-hint: [branch1] [branch2]
description: Git差分を構造化レポートとして生成
---

# Git差分解析レポート生成

## Context
- 現在のブランチ: !`git branch --show-current`
- 差分対象: !`if [ -z "$1" ]; then echo "HEAD"; elif [ -z "$2" ]; then echo "$(git branch --show-current)..$1"; else echo "$1..$2"; fi`
- 変更ファイル数: !`git diff $(if [ -z "$1" ]; then echo "HEAD"; elif [ -z "$2" ]; then echo "$1"; else echo "$1..$2"; fi) --stat | tail -1`

## Task
以下の差分を解析し、簡潔な構造化レポート（report.md）を生成：

!`git diff $(if [ -z "$1" ]; then echo "HEAD"; elif [ -z "$2" ]; then echo "$1"; else echo "$1..$2"; fi) --name-status`
!`git diff $(if [ -z "$1" ]; then echo "HEAD"; elif [ -z "$2" ]; then echo "$1"; else echo "$1..$2"; fi)`

### レポート要件
1. **概要** (1-2行): 変更の目的・影響を端的に
2. **主要変更** (箇条書き3-5項目): 
   - 🎯 機能追加
   - 🔧 修正内容
   - ♻️ リファクタリング
3. **技術詳細** (表形式):
   | カテゴリ | ファイル | 変更内容 |
   |---------|---------|---------|
   | コンポーネント | `path/file` | 具体的変更 |
4. **影響範囲**: 
   - 依存関係への影響
   - 破壊的変更の有無
5. **レビューポイント**: 重点確認箇所（2-3項目）

視覚的にスキャンしやすく、情報密度の高いMarkdownを生成。図、表、Asciiアート、絵文字を効果的に使用。

