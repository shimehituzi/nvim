-- 保存時フォーマット (このバッファ限定)
-- 以前は LspAttach をグローバルに張っていたため、rust を一度開くと
-- 全バッファで保存時フォーマットが発動するバグがあった
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('rust_format_b' .. buf, { clear = true }),
  buffer = buf,
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
