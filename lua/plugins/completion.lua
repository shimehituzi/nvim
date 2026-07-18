-- 補完 (nvim-cmp + Copilot。キー操作は lua/config/keymaps/cmp.lua)
return {
  {
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
          -- フラットなテーブルに spec キーを混在させると依存追加時に壊れるため明示的にネスト
          {
            'L3MON4D3/LuaSnip',
            dependencies = { 'rafamadriz/friendly-snippets' },
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
      },
      { 'onsails/lspkind.nvim' },
      { 'zbirenbaum/copilot.lua' },
    },
    config = function()
      local lspkind = require('lspkind')
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = require('config.keymaps.cmp').mapping,
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
  },

  -- Copilot (インライン提案のみ。キー操作は cmp 側で束ねる)
  {
    'zbirenbaum/copilot.lua',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75, -- デフォルト (15ms) より長め
        -- キー操作は nvim-cmp 側 (lua/config/keymaps/cmp.lua) で行うため既定マップは無効化
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      filetypes = {
        markdown = true,
        yaml = true,
      },
    },
  },
}
