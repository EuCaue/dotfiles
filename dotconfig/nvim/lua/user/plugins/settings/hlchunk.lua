local hlchunk = require("hlchunk")

local function hlcode(name)
	local hlnr = vim.fn.hlID(name)
	if type(hlnr) ~= "number" or hlnr <= 0 then
		return nil
	end
	local synnr = vim.fn.synIDtrans(hlnr)
	if type(synnr) ~= "number" or synnr <= 0 then
		return nil
	end
	local guicode = vim.fn.synIDattr(synnr, "fg", "gui")
	if type(guicode) == "string" and string.len(guicode) > 0 then
		return guicode
	end
	return vim.fn.synIDattr(synnr, "fg", "cterm")
end
local HL = "#41a7fc"

local line_nr = hlcode("Constant")
if line_nr then
	HL = line_nr
end

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
			{ fg = HL },
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
		enable = false,
		use_treesitter = false,
		style = HL,
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
