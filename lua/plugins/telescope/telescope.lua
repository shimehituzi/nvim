return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/noice.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-q>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },
        },
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
          mappings = {
            i = {
              ['<space>'] = actions.close,
              ['<C-h>'] = fb_actions.goto_parent_dir,
              ['<C-l>'] = actions.select_default,
              ['<BS>'] = fb_actions.backspace,
              ['<C-a>'] = fb_actions.create,
              ['<C-r>'] = fb_actions.rename,
              ['<C-x>'] = fb_actions.move,
              ['<C-c>'] = fb_actions.copy,
              ['<C-d>'] = fb_actions.remove,
              ['<C-o>'] = fb_actions.open,
              ['<C-f>'] = fb_actions.toggle_browser,
              ['<C-t>'] = fb_actions.toggle_all,
              ['<C-s>'] = fb_actions.select_all,
              ['<Up>'] = fb_actions.toggle_hidden,
              ['<Down>'] = fb_actions.toggle_respect_gitignore,
              ['<Left>'] = fb_actions.sort_by_size,
              ['<Right>'] = fb_actions.sort_by_date,
            },
          },
        },
      },
    })
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('noice')
  end,
}
