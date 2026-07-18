-- Treesitter とその構文木を使う編集支援
return {
  -- 構文ハイライト・インデント (パーサ管理)
  -- ロード: 起動時 (公式が「遅延ロード非対応」と明言し lazy = false を例示) / 操作: なし (自動適用)
  {
    'nvim-treesitter/nvim-treesitter',
    -- upstream のデフォルトブランチは main (全面書き直し版) に切り替わったため、
    -- 従来の master (nvim-treesitter.configs がある系統) を明示的に固定する
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    -- setup 対象が本体と別モジュール (nvim-treesitter.configs) のため opts ではなく config を使う
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- 括弧の自動ペア (treesitter ノードを見て挙動を変える)
  -- ロード: InsertEnter (公式推奨) / 操作: なし (入力時に自動動作)
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          javascript = { 'template_string' },
          java = false,
        },
      })

      local ts_conds = require('nvim-autopairs.ts-conds')

      npairs.add_rules({
        Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
        Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node({ 'function' })),
      })
    end,
  },

  -- HTML/JSX タグの自動クローズ
  -- ロード: 起動時 (公式が「遅延ロードは特に不要」と明言) / 操作: なし (入力時に自動動作)
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
