local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

M.myFuncForMap = {
  exchangeChar = function()
    print('TODO')
  end,
  moveUpSelectedText = function()
    print('TODO')
  end,
  moveDownSelectedText = function()
    print('TODO')
  end
}


return M
