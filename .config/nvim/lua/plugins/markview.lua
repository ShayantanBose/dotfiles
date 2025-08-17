-- lua/plugins/markview.lua
return {
  -- 1) Markview first (higher priority)
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- recommended by the plugin
    priority = 1001, -- ensure Markview loads before Treesitter
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("markview").setup({
        experimental = {
          -- We control the load order, so Markview doesn't need to modify rtp
          check_rtp = false,
        },
        -- You can add other Markview settings here if you use them
      })
    end,
  },

  -- 2) Treesitter after (slightly lower priority)
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 1000,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Enable or tune as needed
        highlight = { enable = true },
        indent = { enable = true },
        -- Ensure markdown parsers are present
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "markdown",
          "markdown_inline",
          -- add more languages you use
        },
      })
    end,
  },

  -- 3) Devicons (used by Markview and many UIs)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- safe to lazy-load; it will be required by plugins when needed
  },
}
