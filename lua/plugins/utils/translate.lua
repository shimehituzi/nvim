return {
  "uga-rosa/translate.nvim",
  config = function()
    require('translate').setup({
      defauls = {
        command = 'translate-shell',
      },
    })
  end,
}
