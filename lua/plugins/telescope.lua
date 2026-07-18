-- ファジーファインダ
-- ロード: 起動時 / 操作: <Space> ? " t T とピッカー内キー → lua/config/keymaps.lua
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim', -- 公式 README が必須と明記
    -- 以下は拡張。下の load_extension より先にロードされている必要がある
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-dap.nvim',
      dependencies = { 'mfussenegger/nvim-dap' }, -- 拡張側の必須依存 (設定は plugins/dap.lua)
    },
    'folke/noice.nvim', -- load_extension('noice') のため (設定は plugins/ui.lua)
  },
  config = function()
    local telescope = require('telescope')
    local keymaps = require('config.keymaps').telescope_mappings()

    telescope.setup({
      defaults = {
        mappings = keymaps.defaults,
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            width = 0.9,
            height = 0.9,
            preview_width = 0.6,
            prompt_position = 'top',
          },
        },
      },
      pickers = {
        git_status = {
          mappings = keymaps.defaults,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        file_browser = {
          hijack_netrw = true,
          hide_parent_dir = true,
          grouped = true,
          auto_depth = true,
          display_stat = false,
          mappings = keymaps.file_browser,
        },
      },
    })
    -- 拡張の登録は telescope.setup の後に行う (各拡張の公式 README の要求)。
    -- 上の telescope_mappings() が file_browser 拡張を先行ロードしているが、
    -- ここでの load_extension が実際の設定値で setup し直すため最終状態は正しい
    telescope.load_extension('file_browser')
    telescope.load_extension('ui-select')
    telescope.load_extension('noice')
    telescope.load_extension('dap')
  end,
}
