-- 保存時フォーマット (このバッファ限定)
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('user_rust_format_b' .. buf, { clear = true }),
  buffer = buf,
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
