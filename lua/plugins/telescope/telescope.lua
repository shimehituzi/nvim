return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local trouble = require('trouble.providers.telescope')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-t>'] = trouble.open_with_trouble,
          },
        },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            height = 0.95,
            preview_cutoff = 120,
            preview_width = 0.6,
            prompt_position = "bottom",
            width = 0.95
          },
        },
      },
    })
    require("telescope").load_extension("noice")
  end
}
