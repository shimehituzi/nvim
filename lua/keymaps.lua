local map = require('utils').map

-- **BASIC**
-- normal, visual, operator-pending
map('', 'j', 'gj')
map('', 'k', 'gk')
map('', 'H', '^')
map('', 'L', '$')
map('', '<Home>', 'gg')
map('', '<End>', 'G')
map('', '<C-f>', '<C-d>')
map('', '<C-d>', '<C-u>')

-- normal
map('n', '<CR>', '<cmd>w<cr>')
map('n', 'q', '<cmd>bwipeout<cr><cmd>clearjumps<cr>')
map('n', '<C-q>', '<cmd>q<CR>')
map('n', '<S-q>', '<C-z>')
map('n', '<C-l>', '<C-w>w')
map('n', '<C-h>', '<C-w>W')
map('n', '<C-p>', "p']")
map('n', 'm', '@')
map('n', 'M', 'q')
map('n', 't', '<C-a>')
map('n', 'T', '<C-x>')
map('n', '`', '<C-l><cmd>nohl<cr>')
map('n', 'G', '~')
map('n', 'U', 'J')
map('n', '<space>o', "<cmd>for i in range(v:count1) | call append(line('.'), '') | endfor<cr>")
map('n', '<space>O', "<cmd>for i in range(v:count1) | call append(line('.')-1, '') | endfor<cr>")
map('n', '<S-Tab>', '<C-i>')
map('n', '<BS>', '<C-o>')
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('n', 's', '"_s')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<S-Up>', '<cmd>m.-2<cr>')
map('n', '<S-Down>', '<cmd>m.+1<cr>')

-- visual
map('v', '<C-y>', "y']")

-- operator-pending
map('o', 'aa', 'a>')
map('o', 'ia', 'i>')
map('o', 'as', 'a[')
map('o', 'is', 'i[')
map('o', 'ad', 'a"')
map('o', 'id', 'i"')
map('v', 'aa', 'a>')
map('v', 'ia', 'i>')
map('v', 'as', 'a[')
map('v', 'is', 'i[')
map('v', 'ad', 'a"')
map('v', 'id', 'i"')

-- insert
map('i', '<C-h>', '<C-g>U<Left>')
map('i', '<C-l>', '<C-g>U<Right>')
map('i', '<C-e>', '<C-g>U<End>')
map('i', '<C-d>', '<Del>')

-- **PLUGINS**
-- normal
map('n', ';', '<cmd>Neotree float<cr>')
map('n', ',', '<cmd>DiffviewOpen<cr>')
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', '<S-j>', '<cmd>BufferLineMoveNext<cr>')
map('n', '<S-k>', '<cmd>BufferLineMovePrev<cr>')
map('n', '^', '<cmd>IBLToggle<cr>')
map('n', '&', '<cmd>TroubleToggle<cr>')
map('n', '}', function()
  local trouble = require('trouble')
  if not (trouble.is_open()) then
    trouble.open()
  end
  trouble.next({ skip_groups = true, jump = true })
end)
map('n', '{', function()
  local trouble = require('trouble')
  if not (trouble.is_open()) then
    trouble.open()
  end
  trouble.previous({ skip_groups = true, jump = true })
end)

