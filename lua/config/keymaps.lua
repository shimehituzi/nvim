-- ============================================================================
-- キーマップの唯一の定義ファイル
--
-- 全てのキー割当をこのファイルの一覧で管理する。動作の実装は lua/config/actions.lua。
-- ここに無いのはファイルタイプ固有の ftplugin/*.lua だけ。
-- <C-b> で which-key が一覧を表示する (説明は各エントリの desc)。
--
-- 書式: { モード, キー, 動作, desc = '説明' }
--   モード: 'n' 'v' 'i' 等を連結した文字列 ('nxo' = n+x+o)。'' は n+v+o
--   動作:   コマンド文字列 / キー文字列 / act.関数名
--   追加フィールド: silent = true / expr = true / nummap = true (下記 LSP 参照)
-- ============================================================================
local act = require('config.actions')
local M = {}

-- ============================================================================
-- 未割当キー (押すと act.print_unmapped がこの一覧を表示する)
-- ============================================================================
M.unmapped = { '<C-n>', '<C-s>', '<C-y>', '<C-z>' }

-- ============================================================================
-- グローバル
-- ============================================================================
M.global = {
  -- キーマップ一覧
  { 'n', '<C-b>', act.which_key, desc = 'キーマップの一覧を表示する' },

  -- vim-illuminate の既定マップを無効化 (参照移動は J/K を使う)
  { '', '<a-i>', '<nop>', desc = '無効 (vim-illuminate の既定キー)' },
  { '', '<a-n>', '<nop>', desc = '無効 (vim-illuminate の既定キー)' },
  { '', '<a-p>', '<nop>', desc = '無効 (vim-illuminate の既定キー)' },

  -- 基本操作
  { '', 'j', 'gj', desc = '表示行で下に移動する' },
  { '', 'k', 'gk', desc = '表示行で上に移動する' },
  { '', 'H', '^', desc = '行頭に移動する' },
  { '', 'L', '$', desc = '行末に移動する' },
  { '', '<C-f>', '<C-d>', desc = '半ページ下にスクロールする' },
  { '', '<C-d>', '<C-u>', desc = '半ページ上にスクロールする' },

  -- ファイル・バッファ・ウィンドウ
  { 'n', '<CR>', '<cmd>w<cr>', desc = 'ファイルを保存する' },
  { 'n', 'q', '<cmd>bw<cr>', desc = 'バッファを閉じる' },
  { 'n', '<C-q>', '<cmd>q<CR>', desc = 'ウィンドウを閉じる' },
  { 'n', '<S-q>', '<C-z>', desc = 'nvim を一時停止する (fg で戻る)' },
  { 'n', '<C-e>', '<cmd>e<cr>', desc = 'ファイルを読み直す' },
  { 'n', '~', '<cmd>only<cr>', desc = '他のウィンドウを全て閉じる' },
  { 'n', '<C-l>', '<C-w>w', desc = '次のウィンドウに移動する' },
  { 'n', '<C-h>', '<C-w>W', desc = '前のウィンドウに移動する' },
  { 'n', '<C-S-Down>', '<C-w>j', desc = '下のウィンドウに移動する' },
  { 'n', '<C-S-Up>', '<C-w>k', desc = '上のウィンドウに移動する' },
  { 'n', '<C-S-Left>', '<C-w>h', desc = '左のウィンドウに移動する' },
  { 'n', '<C-S-Right>', '<C-w>l', desc = '右のウィンドウに移動する' },
  { 'n', '<C-j>', '<cmd>BufferLineCycleNext<cr>', desc = '次のバッファに切り替える' },
  { 'n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>', desc = '前のバッファに切り替える' },

  -- 編集
  { 'n', '<C-p>', 'p\']', desc = '貼り付けて末尾に移動する' },
  { 'v', '<C-y>', 'y\']', desc = 'コピーして末尾に移動する' },
  { 'n', 'X', 'J', desc = '次の行を連結する' },
  { 'n', '<C-o>', '<cmd>for i in range(v:count1) | call append(line(\'.\'), \'\') | endfor<cr>', desc = '下に空行を追加する' },
  { 'n', '+', '~', desc = '大文字と小文字を切り替える' },
  { 'n', 'x', '"_x', desc = '1文字削除する (レジスタを汚さない)' },
  { 'n', 's', '"_s', desc = '1文字置き換える (レジスタを汚さない)' },

  -- マクロ
  { 'n', 'm', '@', desc = 'マクロを実行する' },
  { 'n', 'M', 'q', desc = 'マクロの記録を開始・終了する' },

  -- 検索・ジャンプ
  { 'n', 'n', 'nzz', desc = '次の検索結果に移動する' },
  { 'n', 'N', 'Nzz', desc = '前の検索結果に移動する' },
  { 'n', '`', '<C-l><cmd>nohl<cr>', desc = '検索ハイライトを消して再描画する' },
  { 'n', '<BS>', '<C-o>', desc = 'ジャンプ履歴を戻る' },
  { 'n', '<S-BS>', '<C-i>', desc = 'ジャンプ履歴を進む' },

  -- 行選択・行移動 (Shift + 矢印)
  { 'n', '<S-Up>', 'Vgk', desc = '行選択を始めて上に伸ばす' },
  { 'v', '<S-Up>', 'gk', desc = '選択を上に伸ばす' },
  { 'n', '<S-Down>', 'Vgj', desc = '行選択を始めて下に伸ばす' },
  { 'v', '<S-Down>', 'gj', desc = '選択を下に伸ばす' },
  { 'n', '<S-Left>', '<cmd>move -2<cr>==', silent = true, desc = '行を上に移動する' },
  { 'v', '<S-Left>', ':move -2<cr>gv=gv', silent = true, desc = '選択行を上に移動する' },
  { 'n', '<S-Right>', '<cmd>move +1<cr>==', silent = true, desc = '行を下に移動する' },
  { 'v', '<S-Right>', ':move \'>+<cr>gv=gv', silent = true, desc = '選択行を下に移動する' },

  -- 数字キー: 0 は無効化し、01〜09 でカウント入力できるようにする
  { 'n', '0', '<nop>', desc = '無効 (カウントは 01〜09 で入力する)' },
  { 'n', '01', '1', desc = 'カウント 1 を入力する' },
  { 'n', '02', '2', desc = 'カウント 2 を入力する' },
  { 'n', '03', '3', desc = 'カウント 3 を入力する' },
  { 'n', '04', '4', desc = 'カウント 4 を入力する' },
  { 'n', '05', '5', desc = 'カウント 5 を入力する' },
  { 'n', '06', '6', desc = 'カウント 6 を入力する' },
  { 'n', '07', '7', desc = 'カウント 7 を入力する' },
  { 'n', '08', '8', desc = 'カウント 8 を入力する' },
  { 'n', '09', '9', desc = 'カウント 9 を入力する' },

  -- Insert モードのカーソル移動
  { 'i', '<C-h>', '<C-g>U<Left>', desc = 'カーソルを左に移動する' },
  { 'i', '<C-l>', '<C-g>U<Right>', desc = 'カーソルを右に移動する' },
  { 'i', '<C-e>', '<C-g>U<End>', desc = '行末に移動する' },
  { 'i', '<C-t>', '<C-f>', desc = '行のインデントを整える' },

  -- テキストオブジェクト
  { 'vo', 'aa', 'a>', desc = '<> の外側' },
  { 'vo', 'ia', 'i>', desc = '<> の内側' },
  { 'vo', 'as', 'a[', desc = '[] の外側' },
  { 'vo', 'is', 'i[', desc = '[] の内側' },
  { 'vo', 'ad', 'a"', desc = '"" の外側' },
  { 'vo', 'id', 'i"', desc = '"" の内側' },
  { 'vo', '<space>', act.reference_select, desc = 'カーソル下の単語と同じ参照を選択する' },

  -- LSP (nummap = true の数字キーは、カウント入力中は数字として動く。実装は util.nummap)
  { 'n', ';', act.lsp_hover, desc = 'ホバー情報を表示する' },
  { 'n', '\'', act.lsp_format, desc = 'フォーマットする' },
  { 'n', '1', '<cmd>lua vim.lsp.buf.code_action()<CR>', nummap = true, desc = 'コードアクションを実行する' },
  { 'n', '2', '<cmd>lua vim.lsp.buf.rename()<CR>', nummap = true, desc = '名前を変更する' },
  { 'n', '3', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<CR>', nummap = true, desc = '定義に移動する' },
  { 'n', '4', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>', nummap = true, desc = '参照の一覧を表示する' },
  { 'n', '5', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<CR>', nummap = true, desc = '実装に移動する' },
  {
    'n',
    '6',
    '<cmd>lua require(\'telescope.builtin\').lsp_outgoing_calls()<CR>',
    nummap = true,
    desc = '呼び出している関数の一覧を表示する',
  },
  { 'n', '7', '<cmd>lua require(\'telescope.builtin\').lsp_incoming_calls()<CR>', nummap = true, desc = '呼び出し元の一覧を表示する' },
  { 'n', '8', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<CR>', nummap = true, desc = 'シンボルの一覧を表示する' },
  { 'n', '9', '<cmd>lua require(\'telescope.builtin\').diagnostics()<CR>', nummap = true, desc = '診断の一覧を表示する' },

  -- 診断ジャンプ
  { 'n', '}', act.diagnostic_next, desc = '次の診断に移動する' },
  { 'n', '{', act.diagnostic_prev, desc = '前の診断に移動する' },

  -- 参照ハイライトの移動 (vim-illuminate)
  { 'n', 'J', act.reference_next, desc = '次の参照に移動する' },
  { 'n', 'K', act.reference_prev, desc = '前の参照に移動する' },

  -- Telescope
  { 'n', '<Space>', act.file_browser, desc = 'ファイルブラウザを開く' },
  { 'n', '?', act.buffer_fuzzy_find, desc = '現在のバッファ内を検索する' },
  { 'n', '"', act.live_grep, desc = 'プロジェクト全体を文字列検索する' },
  { 'n', 't', act.picker_list, desc = 'Telescope の機能一覧を開く' },
  { 'n', 'T', act.noice_history, desc = '通知の履歴を開く' },

  -- コメント・サラウンド・インデントガイド
  { 'n', ',', '<Plug>(comment_toggle_linewise_current)', desc = '行のコメントを切り替える' },
  { 'v', ',', '<Plug>(comment_toggle_linewise_visual)', desc = '選択行のコメントを切り替える' },
  { 'n', 'S', '<Plug>(nvim-surround-normal-cur)', desc = '現在行を囲む' },
  { 'v', 'S', '<Plug>(nvim-surround-visual)', desc = '選択範囲を囲む' },
  { 'n', 'ys', '<Plug>(nvim-surround-normal)', desc = '範囲を指定して囲む' },
  { 'n', 'cs', '<Plug>(nvim-surround-change)', desc = '囲みを変更する' },
  { 'n', 'ds', '<Plug>(nvim-surround-delete)', desc = '囲みを削除する' },
  { 'n', '|', '<cmd>IBLToggle<cr>', desc = 'インデントガイドの表示を切り替える' },

  -- f/F/t/T (leap.nvim による clever-f 風の1文字検索)
  -- n モードの t/T は Telescope/Noice に割当済みのため x/o のみ
  { 'nxo', 'f', act.leap_f, desc = '前方に1文字検索する' },
  { 'nxo', 'F', act.leap_F, desc = '後方に1文字検索する' },
  { 'xo', 't', act.leap_t, desc = '前方に1文字検索して手前に止まる' },
  { 'xo', 'T', act.leap_T, desc = '後方に1文字検索して手前に止まる' },

  -- DAP (デバッグ)
  { 'n', '-', act.dap_breakpoint, desc = 'ブレークポイントを切り替える' },
  { 'n', '_', act.dap_continue, desc = 'デバッグを開始・再開する' },
  { 'n', '*', act.dap_step_over, desc = 'ステップオーバーする' },
  { 'n', '(', act.dap_step_out, desc = 'ステップアウトする' },
  { 'n', ')', act.dap_step_into, desc = 'ステップインする' },
  { 'n', '^', act.dap_terminate, desc = 'デバッグを終了する' },
  { 'n', '&', act.dap_restart, desc = 'デバッグを再起動する' },
  { 'n', '!', act.dap_eval, desc = 'カーソル下の式を評価する' },
  { 'n', '%', act.dap_ui_toggle, desc = 'デバッグ UI を開閉する' },
  { 'n', '@', act.dap_commands, desc = 'DAP のコマンド一覧を開く' },
  { 'n', '#', act.dap_frames, desc = 'スタックフレームの一覧を開く' },
  { 'n', '$', act.dap_breakpoint_list, desc = 'ブレークポイントの一覧を開く' },

  -- LLM (Avante)
  { 'n', '<Tab>', '<Plug>(AvanteFocus)', desc = 'Avante のサイドバーにフォーカスする' },
  { 'n', '<S-Tab>', '<Plug>(AvanteSelectModel)', desc = 'Avante のモデルを選択する' },
  { 'v', '<Tab>', '<Plug>(AvanteAsk)<Esc>', desc = '選択範囲について Avante に質問する' },
  { 'v', '<S-Tab>', '<Plug>(AvanteEdit)', desc = '選択範囲を Avante で編集する' },
  { 'n', '<Del>', '<cmd>AvanteHistory<cr>', desc = 'Avante の履歴を開く' },
  { 'n', '<S-Del>', act.avante_clear_history, desc = 'Avante の履歴とメモリを消去する' },
  { 'n', '<C-c>', '<cmd>AvanteStop<cr>', desc = 'Avante の生成を中断する' },

  -- 翻訳
  { 'v', '<CR>', '<cmd>Translate ja<cr>', desc = '選択範囲を日本語に翻訳する' },
}

-- ============================================================================
-- Telescope ピッカー内 (動作: 文字列 = telescope.actions の関数名)
-- ============================================================================
M.telescope = {
  { 'i', '<esc>', 'close', desc = '閉じる' },
  { 'i', '<C-q>', 'close', desc = '閉じる' },
  { 'i', '<CR>', 'select_default', desc = '開く' },
  { 'i', '<Tab>', act.telescope_select_and_resume, desc = '開いてピッカーを再開する' },
  { 'i', '<C-j>', 'move_selection_next', desc = '次の候補を選ぶ' },
  { 'i', '<C-k>', 'move_selection_previous', desc = '前の候補を選ぶ' },
  { 'i', '<Up>', 'preview_scrolling_up', desc = 'プレビューを上にスクロールする' },
  { 'i', '<Down>', 'preview_scrolling_down', desc = 'プレビューを下にスクロールする' },
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
  { 'i', '<C-h>', 'fb:goto_parent_dir', desc = '親ディレクトリに移動する' },
  { 'i', '<C-l>', 'select_default', desc = '開く' },
  { 'i', '<BS>', 'fb:backspace', desc = '文字を消す (空なら親ディレクトリへ)' },
  { 'i', '<C-s>', 'toggle_selection', desc = '選択を切り替える' },
  { 'i', '<C-a>', 'fb:create', desc = 'ファイル・ディレクトリを作成する' },
  { 'i', '<C-r>', 'fb:rename', desc = '名前を変更する' },
  { 'i', '<C-p>', 'fb:move', desc = '移動する' },
  { 'i', '<C-c>', 'fb:copy', desc = 'コピーする' },
  { 'i', '<C-d>', 'fb:remove', desc = '削除する' },
  { 'i', '<C-o>', 'fb:open', desc = 'システムの標準アプリで開く' },
  { 'i', '<C-f>', 'fb:toggle_browser', desc = 'ブラウザ表示を切り替える' },
  { 'i', '<C-z>', 'fb:toggle_hidden', desc = '隠しファイルの表示を切り替える' },
  { 'i', '<C-x>', 'fb:toggle_respect_gitignore', desc = 'gitignore の適用を切り替える' },
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
  { 'ic', '<C-j>', act.cmp_next, desc = '次の補完候補を選ぶ' },
  { 'ic', '<C-k>', act.cmp_prev, desc = '前の補完候補を選ぶ' },
  { 'ic', '<C-f>', act.cmp_accept, desc = '補完を確定する' },
  { 'ic', '<C-d>', act.cmp_dismiss, desc = '補完を閉じる' },
  { 'i', '<C-s>', act.copilot_toggle, desc = 'Copilot の自動提案を切り替える' },
  { 'is', '<Tab>', act.snippet_jump_next, desc = 'スニペットの次の入力位置に移動する' },
  { 'c', '<Tab>', act.cmdline_next, desc = '次の候補を選ぶ (コマンドライン)' },
  { 'is', '<S-Tab>', act.snippet_jump_prev, desc = 'スニペットの前の入力位置に移動する' },
  { 'c', '<S-Tab>', act.cmdline_prev, desc = '前の候補を選ぶ (コマンドライン)' },
}

-- ============================================================================
-- Git ハンク操作 (バッファ attach 時に適用。動作: 文字列 = gitsigns の関数名 / ':' 始まり = コマンド)
-- ============================================================================
M.gitsigns = {
  { 'n', '<Down>', act.hunk_next, expr = true, desc = '次の変更箇所に移動する' },
  { 'n', '<Up>', act.hunk_prev, expr = true, desc = '前の変更箇所に移動する' },
  { 'n', '<Right>', 'stage_hunk', desc = '変更箇所をステージする' },
  { 'n', '<Left>', 'preview_hunk', desc = '変更箇所をプレビューする' },
  -- undo_stage_hunk は非推奨だが、セッション内で stage を undo できる挙動のため意図的に使用
  { 'n', 'U', 'undo_stage_hunk', desc = 'ステージを取り消す' },
  { 'n', '<C-u>', 'reset_hunk', desc = '変更箇所を元に戻す' },
  { 'ox', 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = '変更箇所のテキストオブジェクト' },
}

-- ============================================================================
-- Avante サイドバー・diff 内 (形式は avante.setup の mappings 設定そのまま)
-- ============================================================================
M.avante = {
  diff = {
    ours = '1', -- 自分側の変更を採用する
    theirs = '2', -- AI 側の変更を採用する
    cursor = '3', -- カーソル位置の変更を採用する
    all_theirs = '4', -- AI 側の変更を全て採用する
    both = '5', -- 両方を残す
    next = 'J', -- 次の差分に移動する
    prev = 'K', -- 前の差分に移動する
  },
  jump = {
    next = 'J', -- 次の結果に移動する
    prev = 'K', -- 前の結果に移動する
  },
  submit = {
    normal = '<CR>', -- 送信する (ノーマルモード)
    insert = '<M-CR>', -- 送信する (挿入モード)
  },
  sidebar = {
    switch_windows = '<C-j>', -- 次のペインに移動する
    reverse_switch_windows = '<C-k>', -- 前のペインに移動する
    apply_all = 'A', -- 提案を全て適用する
    apply_cursor = 'a', -- カーソル位置の提案を適用する
    retry_user_request = 'r', -- 直前の依頼をやり直す
    edit_user_request = 'e', -- 直前の依頼を編集する
    add_file = 'a', -- ファイルを追加する (ファイル一覧で)
    remove_file = 'd', -- ファイルを外す (ファイル一覧で)
    close = { 'q' }, -- 閉じる
  },
  files = {
    add_current = '<C-t>', -- 現在のファイルを追加する
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
    vim.keymap.set('n', key, act.print_unmapped, { desc = '未割当 (押すと一覧を表示する)' })
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
