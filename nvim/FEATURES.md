# Neovim Configuration Features

## プラグイン一覧

| プラグイン | 役割 | 機能 |
|-----------|------|------|
| **neo-tree.nvim** | ファイルエクスプローラー | ディレクトリツリー表示、隠しファイル表示、ファイル操作 |
| **nvim-hlslens** | 検索UI | 検索結果のハイライト・位置表示 |
| **which-key.nvim** | キーマップ補助 | キーバインド表示・補完 |
| **nvim-scrollbar** | スクロール表示 | 垂直スクロールバー、検索結果位置表示 |
| **diffview.nvim** | Git差分表示 | ファイル差分、コミット履歴の視覚化 |
| **vim-commentary** | コメント操作 | 選択範囲のコメント切替 |
| **vim_current_word** | 単語ハイライト | カーソル下の単語の全体ハイライト |
| **bullets.vim** | リスト補助 | Markdown/テキスト自動箇条書き |
| **vim-indent-guides** | インデント表示 | インデントレベルの視覚化 |
| **vim-fugitive** | Git操作 | Git コマンド実行 |
| **ctrlp.vim** | ファイル検索 | プロジェクト内ファイル・バッファ検索 |
| **bufferline.nvim** | バッファ表示 | 開いているバッファの一覧表示 |

## ショートカットキー一覧

### ファイル操作
| キー | 機能 | 備考 |
|-----|------|------|
| `<Space>e` | ファイルエクスプローラー（Neo-tree）トグル | 左パネルのツリー表示 |
| `<Space>p` | プロジェクト内ファイル検索 | CtrlP - fuzzy search |
| `<Space>b` | 開いているバッファ一覧 | CtrlP - バッファ検索 |
| `<Space>r` | 最近開いたファイル | CtrlP - MRU |

### ウィンドウ移動
| キー | 機能 |
|-----|------|
| `<C-h>` | 左のウィンドウへ移動 |
| `<C-j>` | 下のウィンドウへ移動 |
| `<C-k>` | 上のウィンドウへ移動 |
| `<C-l>` | 右のウィンドウへ移動 |

### 検索
| キー | 機能 | 備考 |
|-----|------|------|
| `<Space>s` | カーソル下の単語を検索 | 全体にハイライト |
| `n` / `N` | 次・前の検索結果へ移動 | hlslens で位置表示 |
| `]s` / `[s` | 次・前の検索結果へ移動 | 別マッピング |
| `<Esc>` | 検索ハイライト解除 | 普通の Esc と同じ |

### 編集
| キー | 機能 | 備考 |
|-----|------|------|
| `<Space>/` | 行・範囲のコメント切替 | vim-commentary 使用 |
| `<Space>i` | インデントガイド表示切替 | vim-indent-guides |
| `<Space>f` | Python コードをフォーマット | Ruff による自動フォーマット |

### Git操作
| キー | 機能 | 備考 |
|-----|------|------|
| `<Space>g` | Git ステータス表示 | vim-fugitive |
| `<Space>gb` | 行の変更履歴を表示 | Git blame |
| `<Space>gc` | コミット作成 | vim-fugitive commit |
| `<Space>gp` | Git push | vim-fugitive push |
| `<Space>gd` | ファイル差分表示 | Diffview - 変更内容の表示 |
| `<Space>gh` | ファイルのコミット履歴 | Diffview - 履歴表示 |
| `<Space>gq` | Diffview を閉じる | - |

### LSP (Python)
| キー | 機能 | 備考 |
|-----|------|------|
| `gd` | 定義へジャンプ | BasedPyright |
| `gr` | 参照一覧を表示 | BasedPyright |
| `K` | ホバー情報を表示 | BasedPyright |
| `<Space>f` | ファイルをフォーマット | Ruff (保存時は自動) |

### ターミナル
| キー | 機能 | 備考 |
|-----|------|------|
| `T` | ターミナルを開く（Normal mode） | 下部に 20 行分のターミナル |
| `<Esc><Esc>` | ターミナルを終了 | Terminal mode のみ |

### バッファ操作
| キー | 機能 | 備考 |
|-----|------|------|
| `]b` | 次のバッファへ移動 | Bufferline サイクル |
| `[b` | 前のバッファへ移動 | Bufferline サイクル |

## 設定概要

- **カラースキーム**: synthwave84
- **キーリーダー**: `<Space>`（スペースキー）
- **表示**: 相対行番号、カーソル行ハイライト、インデントガイド
- **検索**: ignorecase + smartcase で柔軟に検索
- **Python**: BasedPyright（型情報・補完）+ Ruff（フォーマット・linting）
