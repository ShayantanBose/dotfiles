return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = 0 -- default: disabled everywhere
      vim.g.copilot_filetypes = { -- enable only where desired
        javascript = false,
        typescript = false,
        lua = false, -- explicit off
        ["*"] = false, -- fallback for all others
      }
    end,
  },
}
