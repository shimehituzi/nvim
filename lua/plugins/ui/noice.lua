local ignored_warn_messages = {
  "position_encoding param is required in vim.lsp.util.make_position_params",
  "multiple different client offset_encodings detected",
}

local function create_ignore_routes(messages)
  local routes = {}
  for _, m in ipairs(messages) do
    table.insert(routes, {
      filter = {
        event = "notify",
        find = m,
      },
      opts = {
        skip = true,
      },
    })
  end
  return routes
end

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    routes = create_ignore_routes(ignored_warn_messages),
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("notify").setup({
          stages = "static",
        })
      end,
    },
  },
}
