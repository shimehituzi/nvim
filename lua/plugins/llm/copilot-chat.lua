return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local prompts = require('CopilotChat.prompts')
      local select = require('CopilotChat.select')

      local lang_prompt = ' MUST ANSWER IN JAPANESE.'
      local lang_prompt_commit =
      'The gitcommit block must be written in ENGLISH. Additionally, add an explanation of the gitcommit block. The explanation must be written in JAPANESE.'

      require('CopilotChat').setup({
        debug = false,
        proxy = nil,
        allow_insecure = false,

        system_prompt = prompts.COPILOT_INSTRUCTIONS .. lang_prompt,
        model = 'gpt-4',
        temperature = 0.1,

        name = 'CopilotChat',
        separator = '---',
        show_folds = true,
        show_help = false,
        auto_follow_cursor = true,
        auto_insert_mode = false,
        clear_chat_on_new_prompt = false,

        context = nil,
        history_path = vim.fn.stdpath('data') .. '/copilotchat_history',
        callback = nil,

        selection = function(source)
          return select.visual(source) or select.buffer(source)
        end,

        prompts = {
          Explain = {
            prompt =
                '/COPILOT_EXPLAIN Write an explanation for the code above as paragraphs of text.' .. lang_prompt,
          },
          Tests = {
            prompt =
                '/COPILOT_TESTS Write a set of detailed unit test functions for the code above.' .. lang_prompt,
          },
          Fix = {
            prompt =
                '/COPILOT_FIX There is a problem in this code. Rewrite the code to show it with the bug fixed.' ..
                lang_prompt,
          },
          Optimize = {
            prompt =
                '/COPILOT_REFACTOR Optimize the selected code to improve performance and readablilty.' .. lang_prompt,
          },
          Docs = {
            prompt =
                '/COPILOT_REFACTOR Write documentation for the selected code. The reply should be a codeblock containing the original code with the documentation added as comments. Use the most appropriate documentation style for the programming language used (e.g. JSDoc for JavaScript, docstrings for Python etc.' ..
                lang_prompt,
          },
          FixDiagnostic = {
            prompt = 'Please assist with the following diagnostic issue in file.' .. lang_prompt,
            selection = select.diagnostics,
          },
          Commit = {
            prompt =
                'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.' ..
                lang_prompt_commit,
            selection = select.gitdiff,
          },
          CommitStaged = {
            prompt =
                'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.' ..
                lang_prompt_commit,
            selection = function(source)
              return select.gitdiff(source, true)
            end,
          },
        },

        window = {
          layout = 'float',
          relative = 'editor',
          border = 'rounded',
          width = 0.8,
          height = 0.6,
          row = nil,
          col = nil,
          title = 'Copilot Chat',
          footer = nil,
          zindex = 1,
        },

        mappings = {
          complete = {
            detail = '',
            insert = '<C-s>',
          },
          close = {
            normal = 'q',
            insert = nil
          },
          reset = {
            normal = '`',
            insert = nil,
          },
          submit_prompt = {
            normal = '<CR>',
            insert = nil
          },
          accept_diff = {
            normal = nil,
            insert = nil
          },
          show_diff = {
            normal = nil
          },
          show_system_prompt = {
            normal = nil
          },
          show_user_selection = {
            normal = nil
          },
        },
      })
    end,
    event = 'VeryLazy',
  },
}
