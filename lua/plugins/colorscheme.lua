-- カラースキーム
-- ロード: 起動時・最優先 (priority = 1000 は公式推奨) / 操作: なし
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  -- setup はカラースキーム適用より前に必要 (公式 README の要求) のため config でまとめて行う
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
