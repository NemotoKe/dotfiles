# dotfiles

## テーマ生成

配色の source of truth は [`theme/colors.json`](theme/colors.json) です。リポジトリのルートで次を実行すると、Ghostty、Chrome、GitHub の生成物を更新できます。

```sh
python3 scripts/generate-theme.py
```

`scripts/apply.sh` でも既存の dotfiles 適用前に同じ生成処理が実行されます。

## Chrome theme

1. Chrome で `chrome://extensions` を開く。
2. Developer mode を有効にする。
3. **Load unpacked** を選び、このリポジトリの `chrome/` ディレクトリを指定する。

## GitHub extension

1. Chrome で `chrome://extensions` を開く。
2. Developer mode を有効にする。
3. **Load unpacked** を選び、このリポジトリの `github/` ディレクトリを指定する。
4. GitHub のページを再読み込みする。

この extension の content script の対象は `https://github.com/*` のみです。

## 色を変更したとき

1. `theme/colors.json` を編集する。
2. `python3 scripts/generate-theme.py` を実行する。
3. 生成された差分を確認してから、必要に応じて `scripts/apply.sh` を実行する。

生成物（`ghostty/themes/coolnight`、`chrome/manifest.json`、`github/manifest.json`、`github/github.css`）は直接編集しません。GitHub のセレクタ構造を変更する場合だけ `github/github.css.template` を編集します。`backup.sh` も source of truth で管理する Ghostty テーマを上書きしないようにしています。
