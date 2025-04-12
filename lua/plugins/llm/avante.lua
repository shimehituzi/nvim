return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function()
    local opts = {
      provider = 'claude',
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        timeout = 30000,
        temperature = 0,
        max_tokens = 20480,
        api_key_name = { "gopass", "show", "-o", "anthropic/api_key", },
      },
      web_search_engine = {
        providers = {
          tavily = {
            api_key_name = { "gopass", "show", "-o", "tavily/api_key", },
          }
        }
      },
      disabled_tools = {
        'python',
      },
      vendors = {
        ['copilot-claude-35'] = {
          __inherited_from = 'copilot',
          display_name = 'Claude 3.5 Sonnet',
          model = 'claude-3.5-sonnet',
          max_tokens = 8000,
        },
        ['copilot-claude-37'] = {
          __inherited_from = 'copilot',
          display_name = 'Claude 3.7 Sonnet',
          model = 'claude-3.7-sonnet',
          max_tokens = 8000,
        },
      },
      behaviour = {
        auto_focus_sidebar = true,
        auto_suggestions = false,
        auto_apply_diff_after_generation = false,
        auto_set_keymaps = false,
        auto_set_highlight_group = true,
        jump_result_buffer_on_finish = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = true,
        use_cwd_as_project_root = true,
        enable_claude_text_editor_tool_mode = true,
      },
      mappings = {
        diff = {
          ours = "1",
          theirs = "2",
          cursor = "3",
          all_theirs = "4",
          both = "5",
          next = "J",
          prev = "K",
        },
        jump = {
          next = "J",
          prev = "K",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        cancel = {
          normal = { "<Esc>", "q" },
        },
        sidebar = {
          switch_windows = "<C-j>",
          reverse_switch_windows = "<C-k>",
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          add_file = "a",
          remove_file = "d",
          close = { "q" },
        },
        files = {
          add_current = "<C-t>",
        },
      },
      windows = {
        position = "right",
        wrap = true,
        width = 50,
        sidebar_header = {
          enabled = false,
        },
        input = {
          prefix = "",
        },
        edit = {
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = false,
        },
      },
      file_selector = {
        provider = "telescope",
      },
      hints = {
        enabled = false,
      },
    }
    require('avante').setup(opts)
    local map = require('utils').map
    map('n', '<Tab>', '<Plug>(AvanteFocus)')
    map('n', '<S-Tab>', '<Plug>(AvanteToggle)')
    map('v', '<Tab>', '<Plug>(AvanteAsk)<Esc>')
    map('v', '<S-Tab>', '<Plug>(AvanteEdit)')
    map('n', '<Del>', '<cmd>AvanteHistory<cr>')
    map('n', '<S-Del>', function()
      if vim.fn.confirm("Avante: Are you sure you want to clear history and memory?", "&Yes\n&No", 2) == 1 then
        vim.cmd('AvanteClear history')
        vim.cmd('AvanteClear memory')
        require("avante.path").clear()
      end
    end)
  end,
}
