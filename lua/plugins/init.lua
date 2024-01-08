local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.colorscheme" },
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.complete" },
  { import = "plugins.context" },
  { import = "plugins.ui" },
  { import = "plugins.coding" },
  { import = "plugins.git" },
})
