return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    {
      'saadparwaiz1/cmp_luasnip',
      dependencies = {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
      },
    },
    {
      'zbirenbaum/copilot-cmp',
      dependencies = 'zbirenbaum/copilot.lua',
      config = function() require('copilot_cmp').setup() end,
    },
    { 'onsails/lspkind.nvim' },
  },
  config = function()
    local lspkind = require('lspkind')
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
      },
      mapping = require('keymaps.plugins.nvim-cmp').mapping,
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      }),
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Copilot = '' },
        }),
      },
    })

    cmp.setup.cmdline('/', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
