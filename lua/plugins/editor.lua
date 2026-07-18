-- 編集支援 (モーション・サラウンド・コメント・参照ハイライト・折りたたみ)
return {
  -- f/F/t/T の1文字検索 (キーマップは lua/config/keymaps/init.lua)
  {
    url = 'https://codeberg.org/andyg/leap.nvim',
    name = 'leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
  },

  -- サラウンド操作 (S / ys / cs / ds)
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    init = function() vim.g.nvim_surround_no_mappings = true end,
    opts = {},
  },

  -- コメントトグル (,)
  {
    'numToStr/Comment.nvim',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },

  -- カーソル下の単語の参照ハイライト (J/K で移動)
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        -- treesitter プロバイダは nvim 0.12 でクラッシュするため外す
        providers = {
          'lsp',
          'regex',
        },
      })
    end,
  },

  -- 折りたたみ (LSP の foldingRange を使用)
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    -- filetype_exclude は ufo 本体のオプションではなく、下の autocmd 用の独自キー
    opts = {
      filetype_exclude = { 'help', 'lazy', 'mason', 'qf' },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_detach_ufo', { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function() require('ufo').detach() end,
      })

      require('ufo').setup(opts)
    end,
  },
}
