return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("notify").setup({
          stages = "static",
        })
      end
    },
  }
}
