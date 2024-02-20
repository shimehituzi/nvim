local default_false = {
  i = {
    ["<C-n>"] = false,
    ["<C-p>"] = false,
    ["<C-c>"] = false,
    ["<Down>"] = false,
    ["<Up>"] = false,
    ["<CR>"] = false,
    ["<C-x>"] = false,
    ["<C-v>"] = false,
    ["<C-t>"] = false,
    ["<C-u>"] = false,
    ["<C-d>"] = false,
    ["<PageUp>"] = false,
    ["<PageDown>"] = false,
    ["<Tab>"] = false,
    ["<S-Tab>"] = false,
    ["<M-q>"] = false,
    ["<C-l>"] = false,
    ["<C-/>"] = false,
    ["<C-_>"] = false,
    ["<C-w>"] = false,
    ["<C-q>"] = false,
    ["<C-j>"] = false,
  },
  n = {
    ["<esc>"] = false,
    ["<CR>"] = false,
    ["<C-x>"] = false,
    ["<C-v>"] = false,
    ["<C-t>"] = false,
    ["<Tab>"] = false,
    ["<S-Tab>"] = false,
    ["<C-q>"] = false,
    ["<M-q>"] = false,
    ["j"] = false,
    ["k"] = false,
    ["H"] = false,
    ["M"] = false,
    ["L"] = false,
    ["<Down>"] = false,
    ["<Up>"] = false,
    ["gg"] = false,
    ["G"] = false,
    ["<C-u>"] = false,
    ["<C-d>"] = false,
    ["<PageUp>"] = false,
    ["<PageDown>"] = false,
    ["?"] = false,
  },
}

local default_false_fb = {
  ["i"] = {
    ["<A-c>"] = false,
    ["<S-CR>"] = false,
    ["<A-r>"] = false,
    ["<A-m>"] = false,
    ["<A-y>"] = false,
    ["<A-d>"] = false,
    ["<C-o>"] = false,
    ["<C-g>"] = false,
    ["<C-e>"] = false,
    ["<C-w>"] = false,
    ["<C-t>"] = false,
    ["<C-f>"] = false,
    ["<C-h>"] = false,
    ["<C-s>"] = false,
    ["<bs>"] = false,
  },
  ["n"] = {
    ["c"] = false,
    ["r"] = false,
    ["m"] = false,
    ["y"] = false,
    ["d"] = false,
    ["o"] = false,
    ["g"] = false,
    ["e"] = false,
    ["w"] = false,
    ["t"] = false,
    ["f"] = false,
    ["h"] = false,
    ["s"] = false,
  },
}

local extend = require('utils').extend

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
          i = extend(default_false.i,{
            ['<CR>'] = actions.select_default,
            ['<esc>'] = actions.close,
            ['<C-q>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-z>'] = actions.which_key,
          }),
          n = default_false.n,
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
            i = extend(default_false_fb.i,{
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
            }),
            n = default_false_fb.n,
          },
        },
      },
    })
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('noice')
  end,
}
