-- デフォルト値と同一の設定は削除済み (固定コミットの config.lua と全項目照合)
-- signs はデフォルト (┃ ▁ ▔) と異なる文字を使っているため残している
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
    -- current_line_blame は無効のまま (フォーマッタはデフォルトと空白の有無が違うため保持)
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    preview_config = {
      border = 'single', -- border 以外はデフォルトと同一
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = require('keymaps.plugins.gitsigns').on_attach,
  },
}
