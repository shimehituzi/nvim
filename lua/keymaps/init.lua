local map = require('utils').map
local functions = require('keymaps.functions')

-- **NOP**
local noplist = {
  '@', '#', '$', '^', '%', '&', '*', '(', ')',
  '<C-a>', '<C-b>', '<C-c>', '<C-e>', '<C-n>', '<C-t>', '<C-x>', '<C-y>', '<C-z>',
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
map('n', 'q', '<cmd>bwipeout<cr><cmd>clearjumps<cr>')
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
map('n', 'U', 'J')
-- map('n', '-', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>')
-- map('n', '_', '<cmd>for i in range(v:count1) | call append(line(\'.\')-1, \'\') | endfor<cr>')
map('n', '<BS>', '<C-o>')
map('n', '<Del>', '<C-i>')
map('n', 'x', '"_x')
map('n', 's', '"_s')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
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
map('n', 'f', builtin.find_files)
map('n', 'F', builtin.live_grep)
map('n', '?', builtin.current_buffer_fuzzy_find)
map('n', ';', extnsions.file_browser.file_browser)
-- map('n', ' ', builtin.builtin)
-- map('n', ' ', builtin.buffers)
map('n', '3', builtin.help_tags)
-- map('n', ' ', extnsions.noice.noice)
-- map('n', ' ', builtin.lsp_document_symbols)
-- map('n', ' ', builtin.diagnostic)
-- map('n', ' ', builtin.git_bcommits)
map('n', '<Tab>', builtin.lsp_references)
map('n', '<S-Tab>', builtin.lsp_definitions)
map('n', '<space>', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '"', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '!', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '1', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'J', function() require('illuminate').goto_next_reference() end)
map('n', 'K', function() require('illuminate').goto_prev_reference() end)
map('n', '-', '<cmd>Neotree filesystem reveal right toggle<cr>')
map('n', '_', '<cmd>Neotree git_status right toggle<cr>')
map('n', '+', '<cmd>Neotree document_symbols right toggle<cr>')
map('n', '\'', '<cmd>lua vim.lsp.buf.format()<CR>')
map('n', '<S-Up>', '<cmd>DiffviewOpen<cr>')
map('n', '<S-Down>', '<cmd>DiffviewFileHistory<cr>')
map('n', '}', functions.trouble_next)
map('n', '{', functions.trouble_prev)
map('n', '|', '<cmd>IBLToggle<cr>')
map('n', ',', '<Plug>(comment_toggle_linewise_current)')
map('n', 'S', '<Plug>(nvim-surround-normal)')
map('n', '<C-s>', '<Plug>(nvim-surround-change)')
map('n', 'X', '<Plug>(nvim-surround-delete)')

-- visual
map('v', '<CR>', '<cmd>Translate ja<cr>')
map('v', ',', '<Plug>(comment_toggle_linewise_visual)')
map('v', 'S', '<Plug>(nvim-surround-visual)')

-- textobject
map({ 'v', 'o' }, '<space>', function() require('illuminate').textobj_select() end)
