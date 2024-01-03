local ordermap = {
  ["2"] = "order_by_name",
  ["3"] = "order_by_type",
  ["4"] = "order_by_diagnostics",
  ["5"] = "order_by_modified",
  ["6"] = "order_by_created",
  ["7"] = "order_by_size",
}

local extend = require('utils').extend

return {
  window = {
    mappings = {
      ["<cr>"] = "open",
      ["l"] = "open",
      ["h"] = 'close_all_subnodes',
      ["e"] = 'expand_all_nodes',
      ["z"] = 'close_all_nodes',
      ["a"] = { "add", config = { show_path = "none" } },
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["i"] = "show_file_details",
      ["`"] = "refresh",
      ["?"] = "show_help",
      ["<C-k>"] = "prev_source",
      ["<C-j>"] = "next_source",
      ["<Esc>"] = "cancel", -- close preview or floating neo-tree window
      ["q"] = "cancel", -- close preview or floating neo-tree window
      [";"] = "cancel", -- close preview or floating neo-tree window
    },
  },
  filesystems = {
    mappings = extend({
      ["H"] = "navigate_up",
      ["L"] = "set_root",
      ["."] = "toggle_hidden",
      ["<space>"] = "fuzzy_finder",
      ["<Tab>"] = "next_git_modified",
      ["<S-Tab>"] = "prev_git_modified",
      ["1"] = "order_by_git_status",
    }, ordermap),
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    },
  },
  buffers = {
    mappings = extend({
      ["H"] = "navigate_up",
      ["L"] = "set_root",
    }, ordermap),
  },
  git_status = {
    mappings = extend({
      ["gA"] = "git_add_all",
      ["gu"] = "git_unstage_file",
      ["ga"] = "git_add_file",
      ["gr"] = "git_revert_file",
      ["gc"] = "git_commit",
      ["gp"] = "git_push",
      ["gg"] = "git_commit_and_push",
    }, ordermap),
  },
}
