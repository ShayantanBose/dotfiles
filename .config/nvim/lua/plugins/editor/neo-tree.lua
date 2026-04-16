---@type LazySpec
-- NOTE: File Tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  opts = {
    sources = { "filesystem" },
    source_selector = {
      winbar = false,
      sources = {
        { source = "filesystem" },
      },
    },
    filesystem = {
      window = {
        position = "right",
      },
    },
    enable_git_status = false,
  },
}
