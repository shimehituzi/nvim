return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        'williamboman/mason.nvim',
      },
    },
    { 'folke/neodev.nvim' },
  },
  config = function()
    require("neodev").setup()
    require("mason").setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'tsserver', 'bashls' }
    })
    require("mason-lspconfig").setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = require('keymaps.nvim-lspconfig').on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace"
              }
            }
          }
        }
      end,
    }
  end
}
