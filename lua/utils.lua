return {
  -- vim.keymap.set の薄いラッパ (noremap がデフォルトなので指定不要)
  map = function(mode, lhs, rhs, opts) vim.keymap.set(mode, lhs, rhs, opts) end,

  -- カウント入力中は数字として、それ以外は rhs として動くマッピング
  -- (例: `03` で count=3 を作ってから LSP キーを使う。詳細は README 参照)
  nummap = function(mode, lhs, rhs, opts)
    vim.validate('mode', mode, 'string')
    vim.validate('lhs', lhs, 'string')
    vim.validate('rhs', rhs, 'string')
    if not string.match(lhs, '^%d$') then error('lhs of nummap must be a single digit') end

    vim.keymap.set(mode, lhs, function() return vim.v.count > 0 and lhs or rhs end, vim.tbl_extend('force', { expr = true }, opts or {}))
  end,
}
