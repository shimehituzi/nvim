-- ============================================================================
-- キーマップの唯一の定義ファイル
--
-- 全てのキー割当をこのファイルの一覧で管理する。動作の実装は lua/config/actions.lua。
-- ここに無いのはファイルタイプ固有の ftplugin/*.lua だけ。
--
-- 書式: { モード, キー, 動作 }
--   モード: 'n' 'v' 'i' 等を連結した文字列 ('nxo' = n+x+o)。'' は n+v+o
--   動作:   コマンド文字列 / キー文字列 / act.関数名
--   追加フィールド: silent = true / expr = true / nummap = true (下記 LSP 参照)
-- ============================================================================
local act = require('config.actions')
local M = {}

-- ============================================================================
-- 未割当キー (押すと act.print_unmapped がこの一覧を表示する)
-- ============================================================================
M.unmapped = { '<C-b>', '<C-n>', '<C-s>', '<C-y>', '<C-z>' }

-- ============================================================================
-- グローバル
-- ============================================================================
M.global = {
  -- vim-illuminate の既定マップを無効化 (参照移動は J/K を使う)
  { '', '<a-i>', '<nop>' },
  { '', '<a-n>', '<nop>' },
  { '', '<a-p>', '<nop>' },

  -- 基本操作
  { '', 'j', 'gj' },
  { '', 'k', 'gk' },
  { '', 'H', '^' },
  { '', 'L', '$' },
  { '', '<C-f>', '<C-d>' },
  { '', '<C-d>', '<C-u>' },

  -- ファイル・バッファ・ウィンドウ
  { 'n', '<CR>', '<cmd>w<cr>' },
  { 'n', 'q', '<cmd>bw<cr>' },
  { 'n', '<C-q>', '<cmd>q<CR>' },
  { 'n', '<S-q>', '<C-z>' },
  { 'n', '<C-e>', '<cmd>e<cr>' },
  { 'n', '~', '<cmd>only<cr>' },
  { 'n', '<C-l>', '<C-w>w' },
  { 'n', '<C-h>', '<C-w>W' },
  { 'n', '<C-S-Down>', '<C-w>j' },
  { 'n', '<C-S-Up>', '<C-w>k' },
  { 'n', '<C-S-Left>', '<C-w>h' },
  { 'n', '<C-S-Right>', '<C-w>l' },
  { 'n', '<C-j>', '<cmd>BufferLineCycleNext<cr>' },
  { 'n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>' },

  -- 編集
  { 'n', '<C-p>', 'p\']' },
  { 'v', '<C-y>', 'y\']' },
  { 'n', 'X', 'J' },
  { 'n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>' },
  { 'n', '+', '~' },
  { 'n', 'x', '"_x' },
  { 'n', 's', '"_s' },

  -- マクロ
  { 'n', 'm', '@' },
  { 'n', 'M', 'q' },

  -- 検索・ジャンプ
  { 'n', 'n', 'nzz' },
  { 'n', 'N', 'Nzz' },
  { 'n', '`', '<C-l><cmd>nohl<cr>' },
  { 'n', '<BS>', '<C-o>' },
  { 'n', '<S-BS>', '<C-i>' },

  -- 行選択・行移動 (Shift + 矢印)
  { 'n', '<S-Up>', 'Vgk' },
  { 'v', '<S-Up>', 'gk' },
  { 'n', '<S-Down>', 'Vgj' },
  { 'v', '<S-Down>', 'gj' },
  { 'n', '<S-Left>', '<cmd>move -2<cr>==', silent = true },
  { 'v', '<S-Left>', ':move -2<cr>gv=gv', silent = true },
  { 'n', '<S-Right>', '<cmd>move +1<cr>==', silent = true },
  { 'v', '<S-Right>', ':move \'>+<cr>gv=gv', silent = true },

  -- 数字キー: 0 は無効化し、01〜09 でカウント入力できるようにする
  { 'n', '0', '<nop>' },
  { 'n', '01', '1' },
  { 'n', '02', '2' },
  { 'n', '03', '3' },
  { 'n', '04', '4' },
  { 'n', '05', '5' },
  { 'n', '06', '6' },
  { 'n', '07', '7' },
  { 'n', '08', '8' },
  { 'n', '09', '9' },

  -- Insert モードのカーソル移動
  { 'i', '<C-h>', '<C-g>U<Left>' },
  { 'i', '<C-l>', '<C-g>U<Right>' },
  { 'i', '<C-e>', '<C-g>U<End>' },
  { 'i', '<C-t>', '<C-f>' },

  -- テキストオブジェクト
  { 'vo', 'aa', 'a>' },
  { 'vo', 'ia', 'i>' },
  { 'vo', 'as', 'a[' },
  { 'vo', 'is', 'i[' },
  { 'vo', 'ad', 'a"' },
  { 'vo', 'id', 'i"' },
  { 'vo', '<space>', act.reference_select },

  -- LSP (nummap = true の数字キーは、カウント入力中は数字として動く。実装は util.nummap)
  { 'n', ';', act.lsp_hover },
  { 'n', '\'', act.lsp_format },
  { 'n', '1', '<cmd>lua vim.lsp.buf.code_action()<CR>', nummap = true },
  { 'n', '2', '<cmd>lua vim.lsp.buf.rename()<CR>', nummap = true },
  { 'n', '3', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<CR>', nummap = true },
  { 'n', '4', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>', nummap = true },
  { 'n', '5', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<CR>', nummap = true },
  { 'n', '6', '<cmd>lua require(\'telescope.builtin\').lsp_outgoing_calls()<CR>', nummap = true },
  { 'n', '7', '<cmd>lua require(\'telescope.builtin\').lsp_incoming_calls()<CR>', nummap = true },
  { 'n', '8', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<CR>', nummap = true },
  { 'n', '9', '<cmd>lua require(\'telescope.builtin\').diagnostics()<CR>', nummap = true },

  -- 診断ジャンプ
  { 'n', '}', act.diagnostic_next },
  { 'n', '{', act.diagnostic_prev },

  -- 参照ハイライトの移動 (vim-illuminate)
  { 'n', 'J', act.reference_next },
  { 'n', 'K', act.reference_prev },

  -- Telescope
  { 'n', '<Space>', act.file_browser },
  { 'n', '?', act.buffer_fuzzy_find },
  { 'n', '"', act.live_grep },
  { 'n', 't', act.picker_list },
  { 'n', 'T', act.noice_history },

  -- コメント・サラウンド・インデントガイド
  { 'n', ',', '<Plug>(comment_toggle_linewise_current)' },
  { 'v', ',', '<Plug>(comment_toggle_linewise_visual)' },
  { 'n', 'S', '<Plug>(nvim-surround-normal-cur)' },
  { 'v', 'S', '<Plug>(nvim-surround-visual)' },
  { 'n', 'ys', '<Plug>(nvim-surround-normal)' },
  { 'n', 'cs', '<Plug>(nvim-surround-change)' },
  { 'n', 'ds', '<Plug>(nvim-surround-delete)' },
  { 'n', '|', '<cmd>IBLToggle<cr>' },

  -- f/F/t/T (leap.nvim による clever-f 風の1文字検索)
  -- n モードの t/T は Telescope/Noice に割当済みのため x/o のみ
  { 'nxo', 'f', act.leap_f },
  { 'nxo', 'F', act.leap_F },
  { 'xo', 't', act.leap_t },
  { 'xo', 'T', act.leap_T },

  -- DAP (デバッグ)
  { 'n', '-', act.dap_breakpoint },
  { 'n', '_', act.dap_continue },
  { 'n', '*', act.dap_step_over },
  { 'n', '(', act.dap_step_out },
  { 'n', ')', act.dap_step_into },
  { 'n', '^', act.dap_terminate },
  { 'n', '&', act.dap_restart },
  { 'n', '!', act.dap_eval },
  { 'n', '%', act.dap_ui_toggle },
  { 'n', '@', act.dap_commands },
  { 'n', '#', act.dap_frames },
  { 'n', '$', act.dap_breakpoint_list },

  -- LLM (Avante)
  { 'n', '<Tab>', '<Plug>(AvanteFocus)' },
  { 'n', '<S-Tab>', '<Plug>(AvanteSelectModel)' },
  { 'v', '<Tab>', '<Plug>(AvanteAsk)<Esc>' },
  { 'v', '<S-Tab>', '<Plug>(AvanteEdit)' },
  { 'n', '<Del>', '<cmd>AvanteHistory<cr>' },
  { 'n', '<S-Del>', act.avante_clear_history },
  { 'n', '<C-c>', '<cmd>AvanteStop<cr>' },

  -- 翻訳
  { 'v', '<CR>', '<cmd>Translate ja<cr>' },
}

-- ============================================================================
-- Telescope ピッカー内 (動作: 文字列 = telescope.actions の関数名)
-- ============================================================================
M.telescope = {
  { 'i', '<esc>', 'close' },
  { 'i', '<C-q>', 'close' },
  { 'i', '<CR>', 'select_default' },
  { 'i', '<Tab>', act.telescope_select_and_resume },
  { 'i', '<C-j>', 'move_selection_next' },
  { 'i', '<C-k>', 'move_selection_previous' },
  { 'i', '<Up>', 'preview_scrolling_up' },
  { 'i', '<Down>', 'preview_scrolling_down' },
}

-- 既定マップの無効化一覧 (使うキーだけを上の一覧で定義し直す方針)
M.telescope_disabled = {
  i = {
    '<C-n>',
    '<C-p>',
    '<C-c>',
    '<Down>',
    '<Up>',
    '<CR>',
    '<C-x>',
    '<C-v>',
    '<C-t>',
    '<C-u>',
    '<C-d>',
    '<PageUp>',
    '<PageDown>',
    '<Tab>',
    '<S-Tab>',
    '<M-q>',
    '<C-l>',
    '<C-/>',
    '<C-_>',
    '<C-w>',
    '<C-q>',
    '<C-j>',
  },
  n = {
    '<esc>',
    '<CR>',
    '<C-x>',
    '<C-v>',
    '<C-t>',
    '<Tab>',
    '<S-Tab>',
    '<C-q>',
    '<M-q>',
    'j',
    'k',
    'H',
    'M',
    'L',
    '<Down>',
    '<Up>',
    'gg',
    'G',
    '<C-u>',
    '<C-d>',
    '<PageUp>',
    '<PageDown>',
    '?',
  },
}

-- ============================================================================
-- Telescope ファイルブラウザ内 (動作: 'fb:' 付き = file_browser 拡張、それ以外 = telescope.actions)
-- ============================================================================
M.telescope_file_browser = {
  { 'i', '<C-h>', 'fb:goto_parent_dir' },
  { 'i', '<C-l>', 'select_default' },
  { 'i', '<BS>', 'fb:backspace' },
  { 'i', '<C-s>', 'toggle_selection' },
  { 'i', '<C-a>', 'fb:create' },
  { 'i', '<C-r>', 'fb:rename' },
  { 'i', '<C-p>', 'fb:move' },
  { 'i', '<C-c>', 'fb:copy' },
  { 'i', '<C-d>', 'fb:remove' },
  { 'i', '<C-o>', 'fb:open' },
  { 'i', '<C-f>', 'fb:toggle_browser' },
  { 'i', '<C-z>', 'fb:toggle_hidden' },
  { 'i', '<C-x>', 'fb:toggle_respect_gitignore' },
}

M.telescope_file_browser_disabled = {
  i = {
    '<A-c>',
    '<S-CR>',
    '<A-r>',
    '<A-m>',
    '<A-y>',
    '<A-d>',
    '<C-o>',
    '<C-g>',
    '<C-e>',
    '<C-w>',
    '<C-t>',
    '<C-f>',
    '<C-h>',
    '<C-s>',
    '<bs>',
  },
  n = {
    'c',
    'r',
    'm',
    'y',
    'd',
    'o',
    'g',
    'e',
    'w',
    't',
    'f',
    'h',
    's',
  },
}

-- ============================================================================
-- 補完ポップアップ内 (nvim-cmp + Copilot。モード: i=挿入 c=コマンドライン s=スニペット選択)
-- ============================================================================
M.cmp = {
  { 'ic', '<C-j>', act.cmp_next },
  { 'ic', '<C-k>', act.cmp_prev },
  { 'ic', '<C-f>', act.cmp_accept },
  { 'ic', '<C-d>', act.cmp_dismiss },
  { 'i', '<C-s>', act.copilot_toggle },
  { 'is', '<Tab>', act.snippet_jump_next },
  { 'c', '<Tab>', act.cmdline_next },
  { 'is', '<S-Tab>', act.snippet_jump_prev },
  { 'c', '<S-Tab>', act.cmdline_prev },
}

-- ============================================================================
-- Git ハンク操作 (バッファ attach 時に適用。動作: 文字列 = gitsigns の関数名 / ':' 始まり = コマンド)
-- ============================================================================
M.gitsigns = {
  { 'n', '<Down>', act.hunk_next, expr = true },
  { 'n', '<Up>', act.hunk_prev, expr = true },
  { 'n', '<Right>', 'stage_hunk' },
  { 'n', '<Left>', 'preview_hunk' },
  -- undo_stage_hunk は非推奨だが、セッション内で stage を undo できる挙動のため意図的に使用
  { 'n', 'U', 'undo_stage_hunk' },
  { 'n', '<C-u>', 'reset_hunk' },
  { 'ox', 'ih', ':<C-U>Gitsigns select_hunk<CR>' },
}

-- ============================================================================
-- Avante サイドバー・diff 内 (形式は avante.setup の mappings 設定そのまま)
-- ============================================================================
M.avante = {
  diff = {
    ours = '1',
    theirs = '2',
    cursor = '3',
    all_theirs = '4',
    both = '5',
    next = 'J',
    prev = 'K',
  },
  jump = {
    next = 'J',
    prev = 'K',
  },
  submit = {
    normal = '<CR>',
    insert = '<M-CR>',
  },
  sidebar = {
    switch_windows = '<C-j>',
    reverse_switch_windows = '<C-k>',
    apply_all = 'A',
    apply_cursor = 'a',
    retry_user_request = 'r',
    edit_user_request = 'e',
    add_file = 'a',
    remove_file = 'd',
    close = { 'q' },
  },
  files = {
    add_current = '<C-t>',
  },
}

-- ============================================================================
-- 適用と各プラグインへの変換 (ここから下は一覧の書式を変えない限り触らなくてよい)
-- ============================================================================

-- モード文字列をテーブルへ ('nxo' → {'n','x','o'}。'' はそのまま)
local function modes(s) return #s <= 1 and s or vim.split(s, '') end

-- グローバルキーマップを適用する (config/init.lua から、プラグイン読み込み後に呼ばれる)
function M.apply()
  local nummap = require('config.util').nummap
  for _, e in ipairs(M.global) do
    if e.nummap then
      nummap(e[1], e[2], e[3], { desc = e.desc })
    else
      vim.keymap.set(modes(e[1]), e[2], e[3], { silent = e.silent, expr = e.expr, desc = e.desc })
    end
  end
  for _, key in ipairs(M.unmapped) do
    vim.keymap.set('n', key, act.print_unmapped)
  end
end

-- telescope.setup 用の mappings テーブルを組み立てる
function M.telescope_mappings()
  local actions = require('telescope.actions')
  -- この参照は file_browser 拡張を空設定で先行 setup させる (telescope の extension manager の仕様)。
  -- 実際の設定は plugins/telescope.lua の load_extension('file_browser') で上書き適用される
  local fb_actions = require('telescope').extensions.file_browser.actions

  local function resolve(action)
    if type(action) ~= 'string' then return action end
    local fb_name = action:match('^fb:(.+)$')
    return fb_name and fb_actions[fb_name] or actions[action]
  end

  local function build(entries, disabled)
    local t = { i = {}, n = {} }
    for mode, keys in pairs(disabled) do
      for _, key in ipairs(keys) do
        t[mode][key] = false
      end
    end
    for _, e in ipairs(entries) do
      t[e[1]][e[2]] = resolve(e[3])
    end
    return t
  end

  return {
    defaults = build(M.telescope, M.telescope_disabled),
    file_browser = build(M.telescope_file_browser, M.telescope_file_browser_disabled),
  }
end

-- nvim-cmp の mapping テーブルを組み立てる (cmp.mapping(fn, modes) と同じ {モード=関数} 形式)
function M.cmp_mapping()
  local t = {}
  for _, e in ipairs(M.cmp) do
    t[e[2]] = t[e[2]] or {}
    for mode in e[1]:gmatch('.') do
      t[e[2]][mode] = e[3]
    end
  end
  return t
end

-- gitsigns の on_attach (バッファローカルにハンク操作キーを設定する)
function M.gitsigns_on_attach(bufnr)
  local gs = require('gitsigns')
  for _, e in ipairs(M.gitsigns) do
    local rhs = e[3]
    if type(rhs) == 'string' and not rhs:find('^:') then rhs = gs[rhs] end
    vim.keymap.set(modes(e[1]), e[2], rhs, { buffer = bufnr, expr = e.expr, desc = e.desc })
  end
end

return M
