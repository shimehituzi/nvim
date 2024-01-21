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
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        },
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
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
