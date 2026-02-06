---
description: Dependabotセキュリティアドバイザリの分析と解決策の提示
---

## コンテキスト

Dependabot URL（GitHubセキュリティアドバイザリまたはPR URL）: {{ dependabot_url }}

## タスク

Dependabotセキュリティアドバイザリを分析し、解決策を提示する。

### ステップ1: アドバイザリ情報の収集

以下のコマンドで情報を収集:

**Dependabot情報の取得:**
URLの種類を判別し、適切なコマンドを使用:
- `/security/dependabot/[number]`を含む場合: `gh api /repos/[owner]/[repo]/dependabot/alerts/[number]`
- `/pull/`を含む場合: `gh pr view {{ dependabot_url }} --json title,body,commits`
- GitHub Security Advisory ID (GHSA-xxxx)を含む場合: `gh api /advisories/[GHSA-ID]`

**重要**: 404エラーを避けるため、提供されたURL種別に一致するコマンドのみ実行すること。

**プロジェクト状態の確認:**
- git status
- pnpm list --depth=0（直接依存関係の確認）
- 脆弱なパッケージが見つかった場合: pnpm why [package-name]

**実際の使用状況の確認（キャッシュ問題を避けるため）:**
- grep -r "[package-name]" package.json pnpm-lock.yaml（ロックファイルにパッケージが存在するか確認）
- ロックファイルに見つからない場合: 既に解決済みかキャッシュの問題の可能性

### ステップ2: 依存関係分析

脆弱なパッケージを以下のように分析:

1. **直接/間接依存の判別**
   - package.jsonにパッケージが存在するか確認
   - 存在する場合: 直接依存
   - 存在しない場合: 間接依存

2. **依存ツリーの分析**
   - pnpm why [package-name]の結果を分析
   - どの親パッケージがこのパッケージに依存しているか特定

### ステップ3: 解決策

**直接依存の場合:**
# パッケージを直接更新
pnpm update [package-name]
# またはpackage.jsonのバージョンを変更してから
pnpm install

**間接依存の場合:**
1. **親パッケージの更新要件を分析**
   # 脆弱性を解決する親パッケージのバージョンを確認
   pnpm info [parent-package-name] versions --json
   # package.jsonの現在のバージョンを確認
   cat package.json | grep [parent-package-name]

2. **解決オプションの分析**
   - 親パッケージの更新が**minor/patch**（低リスク）か**major**（高リスク）か確認
   - minor/patch更新の場合: 親パッケージの直接更新を推奨
   - major更新の場合: トレードオフ分析と共に両方のオプションを提示

3. **オプションA: 親パッケージ更新（minor/patchに推奨）**
   pnpm update [parent-package-name]@[specific-version]

4. **オプションB: overrides使用（major更新に推奨）**
   // package.jsonに追加
   {
     "pnpm": {
       "overrides": {
         "[package-name]": "^[safe-version]"
       }
     }
   }

### ステップ4: 分析レポート生成

以下の形式で分析結果を提示:

```
## Dependabotアドバイザリ分析

**参照URL**: {{ dependabot_url }}

### 脆弱なパッケージ
- **パッケージ名**: [package-name]（[直接/間接依存]）
- **現在のバージョン**: [current-version] → **推奨**: [recommended-version]
- **深刻度**: [severity-level]

### 解決策
**間接依存の場合、以下の分析を含める:**
- **親パッケージ**: [parent-package]（[current] → [required version]）
- **更新レベル**: [Major/Minor/Patch]
- **推奨方法**: [親パッケージ更新/overrides使用]
- **理由**: [Major更新は破壊的変更リスクあり/Minor更新は影響最小 等]

[具体的な解決手順]

### チェックリスト
- [ ] package.json変更なしでpnpm-lock.yamlのみ変更されていないか確認
- [ ] 間接依存の場合、依存元を特定済み
- [ ] パッケージがロックファイルに実際に存在する（古いキャッシュではない）
- [ ] 破壊的変更を確認済み
```

**全コマンドを実行し、上記形式で包括的な分析結果を提示すること。**
