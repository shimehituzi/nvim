local ignored_warn_messages = {
  'position_encoding param is required in vim.lsp.util.make_position_params',
  'multiple different client offset_encodings detected',
}

local function create_ignore_routes(messages)
  local routes = {}
  for _, m in ipairs(messages) do
    table.insert(routes, {
      filter = {
        event = 'notify',
        find = m,
      },
      opts = {
        skip = true,
      },
    })
  end
  return routes
end

return {
  'folke/noice.nvim',
  -- telescope の拡張・lualine のステータス表示から参照されるため実際は起動時ロードになる
  -- (以前の event = 'VeryLazy' は依存経由で無効化されており、宣言だけの嘘だった)
  opts = {
    routes = create_ignore_routes(ignored_warn_messages),
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = { stages = 'static' },
    },
  },
}
