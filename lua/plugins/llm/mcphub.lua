return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "yetone/avante.nvim",
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

    local avext = require("mcphub.extensions.avante")

    local function wrap_factory(fname)
      if type(avext[fname]) ~= "function" then return end
      local factory_orig = avext[fname]

      avext[fname] = function(...)
        local schema    = factory_orig(...)
        local func_orig = schema.func

        schema.func     = function(args, on_log, on_complete)
          on_log(string.format(
            "MCP ► %s / %s %s",
            args.server_name or "?",
            args.tool_name or args.uri or "?",
            vim.fn.json_encode(args.tool_input or {})
          ))
          return func_orig(args, on_log, on_complete)
        end

        return schema
      end
    end

    wrap_factory("mcp_tool")
    wrap_factory("resource")
  end,
}
