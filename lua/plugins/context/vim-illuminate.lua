return {
  'RRethy/vim-illuminate',
  config = function()
    require('illuminate').configure({
      -- treesitter プロバイダは nvim 0.12 でクラッシュするため外す
      -- (上流も 91313e5 でデフォルトから削除済み)
      providers = {
        'lsp',
        'regex',
      },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
      min_count_to_highlight = 1,
      should_enable = function(bufnr) return true end,
      case_insensitive_regex = false,
    })
    vim.keymap.set('', '<a-i>', '<nop>', { noremap = true })
    vim.keymap.set('', '<a-n>', '<nop>', { noremap = true })
    vim.keymap.set('', '<a-p>', '<nop>', { noremap = true })
  end,
}
