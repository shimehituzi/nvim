return {
  map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then options = vim.tbl_extend('force', options, opts) end

    vim.keymap.set(mode, lhs, rhs, options)
  end,

  nummap = function(mode, lhs, rhs, opts)
    vim.validate {
      mode = { mode, 's' },
      lhs = { lhs, 's' },
      rhs = { rhs, 's' },
    }

    local options = { noremap = true, expr = true }

    if opts then options = vim.tbl_extend('force', options, opts) end

    if not string.match(lhs, '^%d$') then
      error('lhs of nummap must be a number')
    end

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
