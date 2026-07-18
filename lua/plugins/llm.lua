-- LLM アシスタント (Avante + MCP。キーマップは lua/config/keymaps/init.lua)
return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    -- クールダウン方針: 7日以上前のコミットに固定 (2026-07-08 時点)。更新時も同様に選ぶ
    commit = '2183acf',
    build = 'make',
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
    opts = {
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
      -- サイドバー・diff 内のキーは keymaps 側で一元管理
      mappings = require('config.keymaps.avante').mappings,
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
    },
  },

  -- MCP サーバーランチャー (サーバー定義は ~/.config/mcphub/servers.json でバージョン固定)
  {
    'ravitemer/mcphub.nvim',
    version = 'v6.2.0', -- 安定版に固定(2025-07-31 リリース)
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@4.2.0', -- グローバルインストール (バージョン固定)
    opts = {
      auto_approve = true,
      extensions = {
        avante = {
          make_slash_commands = false,
        },
      },
      ui = {
        window = {
          width = 0.8,
          height = 0.8,
          relative = 'editor',
          zindex = 50,
          border = 'rounded',
        },
      },
      on_error = function(err) vim.notify('MCPHub error: ' .. err, vim.log.levels.ERROR) end,
    },
  },
}
