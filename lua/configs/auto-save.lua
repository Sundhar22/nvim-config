local opt = {
  enabled = true,
  trigger_events = {
    immediate_save = { "BufLeave", "FocusLost" },
    defer_save = { "InsertLeave", "TextChanged" },
    cancel_deferred_save = { "InsertEnter" },
  },
  condition = nil,
  write_all_buffers = false,
  noautocmd = false,
  lockmarks = false,
  debounce_delay = 1000,
  debug = false,
}

opt.callbacks = {
  before_saving = function()
    vim.notify("AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S", vim.log.levels.INFO)
  end,
}

return opt
