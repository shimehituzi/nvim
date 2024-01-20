return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = { 'neo-tree', 'help', 'DiffviewFiles', 'DiffviewFileHistory' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filetype' },
        lualine_x = { { 'fileformat', symbols = { unix = ' ', dos = '', mac = 'old ' } }, 'encoding' },
        lualine_y = { 'searchcount', 'progress' },
        lualine_z = { 'selectioncount', 'location' },
      },
      inactive_sections = {},
      tabline = {},
      winbar = {
        lualine_c = { 'filename', { 'navic', color_correction = nil } },
      },
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
