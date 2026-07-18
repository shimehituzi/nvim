-- デフォルト値と同一の設定は削除済み (固定コミットの config.lua と照合)
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        globalstatus = true,
        disabled_filetypes = {
          winbar = { '', 'help', 'text', 'Avante', 'AvanteInput', 'AvanteSelectedFiles' },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filetype' },
        lualine_x = {
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
          },
          { 'fileformat', symbols = { unix = ' ', dos = '', mac = 'old ' } },
          'encoding',
        },
        lualine_y = { 'searchcount', 'progress' },
        lualine_z = { 'selectioncount', 'location' },
      },
      -- 非アクティブウィンドウにはステータスライン内容を出さない (デフォルトは filename 等が出る)
      inactive_sections = {},
      winbar = {
        lualine_c = { 'filename', 'navic' },
      },
    })
  end,
}
