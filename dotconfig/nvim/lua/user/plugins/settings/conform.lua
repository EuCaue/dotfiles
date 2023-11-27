local util = require("conform.util")
local prettier_markdown = vim.deepcopy(require("conform.formatters.prettier"))
local prettier_p = vim.deepcopy(require("conform.formatters.prettier"))
util.add_formatter_args(prettier_p, { "--single-attribute-per-line" })
util.add_formatter_args(prettier_markdown, { "--parser markdown" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		fish = { "fish_indent" },
		javascript = { "prettier" },
		html = { { "prettier" } },
		css = { "prettier" },
		scss = { "prettier" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		dart = { "dart_format" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		svelte = { "prettier" },
		typescriptreact = { "prettier" },
		markdown = { "prettier_markdown" },
	},
	formatters = {
		prettier_markdown = prettier_markdown,
		prettier = prettier_p,
	},
})
