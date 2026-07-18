local map = require('utils').map
local nummap = require('utils').nummap

-- **NOP**
local noplist = {
  '<C-b>',
  '<C-n>',
  '<C-s>',
  '<C-y>',
  '<C-z>',
}
for _, m in ipairs(noplist) do
  map('n', m, function() print('These keys are not mapped: ' .. table.concat(noplist, ' ')) end)
end

-- **BASIC**
-- normal, visual, operator-pending
map('', 'j', 'gj')
map('', 'k', 'gk')
map('', 'H', '^')
map('', 'L', '$')
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
map('n', '`', '<C-l><cmd>nohl<cr>')
map('n', '<C-e>', '<cmd>e<cr>')
map('n', '~', '<cmd>only<cr>')
map('n', 'X', 'J')
map('n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>')
map('n', '<BS>', '<C-o>')
map('n', '<S-BS>', '<C-i>')
map('n', '+', '~')
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
map('i', '<C-t>', '<C-f>')

-- textobject
map({ 'v', 'o' }, 'aa', 'a>')
map({ 'v', 'o' }, 'ia', 'i>')
map({ 'v', 'o' }, 'as', 'a[')
map({ 'v', 'o' }, 'is', 'i[')
map({ 'v', 'o' }, 'ad', 'a"')
map({ 'v', 'o' }, 'id', 'i"')

-- **PLUGINS**
-- プラグイン参照はすべてクロージャで遅延取得する (読み込み順への依存をなくすため)
-- normal
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'J', function() require('illuminate').goto_next_reference() end)
map('n', 'K', function() require('illuminate').goto_prev_reference() end)
map('n', '<Space>', function() require('telescope').extensions.file_browser.file_browser() end)
map('n', ';', function() vim.lsp.buf.hover() end)
map('n', '\'', function() vim.lsp.buf.format() end)
nummap('n', '1', '<cmd>lua vim.lsp.buf.code_action()<CR>')
nummap('n', '2', '<cmd>lua vim.lsp.buf.rename()<CR>')
nummap('n', '3', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<CR>')
nummap('n', '4', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>')
nummap('n', '5', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<CR>')
nummap('n', '6', '<cmd>lua require(\'telescope.builtin\').lsp_outgoing_calls()<CR>')
nummap('n', '7', '<cmd>lua require(\'telescope.builtin\').lsp_incoming_calls()<CR>')
nummap('n', '8', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<CR>')
nummap('n', '9', '<cmd>lua require(\'telescope.builtin\').diagnostics()<CR>')
-- vim.diagnostic.goto_next/prev は非推奨 (nvim 0.11+) のため jump に置き換え
map('n', '}', function() vim.diagnostic.jump({ count = 1, float = true }) end)
map('n', '{', function() vim.diagnostic.jump({ count = -1, float = true }) end)
map('n', '?', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
map('n', '"', function() require('telescope.builtin').live_grep() end)
map('n', 'T', function() require('telescope').extensions.noice.noice() end)
map('n', 't', function() require('telescope.builtin').builtin() end)
map('n', ',', '<Plug>(comment_toggle_linewise_current)')
map('n', 'S', '<Plug>(nvim-surround-normal-cur)')
map('n', 'ys', '<Plug>(nvim-surround-normal)')
map('n', 'cs', '<Plug>(nvim-surround-change)')
map('n', 'ds', '<Plug>(nvim-surround-delete)')
map('n', '|', '<cmd>IBLToggle<cr>')

map('n', '!', function() require('dapui').eval() end)
map('n', '@', function() require('telescope').extensions.dap.commands() end)
map('n', '#', function() require('telescope').extensions.dap.frames() end)
map('n', '$', function() require('telescope').extensions.dap.list_breakpoints() end)
map('n', '%', function() require('dapui').toggle() end)
map('n', '^', function() require('dap').terminate() end)
map('n', '&', function() require('dap').restart() end)
map('n', '*', function() require('dap').step_over() end)
map('n', '(', function() require('dap').step_out() end)
map('n', ')', function() require('dap').step_into() end)
map('n', '-', function() require('dap').toggle_breakpoint() end)
map('n', '_', function() require('dap').continue() end)

-- visual
map('v', ',', '<Plug>(comment_toggle_linewise_visual)')
map('v', 'S', '<Plug>(nvim-surround-visual)')
map('v', '<CR>', '<cmd>Translate ja<cr>')

-- textobject
map({ 'v', 'o' }, '<space>', function() require('illuminate').textobj_select() end)
