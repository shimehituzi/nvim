return {
  map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
      options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
  end,

  extend = function(...)
    local dst = {}
    for _, src in ipairs({ ... }) do
      if type(src) == "table" then
        for k, v in pairs(src) do
          dst[k] = v
        end
      end
    end
    return dst
  end
}
