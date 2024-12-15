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
    { 'kyoh86/climbdir.nvim' },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'ts_ls', 'bashls', 'html', 'gopls', 'hls', 'pyright', 'denols', 'rust_analyzer' },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local lspconfig = require('lspconfig')

    local deno_root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json')
    local node_root_dir = function(path)
      local marker = require('climbdir.marker')
      return require('climbdir').climb(path,
        marker.one_of(marker.has_readable_file('package.json'), marker.has_directory('node_modules')), {
          halt = marker.one_of(
            marker.has_readable_file('deno.json'),
            marker.has_readable_file('deno.jsonc'),
            marker.has_readable_file('deps.ts'),
            marker.has_readable_file('import_map.json')
          ),
        })
    end
    local is_deno_root = deno_root_dir(vim.fn.getcwd()) ~= nil

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        local opts = {}

        if server_name == 'rust_analyzer' then
          opts.settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          }
        elseif server_name == 'ts_ls' then
          opts.root_dir = node_root_dir
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
