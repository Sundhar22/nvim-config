require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jj", "<ESC>")

map("n", "<leader>ts", function()
  local hidden = vim.o.laststatus == 0
  vim.o.laststatus = hidden and 2 or 0
end, { desc = "toggle status line" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
