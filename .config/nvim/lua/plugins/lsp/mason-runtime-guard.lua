---@type LazySpec
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      local blocked = {
        fsautocomplete = true,
        rubocop = true,
        ruby_lsp = true,
        r_language_server = true,
      }

      if vim.fn.executable("dotnet") == 0 then
        blocked.fsautocomplete = true
      end
      if vim.fn.executable("gem") == 0 then
        blocked.rubocop = true
        blocked.ruby_lsp = true
      end
      if vim.fn.executable("R") == 0 then
        blocked.r_language_server = true
      end

      opts.ensure_installed = vim.tbl_filter(function(server)
        return not blocked[server]
      end, opts.ensure_installed or {})
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      local blocked = {}

      if vim.fn.executable("dotnet") == 0 then
        blocked["csharpier"] = true
        blocked["fantomas"] = true
      end
      if vim.fn.executable("gem") == 0 then
        blocked["erb-formatter"] = true
        blocked["erb-lint"] = true
      end

      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return not blocked[pkg]
      end, opts.ensure_installed or {})
    end,
  },
}
