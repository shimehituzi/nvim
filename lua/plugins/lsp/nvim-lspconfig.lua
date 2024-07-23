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
      ensure_installed = { 'lua_ls', 'tsserver', 'bashls', 'html', 'gopls', 'hls', 'pyright', 'denols' },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local lspconfig = require('lspconfig')

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        local deno_root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json')
        local is_deno_root = deno_root_dir(vim.fn.getcwd()) ~= nil

        local opts = {}

        if server_name == 'tsserver' then
          opts.root_dir = lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json')
          if is_deno_root then opts.single_file_support = false end
        elseif server_name == 'denols' then
          opts.root_dir = deno_root_dir
          opts.init_options = {
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
          }
        elseif server_name == 'pyright' then
          opts.settings = {
            python = {
              venvPath = '.',
              pythonPath = './.venv/bin/python',
              analysis = {
                extraPaths = { '.' },
              },
            },
          }
        elseif server_name == 'lua_ls' then
          opts.settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          }
        end

        opts.capabilities = capabilities

        lspconfig[server_name].setup(opts)
      end,
    })
  end,
}
