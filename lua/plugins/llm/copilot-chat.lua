return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      local prompts = require('CopilotChat.prompts')
      local select = require('CopilotChat.select')

      local lang_prompt = ' MUST ANSWER IN JAPANESE.'
      local lang_prompt_commit =
        'The gitcommit block must be written in ENGLISH. Additionally, add an explanation of the gitcommit block. The explanation must be written in JAPANESE.'

      require('CopilotChat').setup({
        system_prompt = prompts.COPILOT_INSTRUCTIONS .. lang_prompt,
        show_help = false,

        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.' .. lang_prompt,
          },
          Review = {
            prompt = '/COPILOT_REVIEW Review the selected code.' .. lang_prompt,
          },
          Fix = {
            prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.' .. lang_prompt,
          },
          Optimize = {
            prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.' .. lang_prompt,
          },
          Docs = {
            prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.' .. lang_prompt,
          },
          Tests = {
            prompt = '/COPILOT_GENERATE Please generate tests for my code.' .. lang_prompt,
          },
          FixDiagnostic = {
            prompt = 'Please assist with the following diagnostic issue in file:' .. lang_prompt,
          },
          Commit = {
            prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.'
              .. lang_prompt_commit,
          },
          CommitStaged = {
            prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.'
              .. lang_prompt_commit,
          },
        },

        window = {
          layout = 'float',
          border = 'rounded',
          width = 0.8,
          height = 0.6,
        },

        mappings = {
          complete = {
            detail = nil,
            insert = nil,
          },
          close = {
            normal = 'q',
            insert = nil,
          },
          reset = {
            normal = '<BS>',
            insert = nil,
          },
          submit_prompt = {
            normal = '<CR>',
            insert = nil,
          },
          accept_diff = {
            normal = nil,
            insert = nil,
          },
          show_diff = {
            normal = nil,
          },
          show_system_prompt = {
            normal = nil,
          },
          show_user_selection = {
            normal = nil,
          },
        },
      })
    end,
    event = 'VeryLazy',
  },
}
