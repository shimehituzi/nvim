-- キーマップ動作の実装 (キー割当の一覧は lua/config/keymaps.lua)
-- どの関数も必要なモジュールを呼び出し時に require するため、
-- このファイル自体はいつ require しても副作用がない
local A = {}

-- ============================================================================
-- 未割当キー (押すと一覧を表示する)
-- ============================================================================
function A.print_unmapped()
  local keys = require('config.keymaps').unmapped
  print('These keys are not mapped: ' .. table.concat(keys, ' '))
end

-- ============================================================================
-- LSP・診断
-- ============================================================================
function A.lsp_hover() vim.lsp.buf.hover() end

function A.lsp_format() vim.lsp.buf.format() end

function A.diagnostic_next() vim.diagnostic.jump({ count = 1, float = true }) end

function A.diagnostic_prev() vim.diagnostic.jump({ count = -1, float = true }) end

-- ============================================================================
-- vim-illuminate (カーソル下の単語の参照)
-- ============================================================================
function A.reference_next() require('illuminate').goto_next_reference() end

function A.reference_prev() require('illuminate').goto_prev_reference() end

function A.reference_select() require('illuminate').textobj_select() end

-- ============================================================================
-- Telescope
-- ============================================================================
function A.file_browser() require('telescope').extensions.file_browser.file_browser() end

function A.buffer_fuzzy_find() require('telescope.builtin').current_buffer_fuzzy_find() end

function A.live_grep() require('telescope.builtin').live_grep() end

function A.picker_list() require('telescope.builtin').builtin() end

function A.noice_history() require('telescope').extensions.noice.noice() end

-- ピッカー内: 項目を開いた後すぐ同じピッカーを再開する
function A.telescope_select_and_resume(prompt_bufnr)
  require('telescope.actions').select_default(prompt_bufnr)
  require('telescope.builtin').resume()
end

-- ============================================================================
-- leap.nvim (f/F/t/T の1文字検索)
-- ============================================================================
local function leap_ft(kwargs)
  require('leap').leap(vim.tbl_deep_extend('keep', kwargs, {
    inputlen = 1,
    inclusive = true,
    opts = {
      -- Force autojump.
      labels = '',
      -- Match the modes where you don't need labels (`:h mode()`).
      safe_labels = vim.fn.mode(1):match('no?') and '' or nil,
    },
  }))
end

-- トリガーキー自身でリピートできるようにするテーブル (clever-f 風)。初回呼び出し時に生成
local clever_f, clever_t

local function get_clever_f()
  clever_f = clever_f or require('leap.user').with_traversal_keys('f', 'F')
  return clever_f
end

local function get_clever_t()
  clever_t = clever_t or require('leap.user').with_traversal_keys('t', 'T')
  return clever_t
end

function A.leap_f() leap_ft({ opts = get_clever_f() }) end

function A.leap_F() leap_ft({ backward = true, opts = get_clever_f() }) end

function A.leap_t() leap_ft({ offset = -1, opts = get_clever_t() }) end

function A.leap_T() leap_ft({ backward = true, offset = 1, opts = get_clever_t() }) end

-- ============================================================================
-- DAP (デバッグ)
-- ============================================================================
function A.dap_breakpoint() require('dap').toggle_breakpoint() end

function A.dap_continue() require('dap').continue() end

function A.dap_step_over() require('dap').step_over() end

function A.dap_step_out() require('dap').step_out() end

function A.dap_step_into() require('dap').step_into() end

function A.dap_terminate() require('dap').terminate() end

function A.dap_restart() require('dap').restart() end

function A.dap_eval() require('dapui').eval() end

function A.dap_ui_toggle() require('dapui').toggle() end

function A.dap_commands() require('telescope').extensions.dap.commands() end

function A.dap_frames() require('telescope').extensions.dap.frames() end

function A.dap_breakpoint_list() require('telescope').extensions.dap.list_breakpoints() end

-- ============================================================================
-- Avante
-- ============================================================================
function A.avante_clear_history()
  if vim.fn.confirm('Avante: Are you sure you want to clear history and memory?', '&Yes\n&No', 2) == 1 then
    vim.cmd('AvanteClear history')
    vim.cmd('AvanteClear cache')
  end
end

-- ============================================================================
-- 補完ポップアップ内 (nvim-cmp + Copilot。cmp から呼ばれる)
-- ============================================================================
function A.cmp_next()
  local cmp = require('cmp')
  local copilot = require('copilot.suggestion')
  if cmp.visible() then
    cmp.select_next_item()
  elseif copilot.is_visible() then
    copilot.next()
  else
    cmp.complete()
  end
end

function A.cmp_prev()
  local cmp = require('cmp')
  local copilot = require('copilot.suggestion')
  if cmp.visible() then
    cmp.select_prev_item()
  elseif copilot.is_visible() then
    copilot.prev()
  else
    cmp.complete()
  end
end

function A.cmp_accept()
  local cmp = require('cmp')
  local copilot = require('copilot.suggestion')
  if cmp.visible() then
    cmp.confirm({ select = true })
  elseif copilot.is_visible() then
    copilot.accept()
  else
    cmp.complete()
  end
end

function A.cmp_dismiss()
  local cmp = require('cmp')
  local copilot = require('copilot.suggestion')
  if cmp.visible() then
    cmp.abort()
  elseif copilot.is_visible() then
    copilot.dismiss()
  else
    copilot.next()
  end
end

function A.copilot_toggle()
  local copilot = require('copilot.suggestion')
  copilot.toggle_auto_trigger()
  if vim.b.copilot_suggestion_auto_trigger then
    copilot.next()
    print('copilot suggestion enabled')
  else
    if copilot.is_visible() then copilot.dismiss() end
    print('copilot suggestion disabled')
  end
end

function A.snippet_jump_next(fallback)
  local ls = package.loaded.luasnip
  if ls and ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    fallback()
  end
end

function A.snippet_jump_prev(fallback)
  local ls = package.loaded.luasnip
  if ls and ls.jumpable(-1) then
    ls.jump(-1)
  else
    fallback()
  end
end

function A.cmdline_next()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete_common_string()
  end
end

function A.cmdline_prev()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_prev_item()
  else
    cmp.complete_common_string()
  end
end

-- ============================================================================
-- gitsigns (ハンク移動。diff モード中は標準の ]c / [c に任せる)
-- ============================================================================
function A.hunk_next()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() require('gitsigns').nav_hunk('next') end)
  return '<Ignore>'
end

function A.hunk_prev()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() require('gitsigns').nav_hunk('prev') end)
  return '<Ignore>'
end

return A
