local map = require('utils').map

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
map('n', 'q', '<cmd>bwipeout<cr><cmd>clearjumps<cr>')
map('n', '<C-q>', '<cmd>q<CR>')
map('n', '<S-q>', '<C-z>')
map('n', '<C-l>', '<C-w>w')
map('n', '<C-h>', '<C-w>W')
map('n', '<C-p>', "p']")
map('n', '-', 'G')
map('n', 'm', '@')
map('n', 'M', 'q')
map('n', 't', '<C-a>')
map('n', 'T', '<C-x>')
map('n', '`', '<C-l><cmd>nohl<cr>')
map('n', 'G', '~')
map('n', 'U', 'J')
map('n', '<space>o', "<cmd>for i in range(v:count1) | call append(line('.'), '') | endfor<cr>")
map('n', '<space>O', "<cmd>for i in range(v:count1) | call append(line('.')-1, '') | endfor<cr>")
map('n', '<S-Tab>', '<C-i>')
map('n', '<BS>', '<C-o>')
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('n', 's', '"_s')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<S-Up>', '<cmd>m.-2<cr>')
map('n', '<S-Down>', '<cmd>m.+1<cr>')

-- visual
map('v', '<C-y>', "y']")

-- operator-pending
map('o', 'aa', 'a>')
map('o', 'ia', 'i>')
map('o', 'as', 'a[')
map('o', 'is', 'i[')
map('o', 'ad', 'a"')
map('o', 'id', 'i"')
map('v', 'aa', 'a>')
map('v', 'ia', 'i>')
map('v', 'as', 'a[')
map('v', 'is', 'i[')
map('v', 'ad', 'a"')
map('v', 'id', 'i"')

-- insert
map('i', '<C-h>', '<C-g>U<Left>')
map('i', '<C-l>', '<C-g>U<Right>')
map('i', '<C-e>', '<C-g>U<End>')
map('i', '<C-d>', '<Del>')

-- **PLUGINS**
-- normal
map('n', ';', '<cmd>Neotree float<cr>')
map('n', '<C-j>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<C-k>', '<cmd>BufferLineCyclePrev<cr>')
map('n', '<S-j>', '<cmd>BufferLineMoveNext<cr>')
map('n', '<S-k>', '<cmd>BufferLineMovePrev<cr>')
map('n', '^', '<cmd>IBLToggle<cr>')
map('n', '&', '<cmd>TroubleToggle<cr>')
map('n', '}', function()
  local trouble = require('trouble')
  if not(trouble.is_open()) then
    trouble.open()
  end
  trouble.next({ skip_groups = true, jump = true })
end)
map('n', '{', function()
  local trouble = require('trouble')
  if not(trouble.is_open()) then
    trouble.open()
  end
  trouble.previous({ skip_groups = true, jump = true })
end)

-- other
-- plugins/lsp/nvim-lspconfig.lua
-- plugins/lsp/nvim-cmp.lua
-- plugins/ui/neo-tree.lua
-- plugins/git/gitsigns.lua
-- plugins/git/gitsigns.lua
-- plugins/git/diffview.lua
