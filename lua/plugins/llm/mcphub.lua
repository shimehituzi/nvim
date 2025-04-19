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
      auto_approve = false,
      extensions = {
        avante = {
          make_slash_commands = false,
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
    })
  end,
}
