# .config/nvim の変更


2019/07/14
-----------------------------------------------------------------

### mapping
- `<CR>` でセーブ
- `<C-_>` でバッファを破棄
- `-` でカーソルしたの文字を検索
- `_` でカーソルしたの文字を含む文字列を検索
- `+` で `ysiW`
- `++` で `ysiw<space><space>`
- Denite の `<space><space>` でバッファ移動
- Denite の `<space>jl` でレジスタ一覧
- Denite の `<space>jj` 直前の Denite バッファを開く
- Denite の `<space>jh` でヘルプ
- `^` で `zt10<C-y>`

### markdown 関連
- previm, open-browser.vim をリストラ
- colorscheme を deus でなく lucario っぽくした soloarized に設定
- syntax などの vim 側の設定を `plasticboy/vim-markdown` で行うことにした．
- markdown のプレビューを `iamcco/markdown-preview.nvim` で行うことにした．
- markdwon ファイルを開いた瞬間にプレビューを行う設定に変更した．
- プレビューのトグルを `@` にマッピングした．

### その他
- Deol をリストラ
- Surround.vim の繰り返しを行える `tpope/vim-repeat` を追加
