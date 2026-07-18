-- Avante サイドバー・diff 内のキー定義 (avante.setup の mappings に渡す)
-- グローバルの Avante キー (<Tab> 等) は lua/config/keymaps/init.lua の LLM セクションにある
return {
  mappings = {
    diff = {
      ours = '1',
      theirs = '2',
      cursor = '3',
      all_theirs = '4',
      both = '5',
      next = 'J',
      prev = 'K',
    },
    jump = {
      next = 'J',
      prev = 'K',
    },
    submit = {
      normal = '<CR>',
      insert = '<M-CR>',
    },
    sidebar = {
      switch_windows = '<C-j>',
      reverse_switch_windows = '<C-k>',
      apply_all = 'A',
      apply_cursor = 'a',
      retry_user_request = 'r',
      edit_user_request = 'e',
      add_file = 'a',
      remove_file = 'd',
      close = { 'q' },
    },
    files = {
      add_current = '<C-t>',
    },
  },
}
