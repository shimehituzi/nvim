-- カラースキーム
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
          scope_color = 'lavender',
        },
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
