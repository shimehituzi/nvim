return {
  'zapling/mason-lock.nvim',
  -- mason.nvim ^1.0.0 の API (コールバック形式の get_installed_version) 対応の最終コミット。
  -- mason を 2.x に上げるときはこの固定を外す
  commit = '86614f7',
  dependencies = { 'mason-org/mason.nvim' },
  opts = {
    lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json',
  },
}
