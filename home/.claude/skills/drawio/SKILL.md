---
name: draw.io
description: draw.io (.drawio) XML図の作成ガイド。フォント設定、矢印配置、テキストサイズの注意点。
---

# draw.io 図作成スキル

## 必須ルール

### 1. フォント設定
`mxGraphModel`の`defaultFontFamily`だけでは不十分。**全テキスト要素**に`fontFamily`を追加:

```xml
<!-- ❌ NG -->
<mxCell id="label" value="Text" style="text;html=1;fontSize=18;" />

<!-- ✅ OK -->
<mxCell id="label" value="Text" style="text;html=1;fontSize=18;fontFamily=Noto Sans JP;" />
```

### 2. 矢印のレイヤー順序
XMLの記述順 = 描画順のため、矢印を図形**より前**に配置:

```xml
<root>
  <mxCell id="0" />
  <mxCell id="1" parent="0" />

  <!-- 矢印を先に（背面） -->
  <mxCell id="arrow1" edge="1" parent="1">...</mxCell>

  <!-- 図形を後に（前面） -->
  <mxCell id="box1" vertex="1" parent="1">...</mxCell>
</root>
```

### 3. 矢印ラベルの間隔
ラベルは矢印座標から**20px以上**離す:

```xml
<!-- ❌ NG: 10pxしかない -->
<mxCell id="arrow"><mxGeometry><mxPoint y="220" as="sourcePoint"/></mxGeometry></mxCell>
<mxCell id="label"><mxGeometry y="210" width="60" height="20" /></mxCell>

<!-- ✅ OK: 40pxの間隔 -->
<mxCell id="arrow"><mxGeometry><mxPoint y="220" as="sourcePoint"/></mxGeometry></mxCell>
<mxCell id="label"><mxGeometry y="180" width="60" height="20" /></mxCell>
```

### 4. 矢印の接続
テキストへのexitY/entryYは不安定。明示的な座標を使用:

```xml
<!-- ❌ NG -->
<mxCell id="arrow" source="label1" target="label2" style="exitX=0.5;exitY=1;" />

<!-- ✅ OK -->
<mxCell id="arrow" edge="1" parent="1">
  <mxGeometry relative="1" as="geometry">
    <mxPoint x="190" y="300" as="sourcePoint"/>
    <mxPoint x="490" y="300" as="targetPoint"/>
  </mxGeometry>
</mxCell>
```

### 5. フォントサイズ
可読性のため**18px**（標準の1.5倍）を使用。サイズ変更後はPNGで確認し`mxGeometry`を調整。

### 6. 日本語テキストの幅
1文字あたり**30-40px**を確保:

```xml
<!-- ❌ NG: 10文字に200px = 20px/文字 → 改行される -->
<mxCell value="シンプルなフロー図"><mxGeometry width="200" /></mxCell>

<!-- ✅ OK: 10文字に400px = 40px/文字 -->
<mxCell value="シンプルなフロー図"><mxGeometry width="400" /></mxCell>
```

## PNG変換

### セットアップ
```bash
# macOS
brew install --cask drawio

# 変換
drawio -x -f png -s 2 -t -o output.png input.drawio
```

### CLIオプション
- `-x` エクスポートモード
- `-f png` PNG形式
- `-s 2` 2倍スケール（高解像度）
- `-t` 透過背景

### 自動変換 (pre-commit)
`.pre-commit-config.yaml`:
```yaml
repos:
  - repo: local
    hooks:
      - id: convert-drawio-to-png
        name: Convert draw.io to PNG
        entry: bash .github/scripts/convert-drawio-to-png.sh
        language: system
        files: \.drawio$
        pass_filenames: true
```

`.github/scripts/convert-drawio-to-png.sh`:
```bash
#!/bin/bash
set -e
if ! command -v drawio &> /dev/null; then
  echo "Error: drawio CLI not installed."
  exit 1
fi
for drawio in "$@"; do
  png="${drawio}.png"
  drawio -x -f png -s 2 -t -o "$png" "$drawio" 2>/dev/null
  git add "$png"
done
```

## 確認手順
1. PNG生成: `drawio -x -f png -s 2 -t -o /tmp/review.png diagram.drawio`
2. 目視確認: `open /tmp/review.png`
3. Claude CodeでPNGの重なり・はみ出しを確認
4. 修正して繰り返す

## Claude Code用プロンプトテンプレート

```
以下のルールでdraw.io図を作成:

XML構造:
- mxGraphModelにdefaultFontFamily="Noto Sans JP"を設定
- page="0"を設定
- 背景色なし

フォント:
- 全テキスト要素にfontFamily=Noto Sans JP;を追加
- fontSize=18を使用
- 日本語: 1文字30-40px幅を確保

矢印:
- XMLで矢印を図形より前に配置
- ラベルは矢印から20px以上離す
- 明示的な座標を使用（exitY/entryYは不可）

出力:
- .drawioファイルを作成
- 確認用PNGを生成
```

## 品質チェックリスト
- [ ] 全テキストのstyleに`fontFamily`あり
- [ ] フォントサイズ ≥18px
- [ ] XMLで矢印が図形より前
- [ ] 矢印ラベルが20px以上離れている
- [ ] 日本語テキストの幅が十分
- [ ] PNG生成・目視確認済み

## よくある問題

| 問題 | 原因 | 対処 |
|------|------|------|
| フォントが反映されない | `fontFamily`未設定 | 全テキスト要素に追加 |
| 矢印がテキストを覆う | XMLで矢印が図形の後 | 矢印をXML先頭に移動 |
| ラベルが矢印に重なる | 間隔不足 | Y距離を20px以上確保 |
| テキスト折り返し | 幅が狭い | 1文字35pxで計算 |
| テキスト切れ | Geometry未更新 | ボックスサイズを拡大 |
