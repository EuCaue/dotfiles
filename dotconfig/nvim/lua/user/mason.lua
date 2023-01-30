local servers = {
	"tsserver",
	"bashls",
	"sumneko_lua",
	"pyright",
	"eslint",
	"marksman",
	"html",
	"cssls",
	"cssmodules_ls",
	"clangd",
	"jsonls",
}

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

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})
