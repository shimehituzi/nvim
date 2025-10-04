vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function(event)
    if vim.bo[event.buf].filetype == 'help' then vim.cmd.wincmd('L') end
  end,
})

local function apply_transparent_background()
  local function set_border(group)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    local opts = { bg = 'NONE', ctermbg = 'NONE' }
    if ok then
      if hl.fg then opts.fg = hl.fg end
      if hl.ctermfg then opts.ctermfg = hl.ctermfg end
    end
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

  set_border('FloatBorder')
  local avante_borders = {
    'AvanteSidebarWinSeparator',
    'AvanteSidebarWinHorizontalSeparator',
    'AvantePromptInputBorder',
  }
  local telescope_borders = {
    'TelescopeBorder',
    'TelescopePromptBorder',
    'TelescopeResultsBorder',
    'TelescopePreviewBorder',
  }
  for _, group in ipairs(telescope_borders) do
    set_border(group)
  end
  for _, group in ipairs(avante_borders) do
    set_border(group)
  end
end

vim.schedule(apply_transparent_background)

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.schedule(apply_transparent_background)
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.schedule(apply_transparent_background)
  end,
})
