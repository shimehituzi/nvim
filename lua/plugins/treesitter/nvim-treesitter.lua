return {
  'nvim-treesitter/nvim-treesitter',
  -- upstream のデフォルトブランチは main (全面書き直し版) に切り替わったため、
  -- 従来の master (nvim-treesitter.configs がある系統) を明示的に固定する
  branch = 'master',
  build = ':TSUpdate',
  -- main は setup 対象モジュールが本体と別なので opts 化せず config を維持する
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      -- ensure_installed='all' のため auto_install は発火余地がなく削除済み
      ensure_installed = 'all',
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
