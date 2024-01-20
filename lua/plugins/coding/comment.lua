---@diagnostic disable: missing-fields, assign-type-mismatch
return {
  'numToStr/Comment.nvim',
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require('Comment').setup({
      padding = true,
      sticky = true,
      ignore = nil,
      mappings = {
        basic = false,
        extra = false,
      },
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      post_hook = nil,
    })
  end
}
