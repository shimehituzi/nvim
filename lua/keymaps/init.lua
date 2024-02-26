local map = require('utils').map

-- **NOP**
local noplist = {
  '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
  '<C-a>', '<C-b>', '<C-c>', '<C-e>', '<C-g>', '<C-n>', '<C-s>', '<C-t>', '<C-x>', '<C-y>', '<C-z>',
}
for _, m in ipairs(noplist) do
  map('n', m, function() print('These keys are not mapped: ' .. table.concat(noplist, ' ')) end, { expr = true })
end

-- **BASIC**
-- normal, visual, operator-pending
map('', 'j', 'gj')
map('', 'k', 'gk')
map('', 'H', '^')
map('', 'L', '$')
map('', '<End>', 'G')
map('', '<Home>', 'gg')
map('', '<C-f>', '<C-d>')
map('', '<C-d>', '<C-u>')

-- normal
map('n', '<CR>', '<cmd>w<cr>')
map('n', 'q', '<cmd>bd<cr>')
map('n', '<C-q>', '<cmd>q<CR>')
map('n', '<S-q>', '<C-z>')
map('n', '<C-l>', '<C-w>w')
map('n', '<C-h>', '<C-w>W')
map('n', '<C-p>', 'p\']')
map('n', 'm', '@')
map('n', 'M', 'q')
map('n', 't', '<C-a>')
map('n', 'T', '<C-x>')
map('n', '`', '<cmd>only<cr>')
map('n', '~', '<C-l><cmd>nohl<cr>')
map('n', 'G', '~')
map('n', 'X', 'J')
map('n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>')
map('n', '<BS>', '<C-o>')
map('n', '<Del>', '<C-i>')
map('n', 'x', '"_x')
map('n', 's', '"_s')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '}', '<cmd>cn<CR>')
map('n', '{', '<cmd>cN<CR>')
map('n', '0', '<nop>')
for i = 1, 9 do
  map('n', '0' .. i, tostring(i))
end

-- visual
map('v', '<C-y>', 'y\']')

-- insert
map('i', '<C-h>', '<C-g>U<Left>')
map('i', '<C-l>', '<C-g>U<Right>')
map('i', '<C-e>', '<C-g>U<End>')
map('i', '<C-d>', '<Del>')

-- textobject
map({ 'v', 'o' }, 'aa', 'a>')
map({ 'v', 'o' }, 'ia', 'i>')
map({ 'v', 'o' }, 'as', 'a[')
map({ 'v', 'o' }, 'is', 'i[')
map({ 'v', 'o' }, 'ad', 'a"')
map({ 'v', 'o' }, 'id', 'i"')

-- **PLUGINS**
-- normal
local builtin = require('telescope.builtin')
local extnsions = require('telescope').extensions
map('n', '<Tab>', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<S-Tab>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', ';', '<cmd>lua vim.lsp.buf.format()<CR>')
map('n', '\'', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '"', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Space>', extnsions.file_browser.file_browser)
map('n', 'f', builtin.lsp_definitions)
map('n', 'F', builtin.lsp_references)
map('n', '1', builtin.resume)
map('n', '2', builtin.current_buffer_fuzzy_find)
map('n', '3', builtin.live_grep)
map('n', '4', builtin.quickfix)
map('n', '5', builtin.quickfixhistory)
map('n', '6', builtin.help_tags)
map('n', '7', extnsions.noice.noice)
map('n', '8', builtin.lsp_document_symbols)
map('n', '9', builtin.diagnostics)
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'J', function() require('illuminate').goto_next_reference() end)
map('n', 'K', function() require('illuminate').goto_prev_reference() end)
map('n', '+', '<cmd>Neotree filesystem reveal right toggle<cr>')
map('n', '-', '<cmd>DiffviewOpen<cr>')
map('n', '_', '<cmd>DiffviewFileHistory<cr>')
map('n', '|', '<cmd>IBLToggle<cr>')
map('n', ',', '<Plug>(comment_toggle_linewise_current)')
map('n', 'S', '<Plug>(nvim-surround-normal-cur)')
map('n', 'ys', '<Plug>(nvim-surround-normal)')
map('n', 'cs', '<Plug>(nvim-surround-change)')
map('n', 'ds', '<Plug>(nvim-surround-delete)')

-- visual
map('v', '<CR>', '<cmd>Translate ja<cr>')
map('v', ',', '<Plug>(comment_toggle_linewise_visual)')
map('v', 'S', '<Plug>(nvim-surround-visual)')

-- textobject
map({ 'v', 'o' }, '<space>', function() require('illuminate').textobj_select() end)
