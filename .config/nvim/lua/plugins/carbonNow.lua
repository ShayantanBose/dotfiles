return {
  {
    "ellisonleao/carbon-now.nvim",
    opts = {
      options = {
        theme = "SynthWave '84", -- Change this to your preferred theme
        titlebar = "", -- Customize your titlebar text
      },
    },
    keys = {
      -- Optional: Add a keymapping for visual selection
      { "<leader>cn", ":CarbonNow<CR>", mode = "v", desc = "Create Carbon Snapshot" },
    },
  },
}
