-- providers 以外はデフォルト値と同一だったため削除済み
-- (delay=100, filetypes_denylist={'dirbuf','dirvish','fugitive'} 等は固定コミットのデフォルト)
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
    })
    -- プラグイン既定の <a-i>/<a-n>/<a-p> マッピングを潰す
    vim.keymap.set('', '<a-i>', '<nop>')
    vim.keymap.set('', '<a-n>', '<nop>')
    vim.keymap.set('', '<a-p>', '<nop>')
  end,
}
