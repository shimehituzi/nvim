-- LLM アシスタント (Avante + MCP)
return {
  -- AI コーディングアシスタント
  -- ロード: VeryLazy (公式推奨) / 操作: <Tab> <S-Tab> <Del> <S-Del> <C-c> とサイドバー内キー → lua/config/keymaps.lua
  {
    'yetone/avante.nvim',
    -- クールダウン方針: コミット日 2026-07-08 の main に固定 (固定時点で7日以上経過済み)。
    -- 更新時も「7日以上前のコミット」を選んで貼り替える
    commit = '2183acf',
    event = 'VeryLazy',
    build = 'make',
    dependencies = {
      -- 必須 (公式 README)
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- 任意 (この設定で使っている機能のため)
      'nvim-telescope/telescope.nvim', -- file_selector provider に指定
      'hrsh7th/nvim-cmp', -- Avante コマンド・メンションの補完
      'nvim-tree/nvim-web-devicons', -- アイコン表示
      'MeanderingProgrammer/render-markdown.nvim', -- 応答の Markdown 表示 (設定は plugins/lang.lua)
      {
        -- 画像のクリップボードペースト対応
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
        ---@diagnostic disable-next-line: need-check-nil
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
      mappings = require('config.keymaps').avante,
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
  -- ロード: 起動時 / 操作: :MCPHub
  {
    'ravitemer/mcphub.nvim',
    version = 'v6.2.0', -- 安定版に固定 (2025-07-31 リリース)
    build = 'npm install -g mcp-hub@4.2.0', -- グローバルインストール (バージョン固定)
    dependencies = {
      'nvim-lua/plenary.nvim', -- 公式ドキュメントが必須と明記
    },
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
