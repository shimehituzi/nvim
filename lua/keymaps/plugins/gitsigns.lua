return {
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
