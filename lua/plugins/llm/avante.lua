return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  -- クールダウン方針に基づき「7日以上前の main」にコミット固定 (2026-07-08 時点)。
  -- claude-opus-4-8 系に必要な temperature 自動除去 (2026-06-04, 4465809) を含む。
  -- 更新するときは同様に7日以上前のコミットを選んで貼り替える
  commit = '2183acf',
  build = 'make',
  -- dressing.nvim は avante 専用ではないため lua/plugins/ui/dressing.lua へ移動。
  -- copilot.lua は独立 spec (llm/copilot.lua) があるため依存から削除
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
    'MeanderingProgrammer/render-markdown.nvim',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
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
    local opts = {
      provider = 'anthropic-claude-opus-48',
      mode = 'agentic', -- "agentic" (AI自動実行) or "legacy" (手動承認)
      providers = {
        claude = {
          api_key_name = { 'gopass', 'show', '-o', 'anthropic/api_key' },
        },
        ['anthropic-claude-opus-48'] = {
          __inherited_from = 'claude',
          display_name = 'anthropic/claude-opus-4.8',
          model = 'claude-opus-4-8',
          context_window = 1000000,
          -- 親 claude 由来の temperature は avante 側が opus 系では自動除去する
          extra_request_body = {
            max_tokens = 64000,
          },
        },
      },
      web_search_engine = {
        providers = {
          tavily = {
            api_key_name = { 'gopass', 'show', '-o', 'tavily/api_key' },
          },
        },
      },
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        return hub:get_active_servers_prompt()
      end,
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
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
          ours = '1',
          theirs = '2',
          cursor = '3',
          all_theirs = '4',
          both = '5',
          next = 'J',
          prev = 'K',
        },
        jump = {
          next = 'J',
          prev = 'K',
        },
        submit = {
          normal = '<CR>',
          insert = '<M-CR>',
        },
        sidebar = {
          switch_windows = '<C-j>',
          reverse_switch_windows = '<C-k>',
          apply_all = 'A',
          apply_cursor = 'a',
          retry_user_request = 'r',
          edit_user_request = 'e',
          add_file = 'a',
          remove_file = 'd',
          close = { 'q' },
        },
        files = {
          add_current = '<C-t>',
        },
      },
      windows = {
        position = 'right',
        wrap = true,
        width = 50,
        sidebar_header = {
          enabled = false,
        },
        input = {
          prefix = '',
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
        provider = 'telescope',
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
      if vim.fn.confirm('Avante: Are you sure you want to clear history and memory?', '&Yes\n&No', 2) == 1 then
        vim.cmd('AvanteClear history')
        vim.cmd('AvanteClear cache')
      end
    end)
    map('n', '<C-c>', '<cmd>AvanteStop<cr>')
  end,
}
