vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	indentLine_enabled = 1,
	filetype_exclude = {
		"help",
		"terminal",
		"alpha",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	show_current_context = true,
	show_current_context_start = true,
})
