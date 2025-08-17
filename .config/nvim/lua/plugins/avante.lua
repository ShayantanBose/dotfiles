return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- Use GitHub Copilot as the LLM provider
    provider = "copilot",

    -- Optional: tune suggestions; higher debounce => fewer requests
    suggestion = {
      debounce = 800, -- try 800–1500ms if you want even fewer requests
      -- enabled = true,
      -- auto_trigger = true,
      -- keymap = { accept = "<Tab>", next = "<M-]>", prev = "<M-[>" },
    },

    -- You can keep other providers defined if you want to switch later,
    -- but the active provider is "copilot".
    providers = {
      copilot = {
        -- Copilot typically uses your existing GitHub authentication.
        -- If you use zbirenbaum/copilot.lua, ensure it's set up and logged in.
        -- You can add provider-specific options if avante exposes any.
        timeout = 30000, -- ms (optional)
        extra_request_body = {
          -- Add any tuning you'd like; Copilot API often abstracts these.
          -- For consistency with your previous config:
          -- temperature = 0.75, -- (only if supported by Copilot provider in avante)
          -- max_tokens = 2048,  -- (only if supported)
        },
      },

      -- Keeping your previous providers here (optional, inactive by default)
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional helpers (file selector/input providers, icons)
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons

    -- Copilot dependency for provider='copilot'
    "zbirenbaum/copilot.lua",

    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
