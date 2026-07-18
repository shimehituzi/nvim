-- 言語ツール・ファイルタイプ固有のプラグイン
return {
  -- 翻訳 (Visual <CR> で :Translate ja)
  {
    'uga-rosa/translate.nvim',
    opts = {},
  },

  -- Markdown / Avante バッファのリッチ表示
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
