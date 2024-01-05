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

local mason = require("mason")

local mason_lspconfig = require("mason-lspconfig")

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = utils.servers,
  automatic_installation = true,
})
