return {
  {
    'mfussenegger/nvim-dap',
    version = '*',
  },
  {
    'rcarriga/nvim-dap-ui',
    version = '3.9.3',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = true,
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    config = true,
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    config = function()
      require('dap-go').setup()
      local dap = require('dap')

      dap.adapters.go = function(callback, config)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
          stdio = { nil, stdout },
          args = { 'dap', '-l', '127.0.0.1:' .. port },
          detached = true,
        }
        handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
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
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    config = function() require('dap-python').setup('./.venv/bin/python') end,
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    dependencies = {
      'microsoft/vscode-js-debug',
      build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    config = function()
      local dap = require('dap')

      require('dap-vscode-js').setup({
        debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact' }) do
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
