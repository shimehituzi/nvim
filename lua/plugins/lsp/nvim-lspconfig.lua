return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'folke/neodev.nvim',
    },
  },
  config = function()
    local on_attach = function(client, bufnr)
      local set = vim.keymap.set
      set("n", "<space><space>", "<cmd>lua vim.lsp.buf.hover()<CR>")
      set("n", "!", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      set("n", "@", "<cmd>lua vim.lsp.buf.references()<CR>")
      set("n", "#", "<cmd>lua vim.lsp.buf.definition()<CR>")
      set("n", "$", "<cmd>lua vim.lsp.buf.rename()<CR>")
      set("n", "*", "<cmd>lua vim.lsp.buf.format()<CR>")
      set("n", "(", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
      set("n", ")", "<cmd>lua vim.diagnostic.goto_next()<CR>")
      set("n", "0", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    end

    require("neodev").setup()
    require("mason").setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'tsserver' }
    })
    require("mason-lspconfig").setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach,
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
