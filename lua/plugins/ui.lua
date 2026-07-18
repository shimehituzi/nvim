-- 見た目・表示まわり
return {
  -- バッファタブ
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
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
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
              require('noice').api.status.mode.get,
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
  {
    'folke/noice.nvim',
    -- telescope の拡張・lualine のステータス表示から参照されるため実際は起動時ロードになる
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
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        opts = { stages = 'static' },
      },
    },
  },

  -- vim.ui.select / vim.ui.input の UI 改善 (LSP リネーム入力等で使用)
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- winbar のコードコンテキスト (lualine の 'navic' コンポーネントで表示)
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      click = true,
    },
  },

  -- 画面上部に現在のスコープを表示
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  -- インデントガイド (| でトグル)
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    version = '3.9.1', -- nvim 0.12 の vim.tbl_flatten 非推奨警告が解消されたリリース (2026-02-17)
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
  {
    'NvChad/nvim-colorizer.lua',
    opts = {},
  },
}
