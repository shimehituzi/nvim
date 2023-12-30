return {
  on_attach = function(client, bufnr)
    local set = vim.keymap.set
    set("n", "<space><space>", "<cmd>lua vim.lsp.buf.hover()<CR>")
    set("n", "!", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set("n", "@", "<cmd>lua vim.lsp.buf.references()<CR>")
    set("n", "#", "<cmd>lua vim.lsp.buf.definition()<CR>")
    set("n", "$", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set("n", "'", "<cmd>lua vim.lsp.buf.format()<CR>")
    set("n", "0", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  end
}
