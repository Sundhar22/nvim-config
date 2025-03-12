return {
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
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript & Next.js Ecosystem

        "typescript-language-server",

        "tailwindcss-language-server",

        "eslint-lsp",

        "prettierd",

        "css-lsp",

        "html-lsp",

        "json-lsp",

        -- React & Next.js Specific

        "react-language-server",

        "prisma-language-server",

        -- Linters and Formatters

        "eslint",

        "stylelint",

        "prettier",

        -- Lua Development

        "lua-language-server",

        "stylua",

        -- Additional Useful Tools

        "node-debug2-adapter",

        "js-debug-adapter",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "prisma",
      },
    },
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
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = "leetcode.nvim",
    },
  },
}
