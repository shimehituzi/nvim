local actions = package.loaded['diffview.actions']
return {
  keymaps = {
    disable_defaults = true, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
      { 'n', '<s-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
      { 'n', ';', actions.toggle_files, { desc = 'Toggle the file panel.' } },
      { 'n', ',', actions.cycle_layout, { desc = 'Cycle through available layouts.' } },
      { 'n', '\'', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '"', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '<C-q>', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '<Up>', actions.prev_conflict, { desc = 'In the merge-tool: jump to the previous conflict' } },
      { 'n', '<Down>', actions.next_conflict, { desc = 'In the merge-tool: jump to the next conflict' } },
      { 'n', '<Left>', actions.conflict_choose('ours'), { desc = 'Choose the OURS version of a conflict' } },
      { 'n', '<S-Left>', actions.conflict_choose_all('ours'), { desc = 'Choose the OURS version of a conflict for the whole file' } },
      { 'n', '<Right>', actions.conflict_choose('theirs'), { desc = 'Choose the THEIRS version of a conflict' } },
      { 'n', '<S-Right>', actions.conflict_choose_all('theirs'), { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
      { 'n', 'b', actions.conflict_choose('base'), { desc = 'Choose the BASE version of a conflict' } },
      { 'n', 'B', actions.conflict_choose_all('base'), { desc = 'Choose the BASE version of a conflict for the whole file' } },
      { 'n', 'a', actions.conflict_choose('all'), { desc = 'Choose all the versions of a conflict' } },
      { 'n', 'A', actions.conflict_choose_all('all'), { desc = 'Choose all the versions of a conflict for the whole file' } },
      { 'n', 'd', actions.conflict_choose('none'), { desc = 'Delete the conflict region' } },
      { 'n', 'D', actions.conflict_choose_all('none'), { desc = 'Delete the conflict region for the whole file' } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { 'n', '?', actions.help({ 'view', 'diff1' }), { desc = 'Open the help panel' } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { 'n', '?', actions.help({ 'view', 'diff2' }), { desc = 'Open the help panel' } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { 'n', 'x' }, '2do', actions.diffget('ours'), { desc = 'Obtain the diff hunk from the OURS version of the file' } },
      { { 'n', 'x' }, '3do', actions.diffget('theirs'), { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
      { 'n', '?', actions.help({ 'view', 'diff3' }), { desc = 'Open the help panel' } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { 'n', 'x' }, '1do', actions.diffget('base'), { desc = 'Obtain the diff hunk from the BASE version of the file' } },
      { { 'n', 'x' }, '2do', actions.diffget('ours'), { desc = 'Obtain the diff hunk from the OURS version of the file' } },
      { { 'n', 'x' }, '3do', actions.diffget('theirs'), { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
      { 'n', '?', actions.help({ 'view', 'diff4' }), { desc = 'Open the help panel' } },
    },
    file_panel = {
      { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
      { 'n', '<s-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
      { 'n', ';', actions.toggle_files, { desc = 'Toggle the file panel' } },
      { 'n', ',', actions.cycle_layout, { desc = 'Cycle available layouts' } },
      { 'n', '"', '<cmd>DiffviewClose<cr><cmd>DiffviewFileHistory<cr>', { desc = 'Close the Diffview Tab and Open the DiffviewFileHistory Tab' }, },
      { 'n', '\'', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '<C-q>', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '?', actions.help('file_panel'), { desc = 'Open the help panel' } },
      { 'n', '<Up>', actions.prev_conflict, { desc = 'Go to the previous conflict' } },
      { 'n', '<Down>', actions.next_conflict, { desc = 'Go to the next conflict' } },
      { 'n', '<S-Left>', actions.conflict_choose_all('ours'), { desc = 'Choose the OURS version of a conflict for the whole file' }, },
      { 'n', '<S-Right>', actions.conflict_choose_all('theirs'), { desc = 'Choose the THEIRS version of a conflict for the whole file' }, },
      { 'n', 'B', actions.conflict_choose_all('base'), { desc = 'Choose the BASE version of a conflict for the whole file' }, },
      { 'n', 'A', actions.conflict_choose_all('all'), { desc = 'Choose all the versions of a conflict for the whole file' }, },
      { 'n', 'D', actions.conflict_choose_all('none'), { desc = 'Delete the conflict region for the whole file' } },
      { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
      { 'n', 'k', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },
      { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
      { 'n', '<c-d>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
      { 'n', '<c-f>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
      { 'n', '<space>', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
      { 'n', 'S', actions.stage_all, { desc = 'Stage all entries' } },
      { 'n', 'U', actions.unstage_all, { desc = 'Unstage all entries' } },
      { 'n', 'X', actions.restore_entry, { desc = 'Restore entry to the state on the left side' } },
      { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
      { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
      { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
      { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
      { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
      { 'n', 'L', actions.open_commit_log, { desc = 'Open the commit log panel' } },
      { 'n', 'i', actions.listing_style, { desc = 'Toggle between \'list\' and \'tree\' views' } },
      { 'n', 'f', actions.toggle_flatten_dirs, { desc = 'Flatten empty subdirectories in tree listing style' } },
      { 'n', 'R', actions.refresh_files, { desc = 'Update stats and entries in the file list' } },
    },
    file_history_panel = {
      { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
      { 'n', '<s-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
      { 'n', ';', actions.toggle_files, { desc = 'Toggle the file panel' } },
      { 'n', ',', actions.cycle_layout, { desc = 'Cycle available layouts' } },
      { 'n', '\'', '<cmd>DiffviewClose<cr><cmd>DiffviewOpen<CR>', { desc = 'Close the DiffviewFileHistory Tab and Open the Diffview Tab' } },
      { 'n', '"', '<cmd>DiffviewClose<cr>', { desc = 'Close the DiffviewFileHistory Tab' } },
      { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close the DiffviewFileHistory Tab' } },
      { 'n', '<C-q>', '<cmd>DiffviewClose<cr>', { desc = 'Close the Diffview Tab' } },
      { 'n', '?', actions.help('file_history_panel'), { desc = 'Open the help panel' } },
      { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
      { 'n', 'k', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry.' } },
      { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry.' } },
      { 'n', '<c-d>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
      { 'n', '<c-f>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
      { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
      { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
      { 'n', '!', actions.options, { desc = 'Open the option panel' } },
      { 'n', 'y', actions.copy_hash, { desc = 'Copy the commit hash of the entry under the cursor' } },
      { 'n', 'L', actions.open_commit_log, { desc = 'Show commit details' } },
    },
    option_panel = {
      { 'n', '<tab>', actions.select_entry, { desc = 'Change the current option' } },
      { 'n', 'q', actions.close, { desc = 'Close the panel' } },
      { 'n', '?', actions.help('option_panel'), { desc = 'Open the help panel' } },
    },
    help_panel = {
      { 'n', 'q', actions.close, { desc = 'Close help menu' } },
      { 'n', '<esc>', actions.close, { desc = 'Close help menu' } },
    },
  },
}
