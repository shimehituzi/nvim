return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
  config = function()
    local on_attach = function(client, bufnr)
      local set = vim.keymap.set
      set("n", "<space><space>", "<cmd>lua vim.lsp.buf.hover()<CR>")
      set("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      set("n", "<space>s", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      set("n", "<space>r", "<cmd>lua vim.lsp.buf.references()<CR>")
      set("n", "<space>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
      set("n", "<space>n", "<cmd>lua vim.lsp.buf.rename()<CR>")
      set("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")
      set("n", "<space>[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
      set("n", "<space>]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
    end

    require("mason").setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'tsserver' }
    })
    require("mason-lspconfig").setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities()
        }
      end,
    }
  end
}
