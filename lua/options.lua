require "nvchad.options"
-- In your NvChad custom config
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- Direct vim options setting
-- Direct vim options setting
local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = true
opt.foldlevel = 99 -- Set this high to open all folds by default

--relative number
vim.opt.number = true
vim.opt.relativenumber = true
