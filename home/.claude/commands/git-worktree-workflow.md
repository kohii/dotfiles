# Worktreeを使ったGitワークフロー

## Gitコンテキスト
- 現在のブランチ: !`git rev-parse --abbrev-ref HEAD`
- リポジトリURL: !`git config --get remote.origin.url`
- Git状態: !`git status --porcelain`

## 手順

$ARGUMENTS

1. ユーザーのリクエストを理解する。
2. `git wtab <BRANCH_NAME>`コマンドでworktreeを作成する。
  - `git wtab`はworktreeディレクトリの作成、ブランチの追加、セットアップスクリプトの実行（存在する場合）を行う。
  - ユーザーのリクエストに基づきブランチ名を選択する。
3. worktreeディレクトリに移動する。
4. worktreeディレクトリで変更を行う。
  - バグ修正時は先に失敗するテストを書くことを推奨。
5. 変更をコミットする。
  - 長いタスクの場合、必要に応じて以前の状態に戻せるよう小さいステップでコミットする。
6. 変更をプッシュする。
7. PRを作成する。
8. GitHub Actionsチェックを監視する。
9. チェック失敗時は修正を支援する。
10. 元のディレクトリに戻る。
11. `git wtd <BRANCH_NAME>`コマンドでworktreeを削除する。
