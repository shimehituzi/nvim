return {
  'jay-babu/mason-null-ls.nvim',
  dependencies = {
    'mason-org/mason.nvim',
    {
      'nvimtools/none-ls.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      config = true,
    },
  },
  -- 注意: handlers 未指定のため stylua/prettier は mason でインストールされるだけで
  -- none-ls のソースとしては登録されない (フォーマットは LSP サーバに任せる現状の挙動)
  opts = { ensure_installed = { 'stylua', 'prettier' } },
}
