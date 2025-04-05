return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make", -- Windowsでも cargo がなければ自動でprebuiltをDLしてビルド
    dependencies = {
      -- 必須依存
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Copilot 連携なので一応入れておく
      "zbirenbaum/copilot.lua",
      -- UIアイコンが欲しければ
      "nvim-tree/nvim-web-devicons",
      -- 画像貼り付けが必要なら
      "HakonHarnes/img-clip.nvim",
      -- avante の Markdown 表示を最適化したい場合
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
        opts = { file_types = { "markdown", "Avante" } },
      },
    },
    opts = {
      -- メインプロバイダをCopilotに設定
      provider = "copilot",
      -- インラインサジェストもCopilotに
      auto_suggestions_provider = "copilot",
      -- サジェストを有効化したい場合
      behaviour = {
        auto_suggestions = true,
      },
      -- ↑他に細かい設定を入れるなら README 参照
    },
  },
}
