vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

local map = require('config.util').map

map('n', '<leader>t', function() require('dap-go').debug_test() end, { buffer = true })
map('n', '<leader>T', function() require('dap-go').debug_last_test() end, { buffer = true })
