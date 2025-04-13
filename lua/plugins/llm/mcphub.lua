return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",   -- Required for Job and HTTP requests
  },
  -- Removed lazy loading to ensure hub is ready at startup
  -- cmd = "MCPHub",
  build = "npm install -g mcp-hub@latest",   -- Installs required mcp-hub npm module
  config = function()
    require("mcphub").setup({
      port = 37373,                                          -- Default port for MCP Hub
      config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to config file location (will create if not exists)
      native_servers = {},                                   -- add your native servers here

      auto_approve = true,                                   -- Auto approve mcp tool calls for better experience
      -- Extensions configuration
      extensions = {
        avante = {
          make_slash_commands = true,   -- make /slash commands from MCP server prompts
        },
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          make_vars = true,             -- make chat #variables from MCP server resources
          make_slash_commands = true,   -- make /slash commands from MCP server prompts
        },
      },

      -- Default window settings
      ui = {
        window = {
          width = 0.8,    -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
          height = 0.8,   -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
          relative = "editor",
          zindex = 50,
          border = "rounded",   -- "none", "single", "double", "rounded", "solid", "shadow"
        },
        wo = {                  -- window-scoped options (vim.wo)
        },
      },

      -- Event callbacks
      on_ready = function(hub)
        -- Called when hub is ready
        vim.notify("MCPHub is ready with all configured servers", vim.log.levels.INFO)
      end,
      on_error = function(err)
        -- Called on errors
        vim.notify("MCPHub error: " .. err, vim.log.levels.ERROR)
      end,

      -- Uses installed mcp-hub script
      use_bundled_binary = false,

      -- Multi-instance Support
      shutdown_delay = 600000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)

      -- Logging configuration
      log = {
        level = vim.log.levels.INFO, -- More verbose logging to help with troubleshooting
        to_file = true,
        file_path = vim.fn.expand("~/.config/mcphub/mcphub.log"),
        prefix = "MCPHub",
      },
    })
  end,
}
