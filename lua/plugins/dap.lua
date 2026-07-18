-- デバッグ (DAP)
return {
  -- DAP クライアント本体
  -- ロード: 起動時 / 操作: - _ * ( ) ^ & → keymaps/init.lua
  {
    'mfussenegger/nvim-dap',
    version = '*',
  },

  -- デバッグ UI
  -- ロード: 起動時 / 操作: ! % → keymaps/init.lua (セッション開始・終了で自動開閉)
  {
    'rcarriga/nvim-dap-ui',
    -- v4.0.0 タグにも vim.tbl_flatten が残っているため、修正済みの master に
    -- コミット固定 (クールダウン方針: 7日以上前のコミット、2026-07-08 時点)
    commit = '1a66caba',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }, -- 両方とも公式 README が必須と明記
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },

  -- 変数の値をインライン表示
  -- ロード: 起動時 / 操作: なし (デバッグ中に自動表示)
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' }, -- 公式 README が必須と明記
    opts = {},
  },

  -- Go 用アダプタ (外部依存: dlv)
  -- ロード: ft=go / 操作: <leader>t <leader>T → ftplugin/go.lua
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = { 'mfussenegger/nvim-dap' }, -- 公式 README が必須と明記
    config = function()
      require('dap-go').setup()
      local dap = require('dap')

      dap.adapters.go = function(callback, config)
        local stdout = vim.uv.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
          stdio = { nil, stdout },
          args = { 'dap', '-l', '127.0.0.1:' .. port },
          detached = true,
        }
        handle, pid_or_err = vim.uv.spawn('dlv', opts, function(code)
          stdout:close()
          handle:close()
          if code ~= 0 then print('dlv exited with code', code) end
        end)
        assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
          assert(not err, err)
          if chunk then vim.schedule(function() require('dap.repl').append(chunk) end) end
        end)
        -- Wait for delve to start
        vim.defer_fn(function() callback({ type = 'server', host = '127.0.0.1', port = port }) end, 100)
      end

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug the golang',
          request = 'launch',
          program = '${file}',
        },
        {
          type = 'go',
          name = 'Debug the golang test',
          request = 'launch',
          mode = 'test',
          program = '${file}',
        },
        {
          type = 'go',
          name = 'Debug test (go.mod)',
          request = 'launch',
          mode = 'test',
          program = './${relativeFileDirname}',
        },
      }
    end,
  },

  -- JavaScript / TypeScript 用アダプタ (vscode-js-debug を利用)
  -- ロード: ft=javascript/typescript/jsx/tsx / 操作: keymaps/init.lua の DAP キー
  {
    'mxsdev/nvim-dap-vscode-js',
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    dependencies = {
      'mfussenegger/nvim-dap', -- 公式 README が必須と明記
      {
        -- デバッガ本体 (公式 README の指定どおりビルドして debugger_path で参照する)
        'microsoft/vscode-js-debug',
        build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
      },
    },
    config = function()
      local dap = require('dap')

      require('dap-vscode-js').setup({
        debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file (Deno)',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = 'deno',
            runtimeArgs = {
              'run',
              '--inspect-wait',
              '--allow-all',
            },
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Debug Jest Tests',
            runtimeExecutable = 'node',
            runtimeArgs = {
              './node_modules/jest/bin/jest.js',
              '--runInBand',
            },
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
          },
        }
      end
    end,
  },
}
