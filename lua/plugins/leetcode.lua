local plugins = {
  {
    "3rd/image.nvim",
    config = function()
      require("image").setup {
        -- Add any specific image.nvim configuration here
        backend = "kitty", -- or "ueberzug", depending on your terminal
        max_width = 100,
        max_height = 100,
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
      }
    end,
  },
  {
    "kawre/leetcode.nvim",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    opts = {
      lang = "java",
      description = {
        position = "left",
        width = "40%", -- Adjust width as needed
        wrap = true, -- Enable text wrapping
        show_stats = true,
        border = "single",
      },
      ui = {
        picker = "telescope",
      },
      image_support = true,
    },
    config = function(_, opts)
      require("leetcode").setup(opts)

      -- Ensure proper text wrapping in description window
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "leetcode-description",
        callback = function()
          -- Ensure text wraps within the window
          vim.wo.wrap = true
          vim.wo.linebreak = true
          vim.wo.breakindent = true
          vim.wo.breakindentopt = "shift:2"
          vim.wo.showbreak = "↳ "
          vim.wo.conceallevel = 0

          -- Set text width to match window width
          vim.wo.textwidth = 0
        end,
      })
    end,
  },
}
return plugins
