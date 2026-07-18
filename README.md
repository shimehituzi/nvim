# Neovim キーマップリファレンス

## 基本操作

### 移動 (Normal / Visual / Operator-pending)

| キー | 動作 |
|------|------|
| `j` / `k` | 表示行単位で上下移動 |
| `H` | 行頭 (`^`) |
| `L` | 行末 (`$`) |
| `Ctrl-f` | 半ページ下 |
| `Ctrl-d` | 半ページ上 |

### 1文字検索 (leap.nvim)

| キー | モード | 動作 |
|------|--------|------|
| `f` / `F` | Normal / Visual / Operator-pending | 前方/後方への1文字検索 (同キー連打でリピート) |
| `t` / `T` | Visual / Operator-pending のみ | 直前/直後への1文字検索 (Normal の t/T は Telescope/Noice に割当済み) |

### ファイル・バッファ・ウィンドウ (Normal)

| キー | 動作 |
|------|------|
| `Enter` | 保存 (`:w`) |
| `q` | バッファを閉じる (`:bw`) |
| `Ctrl-q` | 終了 (`:q`) |
| `Shift-q` | サスペンド (`Ctrl-z`) |
| `Ctrl-l` | 次のウィンドウへ |
| `Ctrl-h` | 前のウィンドウへ |
| `Ctrl-e` | ファイル再読み込み (`:e`) |
| `~` | 現在のウィンドウのみ表示 (`:only`) |
| `Ctrl-Shift-↑↓←→` | ウィンドウ間移動 |
| `Ctrl-j` / `Ctrl-k` | 次/前のバッファタブ |

### 編集 (Normal)

| キー | 動作 |
|------|------|
| `Ctrl-p` | ペースト (カーソルを末尾へ) |
| `X` | 行結合 (`J`) |
| `Ctrl-o` | 下に空行を追加 |
| `x` | 削除 (レジスタに入れない) |
| `s` | 置換 (レジスタに入れない) |
| `+` | 大文字小文字トグル (`~`) |
| `n` / `N` | 次/前の検索結果 (中央寄せ) |

### マクロ (Normal)

| キー | 動作 |
|------|------|
| `M` | マクロ記録開始 (`q`) |
| `m` | マクロ実行 (`@`) |

### ジャンプ (Normal)

| キー | 動作 |
|------|------|
| `BS` | 前の位置に戻る (`Ctrl-o`) |
| `Shift-BS` | 次の位置に進む (`Ctrl-i`) |

### 行移動・選択 (Normal / Visual)

| キー | Normal | Visual |
|------|--------|--------|
| `Shift-↑` | 行選択して上へ | 選択範囲を上へ拡張 |
| `Shift-↓` | 行選択して下へ | 選択範囲を下へ拡張 |
| `Shift-←` | 行を上に移動 | 選択行を上に移動 |
| `Shift-→` | 行を下に移動 | 選択行を下に移動 |

### その他 (Normal)

| キー | 動作 |
|------|------|
| `` ` `` | 検索ハイライトをクリア |
| `0` | 無効化 (`01`〜`09` で数字入力可) |

### Visual モード

| キー | 動作 |
|------|------|
| `Ctrl-y` | ヤンク (カーソルを末尾へ) |
| `Enter` | 日本語に翻訳 |

### Insert モード

| キー | 動作 |
|------|------|
| `Ctrl-h` | 左に移動 |
| `Ctrl-l` | 右に移動 |
| `Ctrl-e` | 行末に移動 |
| `Ctrl-t` | インデント |

### テキストオブジェクト (Visual / Operator-pending)

| キー | 対象 |
|------|------|
| `aa` / `ia` | `<>` (angle brackets) |
| `as` / `is` | `[]` (square brackets) |
| `ad` / `id` | `""` (double quotes) |

## LSP

| キー | 動作 |
|------|------|
| `;` | ホバー情報 |
| `'` | フォーマット |
| `1` | コードアクション |
| `2` | リネーム |
| `3` | 定義へ移動 |
| `4` | 参照一覧 |
| `5` | 実装へ移動 |
| `6` | 発信呼び出し一覧 |
| `7` | 着信呼び出し一覧 |
| `8` | ドキュメントシンボル一覧 |
| `9` | 診断一覧 |
| `}` | 次の診断へ |
| `{` | 前の診断へ |

