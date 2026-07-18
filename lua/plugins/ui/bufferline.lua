-- デフォルト値と同一の設定は削除済み (固定コミットの config.lua と全項目照合)
return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      close_command = 'bwipeout! %d',
      right_mouse_command = 'bwipeout! %d',
      buffer_close_icon = '󰅖',
      close_icon = '',
      diagnostics = 'nvim_lsp',
      diagnostics_update_in_insert = false,
      custom_filter = function(buf_number) return vim.bo[buf_number].filetype ~= 'qf' end,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
      sort_by = 'insert_after_current',
    },
  },
}
