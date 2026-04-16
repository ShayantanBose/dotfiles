---@type NvPluginSpec
-- NOTE: AI Provider for Avante

return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  event = "InsertEnter",
  commit = "ad7e729e9a6348f7da482be0271d452dbc4c8e2c",
  submodules = false,
  opts = {
    filetypes = {
      ["*"] = true,
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          -- disable for .env files
          return false
        end
        return true
      end,
    },
  },
}
