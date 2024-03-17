return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup({
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '<up>',
          jump_next = '<down>',
          accept = '<left>',
          refresh = '<right>',
          open = '<C-g>',
        },
        layout = {
          position = "right", -- | top | left | right
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
