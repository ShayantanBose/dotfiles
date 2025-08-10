return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    keys = {
      -- Open/Toggle Chat on <leader>ac
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Chat Toggle" },
      { "<leader>ai", ":'<,'>CodeCompanion<cr>", mode = "v", desc = "CodeCompanion: Inline (selection)" },
    },
  },
}
