return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup({
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_next = '<C-j>',
          jump_prev = '<C-k>',
          accept = '<cr>',
          refresh = '<C-s>',
          open = '<C-s>',
        },
        layout = {
          position = "right",
          ratio = 0.4
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
    })
  end,
}
