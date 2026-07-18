return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    file_types = { 'markdown', 'Avante' },
    completions = { lsp = { enabled = true } },
    code = {
      border = 'thin',
    },
  },
  ft = { 'markdown', 'Avante' },
}
