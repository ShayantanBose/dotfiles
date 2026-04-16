---@type LazySpec
-- NOTE: Tokyonight
return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    transparent = true,
    on_highlights = function(hl, c)
      hl.DiffviewDiffDelete = { bg = "#422b2b", fg = "#422b2b" }
      hl.Normal = { bg = "NONE" }
      hl.NormalNC = { bg = "NONE" }
      hl.NormalFloat = { bg = "NONE" }
      hl.FloatBorder = { bg = "NONE" }
      hl.SignColumn = { bg = "NONE" }
      hl.EndOfBuffer = { bg = "NONE" }

      -- Neo-tree
      hl.NeoTreeNormal = { bg = "NONE" }
      hl.NeoTreeNormalNC = { bg = "NONE" }
      hl.NeoTreeEndOfBuffer = { bg = "NONE" }
      hl.NeoTreeFloatNormal = { bg = "NONE" }
      hl.NeoTreeFloatBorder = { bg = "NONE" }
      -- which-key
      hl.WhichKeyNormal = { bg = "NONE" }
      hl.WhichKeyFloat = { bg = "NONE" }
      hl.WhichKeyBorder = { bg = "NONE" }
      hl.WhichKeyTitle = { bg = "NONE" }

      hl.LspReferenceRead = { link = "Underlined" }
      hl.LspReferenceText = { link = "Underlined" }
      hl.LspReferenceWrite = { link = "Underlined" }
      hl.SnacksPickerDir = { fg = c.fg }
    end,
  },
}
