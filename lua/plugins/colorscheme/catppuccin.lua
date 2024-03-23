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
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        illuminate = true,
        symbols_outline = true,
        ufo = true,
        treesitter_context = true,
        navic = {
          enabled = true,
          custom_bg = 'NONE',
        },
        noice = true,
        mason = true,
        flash = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
          scope_color = 'lavender',
        },
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
