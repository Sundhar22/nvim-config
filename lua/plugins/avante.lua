return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Using latest code changes
  opts = {
    provider = "copilot",
    copilot = {
      api_key = os.getenv "COPILOT_API_KEY",
      -- Change this model to an officially supported one
      model = "copilot-chat", -- or another supported Copilot model
      temperature = 0.7,
    },
  },
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for Windows
  dependencies = {
    -- other dependencies remain the same
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    {
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            ["*"] = true,
          },
        }
      end,
    },
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
