return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    {
      'nvimtools/none-ls.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      config = true,
    },
  },
  config = function()
    require('mason-null-ls').setup({
      ensure_installed = { 'stylua' },
      automatic_setup = true,
      handlers = {},
    })
  end,
}
