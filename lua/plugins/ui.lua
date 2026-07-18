-- 見た目・表示まわり
return {
  -- バッファをタブ状に表示
  -- ロード: 起動時 / 操作: <C-j> <C-k> で切替 → keymaps/init.lua
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons', -- 公式では任意だが get_element_icon で直接使用
    opts = {
      options = {
        close_command = 'bwipeout! %d',
        right_mouse_command = 'bwipeout! %d',
        buffer_close_icon = '󰅖',
        close_icon = '',
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        custom_filter = function(buf_number) return vim.bo[buf_number].filetype ~= 'qf' end,
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },
    },
  },

  -- ステータスライン / winbar
  -- ロード: 起動時 / 操作: なし (表示のみ)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- アイコン表示用 (公式では任意)
      'folke/noice.nvim', -- config が noice.api を参照するためロード順を保証する
    },
    config = function()
      require('lualine').setup({
        options = {
          globalstatus = true,
          disabled_filetypes = {
            winbar = { '', 'help', 'text', 'Avante', 'AvanteInput', 'AvanteSelectedFiles' },
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filetype' },
          lualine_x = {
            {
              ---@diagnostic disable-next-line: undefined-field
              require('noice').api.status.mode.get,
              ---@diagnostic disable-next-line: undefined-field
              cond = require('noice').api.status.mode.has,
            },
            { 'fileformat', symbols = { unix = ' ', dos = '', mac = 'old ' } },
            'encoding',
          },
          lualine_y = { 'searchcount', 'progress' },
          lualine_z = { 'selectioncount', 'location' },
        },
        -- 非アクティブウィンドウにはステータスライン内容を出さない (デフォルトは filename 等が出る)
        inactive_sections = {},
        winbar = {
          lualine_c = { 'filename', 'navic' },
        },
      })
    end,
  },

  -- メッセージ / コマンドライン UI
  -- ロード: 起動時 (公式推奨は VeryLazy だが、lualine と telescope 拡張から参照されるため)
  -- 操作: T (:Telescope noice) → keymaps/init.lua
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim', -- 公式 README が必須と明記
      {
        -- 通知ビュー用 (公式では任意。無ければ mini にフォールバックする)
        'rcarriga/nvim-notify',
        opts = { stages = 'static' },
      },
    },
    opts = {
      routes = (function()
        local ignored_warn_messages = {
          'position_encoding param is required in vim.lsp.util.make_position_params',
          'multiple different client offset_encodings detected',
        }
        local routes = {}
        for _, m in ipairs(ignored_warn_messages) do
          table.insert(routes, {
            filter = { event = 'notify', find = m },
            opts = { skip = true },
          })
        end
        return routes
      end)(),
    },
  },

  -- vim.ui.select / vim.ui.input の UI 改善 (LSP リネーム入力等で使用)
  -- ロード: 起動時 / 操作: なし (自動適用)
  -- 2025-02 にアーカイブ済み (作者は snacks.nvim を後継として案内)。現状は動作する
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- winbar のコードコンテキスト (lualine の 'navic' コンポーネントで表示)
  -- ロード: 起動時 / 操作: なし (表示のみ)
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' }, -- 公式 README が必須と明記
    opts = {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      click = true,
    },
  },

  -- 画面上部に現在のスコープを表示
  -- ロード: 起動時 / 操作: なし (表示のみ)。パーサは nvim-treesitter が管理 (プラグイン依存は公式に不要)
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {},
  },

  -- インデントガイド
  -- ロード: 起動時 / 操作: | でトグル → keymaps/init.lua
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl', -- v3 系のモジュール名 (公式 README のインストール例どおり)
    version = '3.9.1', -- vim.tbl_flatten 非推奨警告の出ない安定版に固定 (2026-02-17 リリース)
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      require('ibl').setup({ indent = { char = '▏', tab_char = '┊', highlight = highlight } })
    end,
  },

  -- カラーコードの背景色プレビュー
  -- ロード: 起動時 / 操作: なし (自動適用)
  {
    'catgoose/nvim-colorizer.lua', -- NvChad/nvim-colorizer.lua から移転済み (同一リポジトリ)
    opts = {},
  },
}
