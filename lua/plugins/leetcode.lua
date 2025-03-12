local plugins = {
  {
    "kawre/leetcode.nvim",
    lazy = false,
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- Updated configuration using current API
      lang = "java",
      storage = {
        home = vim.fn.stdpath "data" .. "/leetcode",
        cache = vim.fn.stdpath "cache" .. "/leetcode",
      },
      console = {
        open_on_startup = false,
        size = {
          width = "75%",
          height = "25%",
        },
      },
      description = {
        position = "left",
      },
      image_support = false,
      ui = {
        picker = "telescope", -- Use telescope instead of fzf
      },
    },
    config = function(_, opts)
      require("leetcode").setup(opts)
    end,
  },
}

return plugins
