local cmp = package.loaded.cmp
local luasnip = package.loaded.luasnip
local copilot = package.loaded['copilot.suggestion']

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
      elseif copilot.is_visible() then
        copilot.next()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif copilot.is_visible() then
        copilot.prev()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif copilot.is_visible() then
        copilot.accept()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      elseif copilot.is_visible() then
        copilot.dismiss()
      end
    end, { 'i', 'c' }),
    ['<C-g>'] = cmp.mapping(function()
      if copilot.is_visible() then
        if cmp.visible() then
          cmp.abort()
        end
        copilot.accept_word()
      end
    end, { 'i' }),
    ['<C-t>'] = cmp.mapping(function()
      if copilot.is_visible() then
        if cmp.visible() then
          cmp.abort()
        end
        copilot.accept_line()
      end
    end, { 'i' }),
    ['<C-s>'] = cmp.mapping(function()
      if copilot.is_visible() then copilot.dismiss() end
      copilot.toggle_auto_trigger()
    end, { 'i' }),
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
