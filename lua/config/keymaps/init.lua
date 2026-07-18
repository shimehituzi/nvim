-- ============================================================================
-- キーマップの一元定義 (グローバルマップは全てこのファイルにある)
--
-- ここに無いキーマップは以下だけ:
--   - Telescope ピッカー内のキー  → lua/config/keymaps/telescope.lua
--   - 補完ポップアップのキー      → lua/config/keymaps/cmp.lua
--   - Git ハンク操作 (buffer-local) → lua/config/keymaps/gitsigns.lua
--   - Avante サイドバー内のキー   → lua/config/keymaps/avante.lua
--   - ファイルタイプ固有          → ftplugin/*.lua
-- 複数行になるアクションの実体は actions.lua / leap.lua に定義する
-- 一覧リファレンスは README.md を参照
-- ============================================================================
local map = require('config.util').map
local nummap = require('config.util').nummap
local actions = require('config.keymaps.actions')
local leap = require('config.keymaps.leap')

-- ============================================================================
-- NOP (未割当キーの明示)
-- ============================================================================
for _, key in ipairs(actions.unmapped_keys) do
  map('n', key, actions.print_unmapped_keys)
end

-- vim-illuminate の既定マップを無効化 (参照移動は J/K を使う)
map('', '<a-i>', '<nop>')
map('', '<a-n>', '<nop>')
map('', '<a-p>', '<nop>')

-- ============================================================================
-- 基本操作 (normal / visual / operator-pending)
-- ============================================================================
map('', 'j', 'gj')
map('', 'k', 'gk')
map('', 'H', '^')
map('', 'L', '$')
map('', '<C-f>', '<C-d>')
map('', '<C-d>', '<C-u>')

-- ============================================================================
-- ファイル・バッファ・ウィンドウ
-- ============================================================================
map('n', '<CR>', '<cmd>w<cr>')
map('n', 'q', '<cmd>bw<cr>')
map('n', '<C-q>', '<cmd>q<CR>')
map('n', '<S-q>', '<C-z>')
map('n', '<C-e>', '<cmd>e<cr>')
map('n', '~', '<cmd>only<cr>')
map('n', '<C-l>', '<C-w>w')
map('n', '<C-h>', '<C-w>W')
map('n', '<C-S-Down>', '<C-w>j')
map('n', '<C-S-Up>', '<C-w>k')
map('n', '<C-S-Left>', '<C-w>h')
map('n', '<C-S-Right>', '<C-w>l')
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')

-- ============================================================================
-- 編集
-- ============================================================================
map('n', '<C-p>', 'p\']')
map('v', '<C-y>', 'y\']')
map('n', 'X', 'J')
map('n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>')
map('n', '+', '~')
map('n', 'x', '"_x')
map('n', 's', '"_s')

-- マクロ
map('n', 'm', '@')
map('n', 'M', 'q')

-- 検索・ジャンプ
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '`', '<C-l><cmd>nohl<cr>')
map('n', '<BS>', '<C-o>')
map('n', '<S-BS>', '<C-i>')

-- 行選択・行移動 (Shift + 矢印)
map('n', '<S-Up>', 'Vgk')
map('v', '<S-Up>', 'gk')
map('n', '<S-Down>', 'Vgj')
map('v', '<S-Down>', 'gj')
map('n', '<S-Left>', '<cmd>move -2<cr>==', { silent = true })
map('v', '<S-Left>', ':move -2<cr>gv=gv', { silent = true })
map('n', '<S-Right>', '<cmd>move +1<cr>==', { silent = true })
map('v', '<S-Right>', ':move \'>+<cr>gv=gv', { silent = true })

-- 数字キー: 0 は無効化し、01〜09 でカウント入力できるようにする
-- (素の 1〜9 は下の LSP セクションで nummap により多重化されている)
map('n', '0', '<nop>')
for i = 1, 9 do
  map('n', '0' .. i, tostring(i))
end

-- Insert モードのカーソル移動
map('i', '<C-h>', '<C-g>U<Left>')
map('i', '<C-l>', '<C-g>U<Right>')
map('i', '<C-e>', '<C-g>U<End>')
map('i', '<C-t>', '<C-f>')

-- ============================================================================
-- テキストオブジェクト
-- ============================================================================
map({ 'v', 'o' }, 'aa', 'a>')
map({ 'v', 'o' }, 'ia', 'i>')
map({ 'v', 'o' }, 'as', 'a[')
map({ 'v', 'o' }, 'is', 'i[')
map({ 'v', 'o' }, 'ad', 'a"')
map({ 'v', 'o' }, 'id', 'i"')
map({ 'v', 'o' }, '<space>', function() require('illuminate').textobj_select() end)

-- ============================================================================
-- LSP (1〜9 は nummap: カウント入力中は数字として動く)
-- ============================================================================
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

-- 診断ジャンプ
map('n', '}', function() vim.diagnostic.jump({ count = 1, float = true }) end)
map('n', '{', function() vim.diagnostic.jump({ count = -1, float = true }) end)

-- 参照ハイライトの移動 (vim-illuminate)
map('n', 'J', function() require('illuminate').goto_next_reference() end)
map('n', 'K', function() require('illuminate').goto_prev_reference() end)

-- ============================================================================
-- Telescope
-- ============================================================================
map('n', '<Space>', function() require('telescope').extensions.file_browser.file_browser() end)
map('n', '?', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
map('n', '"', function() require('telescope.builtin').live_grep() end)
map('n', 't', function() require('telescope.builtin').builtin() end)
map('n', 'T', function() require('telescope').extensions.noice.noice() end)

-- ============================================================================
-- コメント・サラウンド・インデントガイド
-- ============================================================================
map('n', ',', '<Plug>(comment_toggle_linewise_current)')
map('v', ',', '<Plug>(comment_toggle_linewise_visual)')
map('n', 'S', '<Plug>(nvim-surround-normal-cur)')
map('v', 'S', '<Plug>(nvim-surround-visual)')
map('n', 'ys', '<Plug>(nvim-surround-normal)')
map('n', 'cs', '<Plug>(nvim-surround-change)')
map('n', 'ds', '<Plug>(nvim-surround-delete)')
map('n', '|', '<cmd>IBLToggle<cr>')

-- ============================================================================
-- f/F/t/T (leap.nvim による clever-f 風の1文字検索)
-- ============================================================================
map({ 'n', 'x', 'o' }, 'f', leap.f)
map({ 'n', 'x', 'o' }, 'F', leap.F)
-- n モードの t/T は Telescope/Noice に割当済みのため x/o のみ
map({ 'x', 'o' }, 't', leap.t)
map({ 'x', 'o' }, 'T', leap.T)

-- ============================================================================
-- DAP (デバッグ)
-- ============================================================================
map('n', '-', function() require('dap').toggle_breakpoint() end)
map('n', '_', function() require('dap').continue() end)
map('n', '*', function() require('dap').step_over() end)
map('n', '(', function() require('dap').step_out() end)
map('n', ')', function() require('dap').step_into() end)
map('n', '^', function() require('dap').terminate() end)
map('n', '&', function() require('dap').restart() end)
map('n', '!', function() require('dapui').eval() end)
map('n', '%', function() require('dapui').toggle() end)
map('n', '@', function() require('telescope').extensions.dap.commands() end)
map('n', '#', function() require('telescope').extensions.dap.frames() end)
map('n', '$', function() require('telescope').extensions.dap.list_breakpoints() end)

-- ============================================================================
-- LLM (Avante)
-- ============================================================================
map('n', '<Tab>', '<Plug>(AvanteFocus)')
map('n', '<S-Tab>', '<Plug>(AvanteSelectModel)')
map('v', '<Tab>', '<Plug>(AvanteAsk)<Esc>')
map('v', '<S-Tab>', '<Plug>(AvanteEdit)')
map('n', '<Del>', '<cmd>AvanteHistory<cr>')
map('n', '<S-Del>', actions.avante_clear_history)
map('n', '<C-c>', '<cmd>AvanteStop<cr>')

-- ============================================================================
-- 翻訳
-- ============================================================================
map('v', '<CR>', '<cmd>Translate ja<cr>')
