return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  -- filetype_exclude は ufo 本体のオプションではなく、下の autocmd 用の独自キー
  opts = {
    filetype_exclude = { 'help', 'lazy', 'mason', 'qf' },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
      pattern = opts.filetype_exclude,
      callback = function() require('ufo').detach() end,
    })

    require('ufo').setup(opts)
  end,
}
