-- Set indentation to tabs for Go files
vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

local map = require('utils').map

map('n', '<leader>t', require('dap-go').debug_test)
map('n', '<leader>T', require('dap-go').debug_last_test)
