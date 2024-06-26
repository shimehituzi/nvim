local actions = require('telescope.actions')
local fb_actions = require('telescope').extensions.file_browser.actions

local defaults_mapping = {
  i = {
    ['<esc>'] = actions.close,
    ['<C-q>'] = actions.close,
    ['<CR>'] = actions.select_default,
    ['<Tab>'] = function(prompt_bufnr)
      actions.select_default(prompt_bufnr)
      require('telescope.builtin').resume()
    end,
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
    ['<Up>'] = actions.preview_scrolling_up,
    ['<Down>'] = actions.preview_scrolling_down,
  },
  n = {},
}

local file_browser_mapping = {
  i = {
    ['<C-h>'] = fb_actions.goto_parent_dir,
    ['<C-l>'] = actions.select_default,
    ['<BS>'] = fb_actions.backspace,
    ['<C-s>'] = actions.toggle_selection,
    ['<C-a>'] = fb_actions.create,
    ['<C-r>'] = fb_actions.rename,
    ['<C-p>'] = fb_actions.move,
    ['<C-c>'] = fb_actions.copy,
    ['<C-d>'] = fb_actions.remove,
    ['<C-o>'] = fb_actions.open,
    ['<C-f>'] = fb_actions.toggle_browser,
    ['<C-z>'] = fb_actions.toggle_hidden,
    ['<C-x>'] = fb_actions.toggle_respect_gitignore,
  },
  n = {},
}

local defaults_false = {
  i = {
    ['<C-n>'] = false,
    ['<C-p>'] = false,
    ['<C-c>'] = false,
    ['<Down>'] = false,
    ['<Up>'] = false,
    ['<CR>'] = false,
    ['<C-x>'] = false,
    ['<C-v>'] = false,
    ['<C-t>'] = false,
    ['<C-u>'] = false,
    ['<C-d>'] = false,
    ['<PageUp>'] = false,
    ['<PageDown>'] = false,
    ['<Tab>'] = false,
    ['<S-Tab>'] = false,
    ['<M-q>'] = false,
    ['<C-l>'] = false,
    ['<C-/>'] = false,
    ['<C-_>'] = false,
    ['<C-w>'] = false,
    ['<C-q>'] = false,
    ['<C-j>'] = false,
  },
  n = {
    ['<esc>'] = false,
    ['<CR>'] = false,
    ['<C-x>'] = false,
    ['<C-v>'] = false,
    ['<C-t>'] = false,
    ['<Tab>'] = false,
    ['<S-Tab>'] = false,
    ['<C-q>'] = false,
    ['<M-q>'] = false,
    ['j'] = false,
    ['k'] = false,
    ['H'] = false,
    ['M'] = false,
    ['L'] = false,
    ['<Down>'] = false,
    ['<Up>'] = false,
    ['gg'] = false,
    ['G'] = false,
    ['<C-u>'] = false,
    ['<C-d>'] = false,
    ['<PageUp>'] = false,
    ['<PageDown>'] = false,
    ['?'] = false,
  },
}

local file_browser_false = {
  i = {
    ['<A-c>'] = false,
    ['<S-CR>'] = false,
    ['<A-r>'] = false,
    ['<A-m>'] = false,
    ['<A-y>'] = false,
    ['<A-d>'] = false,
    ['<C-o>'] = false,
    ['<C-g>'] = false,
    ['<C-e>'] = false,
    ['<C-w>'] = false,
    ['<C-t>'] = false,
    ['<C-f>'] = false,
    ['<C-h>'] = false,
    ['<C-s>'] = false,
    ['<bs>'] = false,
  },
  n = {
    ['c'] = false,
    ['r'] = false,
    ['m'] = false,
    ['y'] = false,
    ['d'] = false,
    ['o'] = false,
    ['g'] = false,
    ['e'] = false,
    ['w'] = false,
    ['t'] = false,
    ['f'] = false,
    ['h'] = false,
    ['s'] = false,
  },
}

local extend = require('utils').extend

return {
  defaults = {
    i = extend(defaults_false.i, defaults_mapping.i),
    n = extend(defaults_false.n, defaults_mapping.n),
  },
  file_browser = {
    i = extend(file_browser_false.i, file_browser_mapping.i),
    n = extend(file_browser_false.n, file_browser_mapping.n),
  },
}