-- **EXPORT**
local M = {}
-- plugins/lsp/nvim-lspconfig.lua
M.lspconfig = {
  on_attach = function(client, bufnr)
    local set = vim.keymap.set
    set("n", "<space><space>", "<cmd>lua vim.lsp.buf.hover()<CR>")
    set("n", "!", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set("n", "@", "<cmd>lua vim.lsp.buf.references()<CR>")
    set("n", "#", "<cmd>lua vim.lsp.buf.definition()<CR>")
    set("n", "$", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set("n", "'", "<cmd>lua vim.lsp.buf.format()<CR>")
    set("n", "0", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  end
}

-- plugins/lsp/nvim-cmp.lua
M.nvim_cmp = function(cmp)
  return {
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ['<C-f>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
  }
end

-- plugins/ui/neo-tree.lua
M.neo_tree = {
  window = {
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      -- Read `# Preview Mode` for more information
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      [";"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
    },
  },
  filesystems = {
    mappings = {
      ["<bs>"] = "navigate_up",
      ["."] = "set_root",
      ["H"] = "toggle_hidden",
      ["/"] = "fuzzy_finder",
      ["D"] = "fuzzy_finder_directory",
      ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
      -- ["D"] = "fuzzy_sorter_directory",
      ["f"] = "filter_on_submit",
      ["<c-x>"] = "clear_filter",
      ["[g"] = "prev_git_modified",
      ["]g"] = "next_git_modified",
      ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
      ["oc"] = { "order_by_created", nowait = false },
      ["od"] = { "order_by_diagnostics", nowait = false },
      ["og"] = { "order_by_git_status", nowait = false },
      ["om"] = { "order_by_modified", nowait = false },
      ["on"] = { "order_by_name", nowait = false },
      ["os"] = { "order_by_size", nowait = false },
      ["ot"] = { "order_by_type", nowait = false },
    },
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<down>"] = "move_cursor_down",
      ["<C-n>"] = "move_cursor_down",
      ["<up>"] = "move_cursor_up",
      ["<C-p>"] = "move_cursor_up",
    },
  },
  buffers = {
    mappings = {
      ["bd"] = "buffer_delete",
      ["<bs>"] = "navigate_up",
      ["."] = "set_root",
      ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
      ["oc"] = { "order_by_created", nowait = false },
      ["od"] = { "order_by_diagnostics", nowait = false },
      ["om"] = { "order_by_modified", nowait = false },
      ["on"] = { "order_by_name", nowait = false },
      ["os"] = { "order_by_size", nowait = false },
      ["ot"] = { "order_by_type", nowait = false },
    }
  },
  git_status = {
    mappings = {
      ["A"]  = "git_add_all",
      ["gu"] = "git_unstage_file",
      ["ga"] = "git_add_file",
      ["gr"] = "git_revert_file",
      ["gc"] = "git_commit",
      ["gp"] = "git_push",
      ["gg"] = "git_commit_and_push",
      ["o"]  = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
      ["oc"] = { "order_by_created", nowait = false },
      ["od"] = { "order_by_diagnostics", nowait = false },
      ["om"] = { "order_by_modified", nowait = false },
      ["on"] = { "order_by_name", nowait = false },
      ["os"] = { "order_by_size", nowait = false },
      ["ot"] = { "order_by_type", nowait = false },
    }
  },
}
-- plugins/git/gitsigns.lua
M.gitsigns = {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<Down>', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '<Up>', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<Right>', gs.stage_hunk)
    map('v', '<Right>', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('n', '<S-Right>', gs.undo_stage_hunk)
    map('n', '<Left>', gs.preview_hunk)
    map('n', '<S-Left>', function() gs.blame_line { full = true } end)
    map('n', '<C-u>', gs.reset_hunk)
    map('v', '<C-u>', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

M.diffview = function(actions)
  return {
    keymaps = {
      disable_defaults = false, -- Disable the default keymaps
      view = {
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        { "n", "<tab>",      actions.select_next_entry,             { desc = "Open the diff for the next file" } },
        { "n", "<s-tab>",    actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
        { "n", "gf",         actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
        { "n", "<C-w><C-f>", actions.goto_file_split,               { desc = "Open the file in a new split" } },
        { "n", "<C-w>gf",    actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
        { "n", "<leader>e",  actions.focus_files,                   { desc = "Bring focus to the file panel" } },
        { "n", "<leader>b",  actions.toggle_files,                  { desc = "Toggle the file panel." } },
        { "n", "g<C-x>",     actions.cycle_layout,                  { desc = "Cycle through available layouts." } },
        { "n", "[x",         actions.prev_conflict,                 { desc = "In the merge-tool: jump to the previous conflict" } },
        { "n", "]x",         actions.next_conflict,                 { desc = "In the merge-tool: jump to the next conflict" } },
        { "n", "<leader>co", actions.conflict_choose("ours"),       { desc = "Choose the OURS version of a conflict" } },
        { "n", "<leader>ct", actions.conflict_choose("theirs"),     { desc = "Choose the THEIRS version of a conflict" } },
        { "n", "<leader>cb", actions.conflict_choose("base"),       { desc = "Choose the BASE version of a conflict" } },
        { "n", "<leader>ca", actions.conflict_choose("all"),        { desc = "Choose all the versions of a conflict" } },
        { "n", "dx",         actions.conflict_choose("none"),       { desc = "Delete the conflict region" } },
        { "n", "<leader>cO", actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
        { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
        { "n", "<leader>cB", actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
        { "n", "<leader>cA", actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
        { "n", "dX",         actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
      },
      diff1 = {
        -- Mappings in single window diff layouts
        { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
      },
      diff2 = {
        -- Mappings in 2-way diff layouts
        { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
      },
      diff3 = {
        -- Mappings in 3-way diff layouts
        { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
        { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
        { "n",          "g?",  actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
      },
      diff4 = {
        -- Mappings in 4-way diff layouts
        { { "n", "x" }, "1do", actions.diffget("base"),           { desc = "Obtain the diff hunk from the BASE version of the file" } },
        { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
        { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
        { "n",          "g?",  actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
      },
      file_panel = {
        { "n", "j",             actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
        { "n", "<down>",        actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
        { "n", "k",             actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
        { "n", "<up>",          actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
        { "n", "<cr>",          actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
        { "n", "o",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
        { "n", "l",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
        { "n", "<2-LeftMouse>", actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
        { "n", "-",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
        { "n", "s",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
        { "n", "S",             actions.stage_all,                     { desc = "Stage all entries" } },
        { "n", "U",             actions.unstage_all,                   { desc = "Unstage all entries" } },
        { "n", "X",             actions.restore_entry,                 { desc = "Restore entry to the state on the left side" } },
        { "n", "L",             actions.open_commit_log,               { desc = "Open the commit log panel" } },
        { "n", "zo",            actions.open_fold,                     { desc = "Expand fold" } },
        { "n", "h",             actions.close_fold,                    { desc = "Collapse fold" } },
        { "n", "zc",            actions.close_fold,                    { desc = "Collapse fold" } },
        { "n", "za",            actions.toggle_fold,                   { desc = "Toggle fold" } },
        { "n", "zR",            actions.open_all_folds,                { desc = "Expand all folds" } },
        { "n", "zM",            actions.close_all_folds,               { desc = "Collapse all folds" } },
        { "n", "<c-b>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
        { "n", "<c-f>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
        { "n", "<tab>",         actions.select_next_entry,             { desc = "Open the diff for the next file" } },
        { "n", "<s-tab>",       actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
        { "n", "gf",            actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
        { "n", "<C-w><C-f>",    actions.goto_file_split,               { desc = "Open the file in a new split" } },
        { "n", "<C-w>gf",       actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
        { "n", "i",             actions.listing_style,                 { desc = "Toggle between 'list' and 'tree' views" } },
        { "n", "f",             actions.toggle_flatten_dirs,           { desc = "Flatten empty subdirectories in tree listing style" } },
        { "n", "R",             actions.refresh_files,                 { desc = "Update stats and entries in the file list" } },
        { "n", "<leader>e",     actions.focus_files,                   { desc = "Bring focus to the file panel" } },
        { "n", "<leader>b",     actions.toggle_files,                  { desc = "Toggle the file panel" } },
        { "n", "g<C-x>",        actions.cycle_layout,                  { desc = "Cycle available layouts" } },
        { "n", "[x",            actions.prev_conflict,                 { desc = "Go to the previous conflict" } },
        { "n", "]x",            actions.next_conflict,                 { desc = "Go to the next conflict" } },
        { "n", "g?",            actions.help("file_panel"),            { desc = "Open the help panel" } },
        { "n", "<leader>cO",    actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
        { "n", "<leader>cT",    actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
        { "n", "<leader>cB",    actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
        { "n", "<leader>cA",    actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
        { "n", "dX",            actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
      },
      file_history_panel = {
        { "n", "g!",            actions.options,                    { desc = "Open the option panel" } },
        { "n", "<C-A-d>",       actions.open_in_diffview,           { desc = "Open the entry under the cursor in a diffview" } },
        { "n", "y",             actions.copy_hash,                  { desc = "Copy the commit hash of the entry under the cursor" } },
        { "n", "L",             actions.open_commit_log,            { desc = "Show commit details" } },
        { "n", "zR",            actions.open_all_folds,             { desc = "Expand all folds" } },
        { "n", "zM",            actions.close_all_folds,            { desc = "Collapse all folds" } },
        { "n", "j",             actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
        { "n", "<down>",        actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
        { "n", "k",             actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
        { "n", "<up>",          actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
        { "n", "<cr>",          actions.select_entry,               { desc = "Open the diff for the selected entry." } },
        { "n", "o",             actions.select_entry,               { desc = "Open the diff for the selected entry." } },
        { "n", "<2-LeftMouse>", actions.select_entry,               { desc = "Open the diff for the selected entry." } },
        { "n", "<c-b>",         actions.scroll_view(-0.25),         { desc = "Scroll the view up" } },
        { "n", "<c-f>",         actions.scroll_view(0.25),          { desc = "Scroll the view down" } },
        { "n", "<tab>",         actions.select_next_entry,          { desc = "Open the diff for the next file" } },
        { "n", "<s-tab>",       actions.select_prev_entry,          { desc = "Open the diff for the previous file" } },
        { "n", "gf",            actions.goto_file_edit,             { desc = "Open the file in the previous tabpage" } },
        { "n", "<C-w><C-f>",    actions.goto_file_split,            { desc = "Open the file in a new split" } },
        { "n", "<C-w>gf",       actions.goto_file_tab,              { desc = "Open the file in a new tabpage" } },
        { "n", "<leader>e",     actions.focus_files,                { desc = "Bring focus to the file panel" } },
        { "n", "<leader>b",     actions.toggle_files,               { desc = "Toggle the file panel" } },
        { "n", "g<C-x>",        actions.cycle_layout,               { desc = "Cycle available layouts" } },
        { "n", "g?",            actions.help("file_history_panel"), { desc = "Open the help panel" } },
      },
      option_panel = {
        { "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
        { "n", "q",     actions.close,                { desc = "Close the panel" } },
        { "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
      },
      help_panel = {
        { "n", "q",     actions.close, { desc = "Close help menu" } },
        { "n", "<esc>", actions.close, { desc = "Close help menu" } },
      },
    }
  }
end

return M
