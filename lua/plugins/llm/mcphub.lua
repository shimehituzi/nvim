return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup({
      port = 37373,
      config = vim.fn.expand("~/.config/mcphub/servers.json"),
      native_servers = {},
      auto_approve = true,
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },

      ui = {
        window = {
          width = 0.8,
          height = 0.8,
          relative = "editor",
          zindex = 50,
          border = "rounded",
        },
        wo = {
        },
      },
      on_ready = function() end,
      on_error = function(err)
        vim.notify("MCPHub error: " .. err, vim.log.levels.ERROR)
      end,

      use_bundled_binary = false,
      shutdown_delay = 600000,
      log = {
        level = vim.log.levels.INFO, -- More verbose logging to help with troubleshooting
        to_file = true,
        file_path = vim.fn.expand("~/.config/mcphub/mcphub.log"),
        prefix = "MCPHub",
      },
    })
  end,
}
