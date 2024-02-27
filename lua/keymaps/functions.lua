return {
  toggle_qf = function()
    local is_quickfix_open = false
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, wininfo in ipairs(vim.fn.getwininfo()) do
      if wininfo.quickfix == 1 then
        is_quickfix_open = true
        break
      end
    end

    if is_quickfix_open then
      vim.cmd('cclose')
    else
      vim.cmd('copen')
      vim.cmd('wincmd p')
    end
  end
}
