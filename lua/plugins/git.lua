-- Git 連携
-- ロード: 起動時 / 操作: <Up> <Down> <Right> <Left> U <C-u> ih → lua/config/keymaps.lua (バッファ attach 時に設定)
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = require('config.keymaps').gitsigns_on_attach,
  },
}
