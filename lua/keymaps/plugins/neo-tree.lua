local ordermap = {
  ['2'] = 'order_by_name',
  ['3'] = 'order_by_type',
  ['4'] = 'order_by_diagnostics',
  ['5'] = 'order_by_modified',
  ['6'] = 'order_by_created',
  ['7'] = 'order_by_size',
}

local extend = require('utils').extend

return {
  window = {
    mappings = {
      ['<cr>'] = 'open',
      ['l'] = 'open',
      ['h'] = 'close_all_subnodes',
      ['e'] = 'expand_all_nodes',
      ['z'] = 'close_all_nodes',
      ['a'] = { 'add', config = { show_path = 'none' } },
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy',
      ['m'] = 'move',
      ['i'] = 'show_file_details',
      ['`'] = 'refresh',
      ['?'] = 'show_help',
      ['<C-k>'] = 'prev_source',
      ['<C-j>'] = 'next_source',
      ['<Esc>'] = function() vim.cmd('NeoTree close') end,
      ['q'] = function() vim.cmd('NeoTree close') end,
    },
  },
  filesystems = {
    mappings = extend({
      ['H'] = 'navigate_up',
      ['L'] = 'set_root',
      ['J'] = function() vim.cmd.normal('j') end,
      ['K'] = function() vim.cmd.normal('k') end,
      ['.'] = 'toggle_hidden',
      ['<space>'] = 'fuzzy_finder',
      ['<Tab>'] = 'next_git_modified',
      ['<S-Tab>'] = 'prev_git_modified',
      ['1'] = 'order_by_git_status',
    }, ordermap),
    fuzzy_finder_mappings = {
      ['<C-j>'] = 'move_cursor_down',
      ['<C-k>'] = 'move_cursor_up',
    },
  },
  buffers = {
    mappings = extend({
      ['H'] = 'navigate_up',
      ['L'] = 'set_root',
      ['J'] = function() vim.cmd.normal('j') end,
      ['K'] = function() vim.cmd.normal('k') end,
    }, ordermap),
  },
  git_status = {
    mappings = extend({
      ['gA'] = 'git_add_all',
      ['gu'] = 'git_unstage_file',
      ['ga'] = 'git_add_file',
      ['gr'] = 'git_revert_file',
      ['gc'] = 'git_commit',
      ['gp'] = 'git_push',
      ['gg'] = 'git_commit_and_push',
    }, ordermap),
  }
}
