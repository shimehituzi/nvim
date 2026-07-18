-- 複数行になるキーマップ用アクションの定義 (キー割当は lua/config/keymaps/init.lua)
local M = {}

-- NOP にしている未割当キーの一覧 (押すとこの一覧を表示する)
M.unmapped_keys = { '<C-b>', '<C-n>', '<C-s>', '<C-y>', '<C-z>' }

function M.print_unmapped_keys() print('These keys are not mapped: ' .. table.concat(M.unmapped_keys, ' ')) end

-- Avante の履歴とメモリを確認ダイアログ付きで消去する
function M.avante_clear_history()
  if vim.fn.confirm('Avante: Are you sure you want to clear history and memory?', '&Yes\n&No', 2) == 1 then
    vim.cmd('AvanteClear history')
    vim.cmd('AvanteClear cache')
  end
end

return M
