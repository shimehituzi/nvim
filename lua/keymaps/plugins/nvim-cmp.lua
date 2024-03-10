local cmp = package.loaded.cmp
local luasnip = package.loaded.luasnip

local luasnip_jump_next = function(fallback)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local luasnip_jump_prev = function(fallback)
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

return {
  mapping = {
    ['<C-j>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          cmp.complete()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm()
          cmp.close()
        else
          cmp.complete()
        end
      end,
    }),
    ['<C-d>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping({
      i = luasnip_jump_next,
      s = luasnip_jump_next,
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete_common_string()
        end
      end,
    }),
    ['<S-Tab>'] = cmp.mapping({
      i = luasnip_jump_prev,
      s = luasnip_jump_prev,
      c = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete_common_string()
        end
      end,
    }),
  },
}
