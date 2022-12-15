local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local navic = require("nvim-navic")
local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon_only = true,
}

local filename = {
	"filename",
	icons_enabled = true,
	file_status = false,
	-- path = 1,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local function client_names()
	local client = vim.lsp.get_active_clients()[1]
	return string.format("[%s]", client.name)
end

local winbar = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { { navic.get_location, cond = navic.is_available } },
	lualine_x = {},
	lualine_y = {},
	lualine_z = {},
}

lualine.setup({
	options = {
		icons_enabled = true,

		theme = "rose-pine",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch, diff, diagnostics },
		lualine_c = { filetype, filename },
		lualine_x = { client_names, "encoding", "fileformat" },
		lualine_y = { "progress" },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = winbar,
	tabline = {},
	extensions = { "nvim-tree" },
})
