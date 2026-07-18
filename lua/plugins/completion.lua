-- 補完 (nvim-cmp + Copilot)
--
-- ソース群を本体の dependencies に列挙する方向は公式規定がなく、
-- 「setup が参照するものを先にロードする」ための一般的な慣行に従っている
return {
  -- 補完エンジン本体
  -- ロード: 起動時 / 操作: <C-j> <C-k> <C-f> <C-d> <C-s> <Tab> <S-Tab> → keymaps/cmp.lua
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- 補完ソース
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
            -- スニペットエンジン (nvim-cmp が必須とするもの)
            'L3MON4D3/LuaSnip',
            dependencies = { 'rafamadriz/friendly-snippets' }, -- VSCode 形式スニペット集 (公式 README の例と同方向)
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
      },
      -- 表示・連携
      { 'onsails/lspkind.nvim' }, -- 補完メニューのアイコン整形 (下の formatting で使用)
      { 'zbirenbaum/copilot.lua' }, -- keymaps/cmp.lua が copilot.suggestion を参照する (設定は下の spec)
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

  -- Copilot (インライン提案のみ)
  -- ロード: 起動時 (nvim-cmp の依存として。公式推奨は遅延ロードだが、cmp のキーマップが
  -- ロード済みを前提とするため同時にロードする) / 操作: keymaps/cmp.lua で cmp と統合
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
        -- キー操作は nvim-cmp 側 (keymaps/cmp.lua) で行うため既定マップは無効化
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
