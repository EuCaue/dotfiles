local settings = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}
local utils = require("user.utils")

local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("Plugin mason not found", "error")
  return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  vim.notify("Plugin mason-lspconfig not found", "error")
  return
end

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = utils.servers,
  automatic_installation = true,
})
