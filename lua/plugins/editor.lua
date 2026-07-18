-- 編集支援 (モーション・サラウンド・コメント・参照ハイライト・折りたたみ)
return {
  -- f/F/t/T の1文字検索
  -- ロード: 起動時 (公式が「自前で遅延するので遅延ロード不要」と明言) / 操作: f F t T → lua/config/keymaps.lua
  {
    url = 'https://codeberg.org/andyg/leap.nvim',
    name = 'leap.nvim',
    dependencies = { 'tpope/vim-repeat' }, -- 公式では任意 (dot-repeat 用)
  },

  -- サラウンド操作
  -- ロード: VeryLazy (公式推奨) / 操作: S ys cs ds → lua/config/keymaps.lua
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    -- 既定マップの無効化フラグ (README には無いが plugin/nvim-surround.lua が参照する)
    init = function() vim.g.nvim_surround_no_mappings = true end,
    opts = {},
  },

  -- コメントトグル
  -- ロード: 起動時 / 操作: , → lua/config/keymaps.lua
  {
    'numToStr/Comment.nvim',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring', -- pre_hook で使用 (tsx/jsx の文脈対応)
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

  -- カーソル下の単語の参照ハイライト
  -- ロード: 起動時 / 操作: J K で参照間移動 → lua/config/keymaps.lua
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
  -- ロード: 起動時 / 操作: 標準の z 系キー (foldcolumn 等は公式の要求どおり options.lua で setup 前に設定済み)
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' }, -- 公式 README が必須と明記
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
