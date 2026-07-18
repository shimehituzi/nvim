return {
  map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then options = vim.tbl_extend('force', options, opts) end

    vim.keymap.set(mode, lhs, rhs, options)
  end,

  nummap = function(mode, lhs, rhs, opts)
    -- vim.validate のテーブル形式は非推奨 (Nvim 1.0 で削除予定) のため新形式で
    vim.validate('mode', mode, 'string')
    vim.validate('lhs', lhs, 'string')
    vim.validate('rhs', rhs, 'string')

    local options = { noremap = true, expr = true }

    if opts then options = vim.tbl_extend('force', options, opts) end

    if not string.match(lhs, '^%d$') then error('lhs of nummap must be a number') end

    local command = 'v:count ? "' .. lhs .. '" : "' .. rhs .. '"'

    vim.api.nvim_set_keymap(mode, lhs, command, options)
  end,

  extend = function(...)
    local dst = {}
    for _, src in ipairs({ ... }) do
      if type(src) == 'table' then
        for k, v in pairs(src) do
          dst[k] = v
        end
      end
    end
    return dst
  end,
}