> `1`〜`9` は `nummap` で定義されており、カウント未入力の状態で押すと LSP 機能が発動します（例: 素の `3` で定義へ移動）。カウント入力中は通常の数字として動くため、カウントは `01`〜`09` で開始してください（例: `03j` で3行下へ移動）。

## Telescope / 検索

| キー | 動作 |
|------|------|
| `Space` | ファイルブラウザ |
| `?` | バッファ内ファジー検索 |
| `"` | Live grep |
| `t` | Telescope builtin 一覧 |
| `T` | Noice メッセージ一覧 |

### Telescope 共通操作 (Insert モード)

| キー | 動作 |
|------|------|
| `Esc` / `Ctrl-q` | 閉じる |
| `Enter` | 選択 |
| `Tab` | 選択して resume |
| `Ctrl-j` / `Ctrl-k` | 次/前の候補 |
| `↑` / `↓` | プレビューをスクロール |

### File Browser 操作 (Insert モード)

| キー | 動作 |
|------|------|
| `Ctrl-h` | 親ディレクトリへ |
| `Ctrl-l` | 選択 (ディレクトリに入る) |
| `BS` | バックスペース |
| `Ctrl-s` | 選択トグル |
| `Ctrl-a` | 新規作成 |
| `Ctrl-r` | リネーム |
| `Ctrl-p` | 移動 |
| `Ctrl-c` | コピー |
| `Ctrl-d` | 削除 |
| `Ctrl-o` | 開く |
| `Ctrl-f` | ファイル/ディレクトリ切り替え |
| `Ctrl-z` | 隠しファイル表示トグル |
| `Ctrl-x` | gitignore 表示トグル |

## Git (Gitsigns)

| キー | 動作 |
|------|------|
| `↓` | 次のハンクへ |
| `↑` | 前のハンクへ |
| `→` | ハンクをステージ |
| `←` | ハンクをプレビュー |
| `U` | ステージを取り消し |
| `Ctrl-u` | ハンクをリセット |
| `ih` | ハンクテキストオブジェクト (Visual/Operator-pending) |

## 補完 (nvim-cmp / Copilot)

Insert / Command モードでの動作:

| キー | 動作 |
|------|------|
| `Ctrl-j` | 次の候補 / Copilot 次候補 / 補完開始 |
| `Ctrl-k` | 前の候補 / Copilot 前候補 / 補完開始 |
| `Ctrl-f` | 確定 / Copilot 受け入れ |
| `Ctrl-d` | 中止 / Copilot 却下 / Copilot 次候補 |
| `Ctrl-s` | Copilot 自動トリガー切り替え (Insert のみ) |
| `Tab` | LuaSnip ジャンプ (次) / 次の候補 |
| `Shift-Tab` | LuaSnip ジャンプ (前) / 前の候補 |

## コメント / サラウンド

| キー | モード | 動作 |
|------|--------|------|
| `,` | Normal | コメント切り替え (行) |
| `,` | Visual | コメント切り替え (選択範囲) |
| `S` | Normal | 行全体をサラウンド |
| `S` | Visual | 選択範囲をサラウンド |
| `ys{motion}` | Normal | サラウンド追加 |
| `cs` | Normal | サラウンド変更 |
| `ds` | Normal | サラウンド削除 |

## vim-illuminate

| キー | 動作 |
|------|------|
| `J` | 次の参照へ |
| `K` | 前の参照へ |
| `Space` | 参照をテキストオブジェクトとして選択 (Visual/Operator-pending) |

## DAP (デバッグ)

