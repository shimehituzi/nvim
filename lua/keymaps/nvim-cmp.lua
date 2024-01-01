local cmp = package.loaded.cmp
return {
  mapping = {
    ["<C-j>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, {'i', 'c'}),
    ["<C-k>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end, {'i', 'c'}),
    ['<CR>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end, {'i', 'c'}),
    ['<Esc>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end, {'i', 'c'}),
  }
}
