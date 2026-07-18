-- デフォルト値と同一の設定 (port, config パス, native_servers, on_ready, ui.wo) は削除済み
return {
  'ravitemer/mcphub.nvim',
  version = 'v6.2.0', -- 安定版に固定（2025-07-31リリース）
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'npm install -g mcp-hub@4.2.0', -- グローバルインストール（バージョン固定）
  opts = {
    auto_approve = true,
    extensions = {
      avante = {
        make_slash_commands = false,
      },
    },
    ui = {
      window = {
        width = 0.8,
        height = 0.8,
        relative = 'editor',
        zindex = 50,
        border = 'rounded',
      },
    },
    on_error = function(err) vim.notify('MCPHub error: ' .. err, vim.log.levels.ERROR) end,
  },
}
