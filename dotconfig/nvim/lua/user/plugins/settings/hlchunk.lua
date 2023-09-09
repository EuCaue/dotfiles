local hlchunk = require("hlchunk")

hlchunk.setup({
	chunk = {
		enable = true,
		use_treesitter = true,
		notify = true, -- notify if some situation(like disable chunk mod double time)
		exclude_filetypes = {
			aerial = true,
			dashboard = true,
		},
		support_filetypes = {
			"*.*",
		},
		chars = {
			horizontal_line = "─",
			vertical_line = "│",
			left_top = "╭",
			left_bottom = "╰",
			right_arrow = ">",
		},
		style = {
			{ fg = "#41a7fc" },
		},
	},

	indent = {
		enable = true,
		use_treesitter = false,
		chars = {
			"│",
		},
		style = {
			{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
		},
	},

	line_num = {
		enable = true,
		use_treesitter = false,
		style = "#41a7fc",
	},

	blank = {
		enable = true,
		chars = {
			"․",
		},
		style = {
			vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
		},
	},
})
