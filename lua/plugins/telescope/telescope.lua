return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/noice.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        mappings = require('keymaps.plugins.telescope').defaults,
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            width = 0.9,
            height = 0.9,
            preview_width = 0.6,
            prompt_position = 'top',
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        file_browser = {
          hijack_netrw = true,
          hide_parent_dir = true,
          grouped = true,
          auto_depth = true,
          display_stat = false,
          mappings = require('keymaps.plugins.telescope').file_browser,
        },
      },
    })
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('noice')
  end,
}
