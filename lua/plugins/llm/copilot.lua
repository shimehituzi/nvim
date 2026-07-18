return {
  'zbirenbaum/copilot.lua',
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      debounce = 75, -- デフォルト (15ms) より長め
      -- キー操作は nvim-cmp 側 (keymaps/plugins/nvim-cmp.lua) で行うため既定マップは無効化
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
  },
}