| キー | 動作 |
|------|------|
| `-` | ブレークポイント切り替え |
| `_` | 続行 (continue) |
| `*` | ステップオーバー |
| `(` | ステップアウト |
| `)` | ステップイン |
| `^` | 終了 (terminate) |
| `&` | 再起動 (restart) |
| `!` | 式を評価 (eval) |
| `%` | DAP UI トグル |
| `@` | DAP コマンド一覧 |
| `#` | フレーム一覧 |
| `$` | ブレークポイント一覧 |

## Avante (LLM)

| キー | モード | 動作 |
|------|--------|------|
| `Tab` | Normal | Avante にフォーカス |
| `Tab` | Visual | 選択範囲について質問 |
| `Shift-Tab` | Normal | モデル選択 |
| `Shift-Tab` | Visual | 選択範囲を編集 |
| `Del` | Normal | 履歴を開く |
| `Shift-Del` | Normal | 履歴とキャッシュをクリア |
| `Ctrl-c` | Normal | 停止 |

### Avante サイドバー・diff 内 (lua/config/keymaps/avante.lua)

| キー | 動作 |
|------|------|
| `1`〜`5` | diff の競合解決 (ours/theirs/cursor/all theirs/both) |
| `J` / `K` | 次/前 (diff・ジャンプ共通) |
| `Enter` / `Alt-Enter` | 送信 (Normal / Insert) |
| `Ctrl-j` / `Ctrl-k` | サイドバー内ウィンドウ切替 |
| `A` / `a` | 全て適用 / カーソル位置を適用 |
| `r` / `e` | リクエスト再試行 / 編集 |
| `a` / `d` | ファイル追加 / 削除 (ファイルリスト) |
| `Ctrl-t` | 現在のファイルを追加 |
| `q` | 閉じる |

## その他

| キー | 動作 |
|------|------|
| `\|` | インデントガイド表示切り替え (IBLToggle) |

## Quickfix (ftplugin)

| キー | 動作 |
|------|------|
| `Enter` | 項目へジャンプ (グローバルの保存マップを上書きして復元) |

## Go ファイル (ftplugin)

| キー | 動作 |
|------|------|
| `<leader>t` | カーソル下のテストをデバッグ |
| `<leader>T` | 最後のテストを再デバッグ |

> leader キーは未設定のためデフォルトの `\` です。

## 無効化されたキー (Normal)

以下のキーは NOP に設定されており、押すと未割当キーの一覧が表示されます:

`Ctrl-b`, `Ctrl-n`, `Ctrl-s`, `Ctrl-y`, `Ctrl-z`

## 設定ファイルの構成

| パス | 役割 |
|------|------|
| `init.lua` | `lua/config/` を読み込むだけ |
| `lua/config/init.lua` | 読み込み順の一元管理 (options → plugins → keymaps → autocmds) |
| `lua/config/keymaps/init.lua` | **グローバルキーマップの唯一の定義場所** (このリファレンスの実体) |
| `lua/config/keymaps/{telescope,cmp,gitsigns,avante}.lua` | プラグインに渡すキーテーブル (ピッカー内・補完・ハンク操作・Avante サイドバー) |
| `lua/config/keymaps/{actions,leap}.lua` | 複数行になるキーマップアクションの実体 (init.lua から参照) |
| `lua/config/options.lua` / `autocmds.lua` / `lazy.lua` / `util.lua` | オプション / autocmd / lazy.nvim / ヘルパ |
| `lua/plugins/*.lua` | プラグイン定義 (1カテゴリ = 1ファイル、計11) |
| `ftplugin/*.lua` | ファイルタイプ固有設定 (buffer-local) |

### プラグイン定義の読み方

`lua/plugins/` の各 spec には次の2行ヘッダが付いています:

- **ロード**: いつロードされるか (起動時 / VeryLazy / InsertEnter / ft=... )。公式推奨がある場合はその旨を明記
- **操作**: ユーザが使うキー・コマンドと、その定義場所 (キーマップは全て `lua/config/keymaps/` にあり、spec 側には書かない)

依存 (`dependencies`) には「公式 README が必須とするもの」と「この設定での用途上必要なもの」だけを、理由コメント付きで列挙しています。
