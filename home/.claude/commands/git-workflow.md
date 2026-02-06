---
description: "ブランチ作成、コミット、プッシュ、PR作成、GitHub Actionsの監視"
---

# Gitワークフロー自動化

## Gitコンテキスト
- 現在のブランチ: !`git rev-parse --abbrev-ref HEAD`
- リポジトリURL: !`git config --get remote.origin.url`
- Git状態: !`git status --porcelain`

## 手順

新規ブランチ作成、変更のコミット、リモートへプッシュ、PR作成、GitHub Actionsチェックの監視を行う。チェック失敗時は修正を支援する。

ブランチ名: $ARGUMENTS

- ブランチ名が指定されている場合、それを使用。
- ブランチ名未指定で現在のブランチが`main`、`develop`、`master`、`release`の場合、適切なブランチ名を決定する。
  - リポジトリのorganizationが`bw-company`の場合、`kohii/`プレフィックスを使用。
- それ以外の場合、現在のブランチを使用。（新規ブランチ作成不要）

PR内容:

- リポジトリのorganizationが`bw-company`の場合、タイトルと説明を日本語で記述。
- コミット前にlinterを実行する。
