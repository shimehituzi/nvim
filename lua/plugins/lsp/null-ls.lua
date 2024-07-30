return {
  'jay-babu/mason-null-ls.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    {
      'nvimtools/none-ls.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      config = true,
    },
  },
  config = function()
    local null_ls = require('null-ls')
    local prettier_configs = vim.tbl_map(
      function(ext) return '.prettierrc' .. ext end,
      { '', '.js', '.cjs', '.json', '.json5', '.yml', '.yaml', '.toml' }
    ) or {}
    table.insert(prettier_configs, 'prettier.config.js')
    table.insert(prettier_configs, 'prettier.config.cjs')

    require('mason-null-ls').setup({
      ensure_installed = { 'stylua', 'black', 'prettier' },
      handlers = {
        prettier = function(source_name, methods)
          null_ls.register(null_ls.builtins.formatting.prettier.with({
            condition = function(utils) return utils.has_file(prettier_configs) end,
          }))
        end,
      },
    })
  end,
}
