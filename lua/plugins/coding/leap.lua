-- flit.nvim は作者が開発終了 (最終コミット "So long, and thanks for all the flits")。
-- 公式の案内 (:help leap-ft, README の "Enhanced f/t motions") に従い
-- leap 本体で f/F/t/T を提供する
return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  name = 'leap.nvim',
  dependencies = {
    { 'tpope/vim-repeat' },
  },
  config = function()
    local function ft(kwargs)
      require('leap').leap(
        vim.tbl_deep_extend('keep', kwargs, {
          inputlen = 1,
          inclusive = true,
          opts = {
            -- Force autojump.
            labels = '',
            -- Match the modes where you don't need labels (`:h mode()`).
            safe_labels = vim.fn.mode(1):match('no?') and '' or nil,
          },
        })
      )
    end

    -- clever-f 風のリピート (f/F, t/T 自身で次候補へ)
    local clever = require('leap.user').with_traversal_keys
    local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

    vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
      ft { opts = clever_f }
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
      ft { backward = true, opts = clever_f }
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, 't', function()
      ft { offset = -1, opts = clever_t }
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', function()
      ft { backward = true, offset = 1, opts = clever_t }
    end)
  end,
}
