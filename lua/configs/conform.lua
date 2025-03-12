local options = {
  formatters_by_ft = {
    go = { "gofumpt", "goimports-reviser", "golines" },
    gomod = { "gofumpt", "goimports-reviser" },
    gowork = { "gofumpt", "goimports-reviser" },
    gotmpl = { "gofumpt", "goimports-reviser" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    lua = { "stylua" },
  },

  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused", "-format-enabled" },
    },
    gofumpt = {
      -- Add any specific gofumpt configurations if needed
    },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
