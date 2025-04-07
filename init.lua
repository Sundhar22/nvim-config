vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

vim.api.nvim_create_user_command("ListKeymaps", function()
  local file = io.open(vim.fn.getcwd() .. "/keymaps.txt", "w")

  if not file then
    print "Could not open file for writing"
    return
  end

  for _, mode in ipairs { "n", "i", "v", "x", "c", "t" } do
    file:write("Mode: " .. mode .. "\n")
    for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
      local line = string.format("  %s → %s\n", map.lhs, map.rhs or "")
      file:write(line)
    end
    file:write "\n"
  end

  file:close()
  print("Keymaps saved to " .. vim.fn.getcwd() .. "/keymaps.txt")
end, {})
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
