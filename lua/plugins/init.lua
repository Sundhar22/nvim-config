return {
  -- #imp: this is lspconfig setup call
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- make sure to add this dependency
    event = "VeryLazy",
    config = function()
      local null_ls = require "null-ls"
      local opts = require "configs.null-ls-config"
      null_ls.setup(opts)
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = function()
      return require "configs.auto-save"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("go").setup {
        lsp_cfg = true,
        lsp_keymaps = true,
        dap_debug = true,
      }
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = function()
      -- Use a shell command instead of Lua function
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "eslint/eslint",
    config = function()
      local lspconfig = require "lspconfig"
      lspconfig.eslint.setup {

        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {

            buffer = bufnr,

            command = "EslintFixAll",
          })
        end,
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Load only for Java files
    dependencies = { "mfussenegger/nvim-dap" }, -- Optional: for debugging support
    config = function() end,
  },
}
