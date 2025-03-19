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
--
-- Delete word backward (Ctrl+Backspace in VS Code)
vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true }) -- For terminals that send C-H instead

-- Delete word forward (Ctrl+Delete in VS Code)
vim.keymap.set("i", "<C-Del>", "<C-O>dw", { noremap = true })

-- Delete entire line (Ctrl+Shift+K in VS Code)
vim.keymap.set("i", "<C-S-k>", "<C-O>dd", { noremap = true })

-- Delete from cursor to end of line (similar to VS Code's end of line operations)
vim.keymap.set("i", "<C-k>", "<C-O>D", { noremap = true })

-- Delete from cursor to start of line (not default in VS Code but useful)
-- vim.keymap.set("i", "<C-u>", "<C-O>d0", { noremap = true })

-- Cut current line (Ctrl+X with nothing selected in VS Code)
vim.keymap.set("i", "<C-x>", "<C-O>dd<C-O>P", { noremap = true })
