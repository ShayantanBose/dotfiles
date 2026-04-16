return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      [[                                                                     ]],
      [[       ███████████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      ████████████████ ███████████ ███   ███████     ]],
      [[     ████████████████ ████████████ █████ ██████████████   ]],
      [[    █████████████████████████████ █████ █████ ████ █████   ]],
      [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
      [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
      [[ ██████   ██  ███████████████   ██ █████████████████ ]],
      [[ ██████   ██  ███████████████   ██ █████████████████ ]],
    }

    -- Set menu
    -- dashboard.section.buttons.val = {
    --   dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
    --   dashboard.button("f", " > Find file", "<cmd>Telescope find_files<CR>"),
    --   dashboard.button("CTRL N", "  > Toggle file explorer", "<cmd>Neotree toggle<CR>"),
    --   dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
    --   dashboard.button("SPC fw", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    --   dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
    -- }

    return dashboard
  end,

  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
  end,
}
