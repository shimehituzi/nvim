# Neovim 設定

## キーマップ

キーマップの唯一の定義は [lua/config/keymaps.lua](lua/config/keymaps.lua)。全キーが同じ書式の一覧に日本語の説明 (`desc`) 付きで並んでいる。

- `<C-b>` — which-key で現在のモードのキーマップ一覧を表示する
- この README には対照表を置かない (定義とドキュメントの二重管理を避けるため)

## 設定ファイルの構成

| パス | 役割 |
|------|------|
| `init.lua` | `lua/config/` を読み込むだけ |
| `lua/config/init.lua` | 読み込み順の一元管理 (options → plugins → keymaps → autocmds) |
| `lua/config/keymaps.lua` | **全キーマップの唯一の定義ファイル** (一覧と、各プラグインへの変換) |
| `lua/config/actions.lua` | キーマップ動作の実装 |
| `lua/config/options.lua` / `autocmds.lua` / `lazy.lua` / `util.lua` | オプション / autocmd / lazy.nvim / ヘルパ |
| `lua/plugins/*.lua` | プラグイン定義 (1カテゴリ = 1ファイル、計11) |
| `ftplugin/*.lua` | ファイルタイプ固有設定 (buffer-local) |

## プラグイン定義の読み方

`lua/plugins/` の各 spec には次の2行ヘッダが付いている:

- **ロード**: いつロードされるか (起動時 / VeryLazy / InsertEnter / ft=... )。公式推奨がある場合はその旨を明記
- **操作**: ユーザが使うキー・コマンド (キーマップは全て `lua/config/keymaps.lua` にあり、spec 側には書かない)

依存 (`dependencies`) には「公式 README が必須とするもの」と「この設定での用途上必要なもの」だけを、理由コメント付きで列挙している。
