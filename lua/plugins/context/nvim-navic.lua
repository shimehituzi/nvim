return {
  'SmiteshP/nvim-navic',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    require('nvim-navic').setup({
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      click = true,
    })
  end,
}
