return {
  "github/copilot.vim",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    -- Enable Copilot suggestions by default
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Map <C-J> to accept Copilot suggestions
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

    -- Enable Copilot for all filetypes
    vim.g.copilot_filetypes = { ["*"] = true }
  end,
}
