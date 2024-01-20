return {
  toggle_docment_symble = function()
    if vim.bo.filetype == "neo-tree" then
      local full_path = vim.api.nvim_buf_get_name(0)
      local filename_only = full_path:match("^.+/(.+)$")
      if filename_only
          and filename_only:find("neo%-tree")
          and not filename_only:find("document_symbols")
      then
        vim.cmd('Neotree close')
      end
    end
    vim.cmd('Neotree document_symbols right toggle')
  end,
  trouble_next = function()
    local trouble = require('trouble')
    if not (trouble.is_open()) then
      trouble.open()
    end
    trouble.next({ skip_groups = true, jump = true })
  end,
  trouble_prev = function()
    local trouble = require('trouble')
    if not (trouble.is_open()) then
      trouble.open()
    end
    trouble.previous({ skip_groups = true, jump = true })
  end,
}
