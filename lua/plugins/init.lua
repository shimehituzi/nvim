local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' }, { out, 'WarningMsg' } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins.colorscheme' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.lsp' },
  { import = 'plugins.language' },
  { import = 'plugins.llm' },
  { import = 'plugins.complete' },
  { import = 'plugins.context' },
  { import = 'plugins.ui' },
  { import = 'plugins.coding' },
  { import = 'plugins.git' },
  { import = 'plugins.dap' },
  { import = 'plugins.telescope' },
  { import = 'plugins.utils' },
})
