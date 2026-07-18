-- Set indentation to tabs for Go files
vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

local map = require('utils').map

-- ftplugin なので buffer-local にする (以前はグローバルに漏れていた)
map('n', '<leader>t', function() require('dap-go').debug_test() end, { buffer = true })
map('n', '<leader>T', function() require('dap-go').debug_last_test() end, { buffer = true })
