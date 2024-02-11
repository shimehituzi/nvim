return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/trouble.nvim' },
    { 'folke/noice.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local trouble = require('trouble.providers.telescope')
    local fb_actions = require "telescope".extensions.file_browser.actions

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-q>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-t>'] = trouble.open_with_trouble,
          },
        },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            width = 0.9,
            height = 0.9,
            preview_width = 0.6,
            prompt_position = "top",
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        file_browser = {
          hijack_netrw = true,
          mappings = {
            i = {
            },
          },
        },
      }
    })
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("noice")
  end
}
