local augroup = vim.api.nvim_create_augroup('user_autocmds', { clear = true })

-- help はいつも右分割で開く
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  pattern = '*',
  callback = function(event)
    if vim.bo[event.buf].filetype == 'help' then vim.cmd.wincmd('L') end
  end,
})

-- 透過背景の適用 (カラースキームが上書きするたびに再適用する)
local function apply_transparent_background()
  local function set_border(group)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    local opts = { bg = 'NONE', ctermbg = 'NONE' }
    if hl.fg then opts.fg = hl.fg end
    if hl.ctermfg then opts.ctermfg = hl.ctermfg end
    vim.api.nvim_set_hl(0, group, opts)
  end

  local groups = {
    'Normal',
    'NormalNC',
    'NormalFloat',
    'SignColumn',
    'EndOfBuffer',
    'TelescopeNormal',
    'TelescopePromptNormal',
    'TelescopeResultsNormal',
    'TelescopePreviewNormal',
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
  end

  local borders = {
    'FloatBorder',
    'TelescopeBorder',
    'TelescopePromptBorder',
    'TelescopeResultsBorder',
    'TelescopePreviewBorder',
    'AvanteSidebarWinSeparator',
    'AvanteSidebarWinHorizontalSeparator',
    'AvantePromptInputBorder',
  }
  for _, group in ipairs(borders) do
    set_border(group)
  end
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = augroup,
  callback = function() vim.schedule(apply_transparent_background) end,
})
