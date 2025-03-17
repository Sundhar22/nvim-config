-- Custom jdtls configuration
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls"
local config_dir = jdtls_path .. "/config_linux"
local plugins_dir = jdtls_path .. "/plugins/"
local path_to_jar = vim.fn.glob(plugins_dir .. "org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar")
local java_path = "/usr/bin/java"
local nvlsp = require "nvchad.configs.lspconfig"
-- Store the last successfully run class
_G.last_run_class = nil
_G.last_run_file = nil

-- Function to run Java class with proper buffer handling
function _G.RunJavaClass()
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local file_content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

  -- Extract class name from file content
  local class_name = nil
  for line in string.gmatch(file_content, "[^\r\n]+") do
    local match = string.match(line, "public%s+class%s+(%w+)")
    if match then
      class_name = match
      break
    end
  end

  if not class_name then
    print "Could not find class name in current buffer"
    return
  end

  -- Check if the class has a main method
  local has_main = false
  for line in string.gmatch(file_content, "[^\r\n]+") do
    if string.match(line, "public%s+static%s+void%s+main%s*%(") then
      has_main = true
      break
    end
  end

  -- Compile current file
  vim.cmd("silent !mkdir -p bin && javac -d bin " .. file_path)
  print("Compiled " .. file_path .. " to bin/")

  -- Run the class if it has main, otherwise run the last successful class
  if has_main then
    vim.cmd("!java -cp bin " .. class_name)
    -- Store this as the last run class
    _G.last_run_class = class_name
    _G.last_run_file = file_path
  else
    if _G.last_run_class then
      print("Current class has no main method. Running last successful class: " .. _G.last_run_class)
      vim.cmd("!java -cp bin " .. _G.last_run_class)
    else
      print "Current class has no main method and no previous class with main method has been run."
    end
  end
end

local config = {
  cmd = {
    java_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    path_to_jar,
    "-configuration",
    config_dir,
    "-data",
    vim.fn.expand "~/.cache/jdtls-workspace",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".gitignore", "pom.xml" }, { upward = true })[1])
    or vim.fn.getcwd(),
  filetypes = { "java" },
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.setup").add_commands()

    -- Map F5 to save and run current Java file
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<F5>", ":w<CR>:lua RunJavaClass()<CR>", { noremap = true, silent = false })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

return config
