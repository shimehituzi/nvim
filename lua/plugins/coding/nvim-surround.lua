return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  init = function()
    vim.g.nvim_surround_no_mappings = true
  end,
  config = function()
    require('nvim-surround').setup()
  end,
}
