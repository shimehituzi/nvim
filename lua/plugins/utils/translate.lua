return {
  'uga-rosa/translate.nvim',
  -- 注意: 以前は `defauls` (typo) キーで設定していたため設定全体が無視され、
  -- 実際はデフォルトの google エンジンで動いていた。挙動維持のため設定は空にしてある。
  -- translate-shell (brew の trans) を使いたい場合:
  --   opts = { default = { command = 'translate_shell' } }
  opts = {},
}
