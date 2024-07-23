return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        'williamboman/mason.nvim',
      },
    },
    {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup({
          library = { plugins = { 'nvim-dap-ui' }, types = true },
        })
      end,
    },
    { 'kevinhwang91/nvim-ufo' },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'tsserver', 'bashls', 'html', 'eslint', 'gopls', 'hls', 'pyright', 'denols' },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        local lspconfig = require('lspconfig')
        if server_name == 'denols' then
          lspconfig['denols'].setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('deno.json'),
            init_options = {
              lint = true,
              unstable = true,
              suggest = {
                imports = {
                  hosts = {
                    ['https://deno.land'] = true,
                    ['https://cdn.nest.land'] = true,
                    ['https://crux.land'] = true,
                  },
                },
              },
            },
          })
        elseif server_name == 'tsserver' then
          lspconfig['tsserver'].setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('package.json'),
          })
        elseif server_name == 'pyright' then
          lspconfig['pyright'].setup({
            capabilities = capabilities,
            settings = {
              python = {
                venvPath = '.',
                pythonPath = './.venv/bin/python',
                analysis = {
                  extraPaths = { '.' },
                },
              },
            },
          })
        elseif server_name == 'lua_ls' then
          lspconfig['lua_ls'].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
              },
            },
          })
        else
          lspconfig[server_name].setup({
            capabilities = capabilities,
            settings = settings,
          })
        end
      end,
    })
  end,
}
