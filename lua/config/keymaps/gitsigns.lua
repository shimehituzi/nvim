return {
  on_attach = function(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- ハンク移動
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

    -- ハンク操作
    map('n', '<Right>', gs.stage_hunk)
    map('n', '<Left>', gs.preview_hunk)
    -- undo_stage_hunk は非推奨だが、セッション内で stage を undo できる挙動のため意図的に使用
    ---@diagnostic disable-next-line: deprecated
    map('n', 'U', gs.undo_stage_hunk)
    map('n', '<C-u>', gs.reset_hunk)

    -- テキストオブジェクト
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
