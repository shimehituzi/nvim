local map = require('utils').map
local nummap = require('utils').nummap
local builtin = require('telescope.builtin')
local extnsions = require('telescope').extensions


-- **NOP**
local noplist = {
  '!', '@', '#', '$', '%', '^', '&', '*',
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
map('', '-', 'G')
map('', '_', 'gg')
map('', '<C-f>', '<C-d>')
map('', '<C-d>', '<C-u>')

-- normal
map('n', '<CR>', '<cmd>w<cr>')
map('n', 'q', '<cmd>bw<cr>')
map('n', '<C-q>', '<cmd>q<CR>')
map('n', '<S-q>', '<C-z>')
map('n', '<C-l>', '<C-w>w')
map('n', '<C-h>', '<C-w>W')
map('n', '<C-p>', 'p\']')
map('n', 'm', '@')
map('n', 'M', 'q')
map('n', ')', '<C-a>')
map('n', '(', '<C-x>')
map('n', '`', '<C-l><cmd>nohl<cr>')
map('n', '~', '<cmd>only<cr>')
map('n', 'X', 'J')
map('n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>')
map('n', '<BS>', '<C-o>')
map('n', '<Del>', '<C-i>')
map('n', 't', '~')
map('n', 'T', '"zx"zp<cmd>let @z=@_<cr>')
map('n', 'x', '"_x')
map('n', 's', '"_s')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<S-Up>', 'Vgk')
map('v', '<S-Up>', 'gk')
map('n', '<S-Down>', 'Vgj')
map('v', '<S-Down>', 'gj')
map('n', '<S-Left>', '<cmd>move -2<cr>==', { silent = true })
map('v', '<S-Left>', ':move -2<cr>gv=gv', { silent = true })
map('n', '<S-Right>', '<cmd>move +1<cr>==', { silent = true })
map('v', '<S-Right>', ':move \'>+<cr>gv=gv', { silent = true })
map('n', '<C-S-Down>', '<C-w>j')
map('n', '<C-S-Up>', '<C-w>k')
map('n', '<C-S-Left>', '<C-w>h')
map('n', '<C-S-Right>', '<C-w>l')
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
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'J', function() require('illuminate').goto_next_reference() end)
map('n', 'K', function() require('illuminate').goto_prev_reference() end)
map('n', ';', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '\'', '<cmd>lua vim.lsp.buf.format()<CR>')
map('n', '"', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '?', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '}', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '{', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', 'f', builtin.lsp_definitions)
map('n', 'F', builtin.lsp_references)
map('n', '<Space>', extnsions.file_browser.file_browser)
map('n', '<Tab>', builtin.resume)
map('n', '<S-Tab>', builtin.resume)
nummap('n', '1', '<cmd>lua require(\'telescope.builtin\').git_status()<CR>')
nummap('n', '2', '<cmd>lua require(\'telescope.builtin\').registers()<CR>')
nummap('n', '3', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>')
nummap('n', '4', '<cmd>lua require(\'telescope.builtin\').current_buffer_fuzzy_find()<CR>')
nummap('n', '5', '<cmd>lua require(\'telescope.builtin\').jumplist()<CR>')
nummap('n', '6', '<cmd>lua require(\'telescope.builtin\').builtin()<CR>')
nummap('n', '7', '<cmd>lua require(\'telescope\').extensions.noice.noice()<CR>')
nummap('n', '8', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<CR>')
nummap('n', '9', '<cmd>lua require(\'telescope.builtin\').diagnostics()<CR>')
map('n', ',', '<Plug>(comment_toggle_linewise_current)')
map('n', 'S', '<Plug>(nvim-surround-normal-cur)')
map('n', 'ys', '<Plug>(nvim-surround-normal)')
map('n', 'cs', '<Plug>(nvim-surround-change)')
map('n', 'ds', '<Plug>(nvim-surround-delete)')
map('n', '+', '<cmd>Neotree filesystem reveal right toggle<cr>')
map('n', '|', '<cmd>IBLToggle<cr>')

-- visual
map('v', '<CR>', '<cmd>Translate ja<cr>')
map('v', ',', '<Plug>(comment_toggle_linewise_visual)')
map('v', 'S', '<Plug>(nvim-surround-visual)')

-- textobject
map({ 'v', 'o' }, '<space>', function() require('illuminate').textobj_select() end)
