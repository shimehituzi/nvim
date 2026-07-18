-- デフォルト値と同一の設定は削除済み (固定コミットの init.lua と全項目照合)
-- cmp / gitsigns / illuminate / ufo / treesitter-context / flash 等はデフォルト有効
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'frappe',
      background = {
        light = 'latte',
        dark = 'frappe',
      },
      transparent_background = true,
      integrations = {
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        navic = {
          enabled = true,
          custom_bg = 'NONE',
        },
        notify = true,
        mason = true,
        indent_blankline = {
          enabled = true,
          -- colored_indent_levels は indent-blankline.lua 側の HIGHLIGHT_SETUP フックが
          -- Rainbow* を固定 hex で上書きするため効果がなく削除した
          scope_color = 'lavender',
        },
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
