return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "mason-org/mason.nvim",           version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    {
      -- neodev.nvim は開発終了。後継の lazydev.nvim に移行
      -- (lua_ls に vim ランタイムの型情報を与え、Undefined global 'vim' を解消する)
      'folke/lazydev.nvim',
      version = 'v1.10.0', -- 安定版に固定 (2025-10-23 リリース)
      ft = 'lua',
      opts = {
        library = {
          { path = 'nvim-dap-ui', words = { 'dapui' } },
        },
      },
    },
    { 'kevinhwang91/nvim-ufo' },
    { 'kyoh86/climbdir.nvim' },
  },
  config = function()
    -- サプライチェーン対策: レジストリを「7日以上前のスナップショットリリース」に固定する。
    -- ピンは update.sh が .config/nvim/mason-registry-pin.txt に書き込む。
    -- これによりバージョン未指定の MasonInstall / :Mason の更新も
    -- スナップショット時点のバージョンまでしか進まない
    local mason_registry = 'github:mason-org/mason-registry'
    local pin_file = vim.fn.stdpath('config') .. '/mason-registry-pin.txt'
    local f = io.open(pin_file, 'r')
    if f then
      local tag = f:read('*l')
      f:close()
      if tag and tag ~= '' then
        mason_registry = mason_registry .. '@' .. tag
      end
    end
    require('mason').setup({ registries = { mason_registry } })
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'ts_ls', 'bashls', 'html', 'gopls', 'hls', 'pyright', 'denols', 'rust_analyzer', 'jsonls' },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local function make_root_dir(finder)
      return function(path, on_dir)
        local root = finder(path)
        if type(on_dir) == 'function' then
          if root then on_dir(root) end
        else
          return root
        end
      end
    end

    local deno_markers = { 'deno.json', 'deno.lock', 'deno.jsonc', 'deps.ts', 'import_map.json' }

    local function find_deno_root(path)
      return vim.fs.root(path or 0, deno_markers)
    end

    local climbdir = require('climbdir')
    local marker = require('climbdir.marker')

    local function find_node_root(path)
      if type(path) == 'number' then
        path = vim.api.nvim_buf_get_name(path)
      end
      if not path or path == '' then
        path = vim.fn.getcwd()
      end
      return climbdir.climb(path,
        marker.one_of(marker.has_readable_file('package.json'), marker.has_directory('node_modules')), {
          halt = marker.one_of(
            marker.has_readable_file('deno.json'),
            marker.has_readable_file('deno.jsonc'),
            marker.has_readable_file('deps.ts'),
            marker.has_readable_file('import_map.json')
          ),
        })
    end

    local deno_root_dir = make_root_dir(find_deno_root)
    local node_root_dir = make_root_dir(find_node_root)
    local is_deno_root = find_deno_root(vim.fn.getcwd()) ~= nil

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        local opts = {}
        local disable = false

        if server_name == 'rust_analyzer' then
          opts.settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          }
        elseif server_name == 'ts_ls' then
          if is_deno_root then
            disable = true
          else
            opts.root_dir = node_root_dir
          end
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

        if disable then
          vim.lsp.enable(server_name, false)
          return
        end

        vim.lsp.config(server_name, opts)

        if not vim.lsp.is_enabled(server_name) then
          vim.lsp.enable(server_name)
        end
      end,
    })
  end,
}
