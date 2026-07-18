-- f/F/t/T を leap.nvim で clever-f 風にするアクション定義 (キー割当は lua/config/keymaps/init.lua)
-- leap は起動時ロードのプラグインなので、モジュールロード時に require してよい
local function leap_ft(kwargs)
  require('leap').leap(vim.tbl_deep_extend('keep', kwargs, {
    inputlen = 1,
    inclusive = true,
    opts = {
      -- Force autojump.
      labels = '',
      -- Match the modes where you don't need labels (`:h mode()`).
      safe_labels = vim.fn.mode(1):match('no?') and '' or nil,
    },
  }))
end

-- トリガーキー自身でリピートできるようにする (clever-f 風)
local clever_f = require('leap.user').with_traversal_keys('f', 'F')
local clever_t = require('leap.user').with_traversal_keys('t', 'T')

return {
  f = function() leap_ft({ opts = clever_f }) end,
  F = function() leap_ft({ backward = true, opts = clever_f }) end,
  t = function() leap_ft({ offset = -1, opts = clever_t }) end,
  T = function() leap_ft({ backward = true, offset = 1, opts = clever_t }) end,
}
