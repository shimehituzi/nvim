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
    'MeanderingProgrammer/render-markdown.nvim',
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
  },
  config = function()
    --[[ web_search hot-fix  (avante.nvim adae032, 2025-05-11)
      env.parse() runs cmd async → nil on first call → 1st Tavily search fails.
      Below replaces parse() with sync version (vim.fn.systemlist).
      Keep until upstream makes web_search sync / adds parse_api_key.
    --]]
    -- begin hot-fix
    do
      local env = require("avante.utils.environment")
      env.parse = function(k)
        local ck = type(k) == "table" and table.concat(k, "__") or k
        if env.cache[ck] ~= nil then return env.cache[ck] end
        local cmd = type(k) == "table" and table.concat(k, " ") or k:match("^cmd:(.*)")
        local v = cmd and (vim.fn.systemlist(cmd)[1] or ""):gsub("\n", "") or os.getenv(k)
        env.cache[ck] = v
        return v
      end
    end
    -- end hot-fix
    local opts = {
      provider = 'anthropic-claude-37',
      claude = {
        -- api_key_name = "cmd:gopass show -o anthropic/api_key",
        api_key_name = { "gopass", "show", "-o", "anthropic/api_key" },
      },
      vendors = {
        ['anthropic-claude-37'] = {
          __inherited_from = 'claude',
          display_name = 'custom/anthropic-claude-3.7-sonnet',
          model = 'claude-3-7-sonnet-20250219',
          max_tokens = 64000,
        },
        ['anthropic-claude-35'] = {
          __inherited_from = 'claude',
          display_name = 'custom/anthropic-claude-3.5-sonnet',
          model = 'claude-3-5-sonnet-20241022',
          max_tokens = 8192,
        },
        ['copilot-claude-37'] = {
          __inherited_from = 'copilot',
          display_name = 'custom/copilot-claude-3.7-sonnet',
          model = 'claude-3.7-sonnet',
        },
        ['copilot-claude-35'] = {
          __inherited_from = 'copilot',
          display_name = 'custom/copilot-claude-3.5-sonnet',
          model = 'claude-3.5-sonnet',
        },
      },
      web_search_engine = {
        providers = {
          tavily = {
            -- api_key_name = "cmd:gopass show -o tavily/api_key",
            api_key_name = { "gopass", "show", "-o", "tavily/api_key" },
          }
        }
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub:get_active_servers_prompt()
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      disabled_tools = {
        'python',
      },
      behaviour = {
        auto_focus_sidebar = true,
        auto_suggestions = false,
        auto_apply_diff_after_generation = true,
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
          insert = "<M-CR>",
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
    map('n', '<S-Tab>', '<Plug>(AvanteSelectModel)')
    map('v', '<Tab>', '<Plug>(AvanteAsk)<Esc>')
    map('v', '<S-Tab>', '<Plug>(AvanteEdit)')
    map('n', '<Del>', '<cmd>AvanteHistory<cr>')
    map('n', '<S-Del>', function()
      if vim.fn.confirm("Avante: Are you sure you want to clear history and memory?", "&Yes\n&No", 2) == 1 then
        vim.cmd('AvanteClear history')
        vim.cmd('AvanteClear cache')
      end
    end)
    map('n', '<C-c>', '<cmd>AvanteStop<cr>')
  end,
}
