return {
  on_attach = function(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation (next_hunk/prev_hunk は非推奨のため後継の nav_hunk を使用)
    map('n', '<Down>', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.nav_hunk('next') end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '<Up>', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.nav_hunk('prev') end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<Right>', gs.stage_hunk)
    map('n', '<Left>', gs.preview_hunk)
    -- undo_stage_hunk は非推奨 (後継は staged sign 上での stage_hunk トグル) だが
    -- セッション内 undo スタックの挙動を維持するため継続使用
    map('n', 'U', gs.undo_stage_hunk)
    map('n', '<C-u>', gs.reset_hunk)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
