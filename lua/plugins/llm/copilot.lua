return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup({
      panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_next = false,
          jump_prev = false,
          accept = false,
          refresh = false,
          open = false,
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      filetypes = {
        markdown = true,
        yaml = true,
      },
    })
  end,
}
