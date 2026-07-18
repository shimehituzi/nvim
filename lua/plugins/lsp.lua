-- LSP (サーバ管理は mason、バージョンは mason-lock.json とレジストリピンで固定)
--
-- setup は「mason → mason-lspconfig → サーバ設定」の順が必要 (mason-lspconfig 1.x README の要求)。
-- mason.setup は mason 自身の config で行い、lazy.nvim の依存解決でこの順序を保証する
return {
  -- LSP サーバ・CLI ツールのインストーラ
  -- ロード: 起動時 (公式が遅延ロードを非推奨) / 操作: :Mason
  {
    'mason-org/mason.nvim',
    version = '^1.0.0',
    config = function()
      -- サプライチェーン対策: レジストリを「7日以上前のスナップショットリリース」に固定する。
      -- ピンは update.sh が mason-registry-pin.txt に書き込む。これによりバージョン未指定の
      -- :MasonInstall / :Mason の更新もスナップショット時点のバージョンまでしか進まない
      local registry = 'github:mason-org/mason-registry'
      local pin_file = vim.fn.stdpath('config') .. '/mason-registry-pin.txt'
      local f = io.open(pin_file, 'r')
      if f then
        local tag = f:read('*l')
        f:close()
        if tag and tag ~= '' then registry = registry .. '@' .. tag end
      end
      require('mason').setup({ registries = { registry } })
    end,
  },

  -- mason と lspconfig の橋渡し (setup は下の nvim-lspconfig の config 内で行う)
  -- ロード: 起動時 (nvim-lspconfig の依存) / 操作: なし
  {
    'mason-org/mason-lspconfig.nvim',
    version = '^1.0.0',
    dependencies = { 'mason-org/mason.nvim' },
  },

  -- LSP クライアント設定
  -- ロード: 起動時 / 操作: lua/config/keymaps.lua の LSP セクション (; ' 1〜9 { })
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp', -- 補完対応の capabilities を取得するため
      'kyoh86/climbdir.nvim', -- node プロジェクトの root 検出に使用
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'bashls', 'html', 'gopls', 'hls', 'pyright', 'denols', 'rust_analyzer', 'jsonls' },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- root ディレクトリ検出 (vim.lsp.config の root_dir は fn(bufnr, on_dir) 形式)
      local function make_root_dir(finder)
        return function(bufnr, on_dir)
          local root = finder(bufnr)
          if root then on_dir(root) end
        end
      end

      local deno_markers = { 'deno.json', 'deno.lock', 'deno.jsonc', 'deps.ts', 'import_map.json' }

      local function find_deno_root(path) return vim.fs.root(path or 0, deno_markers) end

      local climbdir = require('climbdir')
      local marker = require('climbdir.marker')

      local function find_node_root(path)
        if type(path) == 'number' then path = vim.api.nvim_buf_get_name(path) end
        if not path or path == '' then path = vim.fn.getcwd() end
        return climbdir.climb(path, marker.one_of(marker.has_readable_file('package.json'), marker.has_directory('node_modules')), {
          -- deno プロジェクト内では node root として扱わない (マーカーは deno_markers と同一ソース)
          halt = marker.one_of(unpack(vim.tbl_map(marker.has_readable_file, deno_markers))),
        })
      end

      local deno_root_dir = make_root_dir(find_deno_root)
      local node_root_dir = make_root_dir(find_node_root)
      local is_deno_root = find_deno_root(vim.fn.getcwd()) ~= nil

      -- サーバ固有設定 (ここに無いサーバは capabilities のみ付与される)
      local server_opts = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
            },
          },
        },
        ts_ls = {
          root_dir = node_root_dir,
          init_options = {
            tsserver = {
              -- mason 同梱の typescript 7.x はネイティブ版で tsserver.js を持たず ts_ls が起動不能。
              -- ワークスペースに typescript が無い場合のフォールバックを明示する
              -- (インストール: npm install --prefix ~/.local/share/nvim/ts-fallback typescript@5)
              fallbackPath = vim.fn.expand('~/.local/share/nvim/ts-fallback/node_modules/typescript/lib/tsserver.js'),
            },
          },
        },
        denols = {
          root_dir = deno_root_dir,
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
        },
        pyright = {
          settings = {
            python = {
              venvPath = '.',
              pythonPath = './.venv/bin/python',
              analysis = {
                extraPaths = { '.' },
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          -- deno プロジェクトを cwd とするセッションでは ts_ls を無効化する
          if server_name == 'ts_ls' and is_deno_root then
            vim.lsp.enable(server_name, false)
            return
          end

          local opts = server_opts[server_name] or {}
          opts.capabilities = capabilities
          vim.lsp.config(server_name, opts)
          vim.lsp.enable(server_name)
        end,
      })
    end,
  },

  -- lua_ls に vim ランタイムの型情報を与える
  -- ロード: ft=lua (公式推奨) / 操作: なし
  {
    'folke/lazydev.nvim',
    -- v1.10.0 には「lua_ls の初回設定プルに library が反映されない」バグ (issue #136) があり
    -- Undefined global `vim` が出る。修正コミットに固定 (2026-03-14、クールダウン7日以上経過)
    commit = 'ff2cbcb',
    ft = 'lua',
    opts = {
      library = {
        { path = 'nvim-dap-ui', words = { 'dapui' } },
      },
    },
  },

  -- Mason パッケージのロックファイル
  -- ロード: 起動時 / 操作: :MasonLock / :MasonLockRestore
  {
    'zapling/mason-lock.nvim',
    -- mason.nvim ^1.0.0 の API (コールバック形式の get_installed_version) 対応の最終コミット。
    -- mason を 2.x に上げるときはこの固定を外す
    commit = '86614f7',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json',
    },
  },

  -- mason 経由の CLI ツールインストール (stylua / prettier)
  -- ロード: 起動時 / 操作: なし
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      {
        -- mason-null-ls の必須依存。plenary は none-ls 公式 README が必須と明記
        'nvimtools/none-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
      },
    },
    -- handlers 未指定のため stylua/prettier はインストールされるのみで
    -- none-ls のソースには登録されない (フォーマットは LSP サーバが担う)
    opts = { ensure_installed = { 'stylua', 'prettier' } },
  },
}
