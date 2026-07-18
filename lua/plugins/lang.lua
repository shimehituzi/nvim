-- 言語ツール・ファイルタイプ固有のプラグイン
return {
  -- 翻訳 (デフォルトの Google エンジン。外部依存: curl)
  -- ロード: 起動時 / 操作: Visual <CR> で :Translate ja → lua/config/keymaps.lua
  {
    'uga-rosa/translate.nvim',
    opts = {},
  },

  -- Markdown / Avante バッファのリッチ表示
  -- ロード: ft=markdown/Avante (avante の依存でもある) / 操作: なし (自動適用)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- markdown パーサの提供元 (公式インストール例どおり)
    opts = {
      file_types = { 'markdown', 'Avante' },
      completions = { lsp = { enabled = true } },
      code = {
        border = 'thin',
      },
    },
    ft = { 'markdown', 'Avante' },
  },
}
