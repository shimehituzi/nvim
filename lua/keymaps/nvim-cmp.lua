return function (cmp)
  return {
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ['<C-f>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
  }
end
