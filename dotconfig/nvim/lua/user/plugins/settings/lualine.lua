local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("Plugin lualine not found", "error")
	return
end
local icons = require("user.utils").icons

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local lsp = {
	function(msg)
		local clients = 0
		msg = msg or "(LSP Inactive)"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			if type(msg) == "boolean" or #msg == 0 then
				return "(LSP Inactive)"
			end
			return msg
		end
		local buf_client_names = {}

		-- add client
		for _, client in pairs(buf_clients) do
			clients = clients + 1

			if client.name ~= "null-ls" and client.name ~= "copilot" then
				table.insert(buf_client_names, client.name)
			end
			-- if clients == 3 then
			-- 	break
			-- end
		end

		local unique_client_names = vim.fn.uniq(buf_client_names)
		local language_servers = "(" .. table.concat(unique_client_names, " ") .. ")"
		return language_servers
	end,
	cond = hide_in_width,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = icons.ui.lsp_error,
		warn = icons.ui.lsp_warn,
		info = icons.ui.lsp_info,
		hint = icons.ui.lsp_hint,
	},
	colored = true,
	update_in_insert = true,
	always_visible = false,
}

local mode = {
	function()
		return icons.ui.mode_icon
	end,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = icons.git.add, modified = icons.git.modified, removed = icons.git.delete }, -- changes diff symbols
	cond = hide_in_width,
}

local branch = {
	"b:gitsigns_head",
	padding = 1,
	icon = icons.git.git,
	color = { bg = "#141b24" },
	cond = hide_in_width,
}

local filename = {
	"filename",
	path = 4,
	symbols = {
		modified = icons.ui.plus_square, -- Text to show when the file is modified.
		readonly = icons.ui.minus_square, -- Text to show when the file is non-modifiable or readonly.
		unnamed = icons.ui.empty, -- Text to show for unnamed buffers.
		newfile = icons.ui.new, -- Text to show for newly created file before first write
	},
}

local windows = {
	"windows",
	use_mode_colors = true,
}

local tabs = {
	"tabs",
}

lualine.setup({
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch, diff, filename },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { lsp, diagnostics },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
	tabline = { lualine_a = { windows }, lualine_y = { tabs } },
	extensions = {},
})

require("lualine").hide({ place = { "tabline" } })
local lualine_tmp = vim.api.nvim_create_augroup("lualine_tmp", { clear = true })
vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "TabNew", "TabClosed" }, {
	group = lualine_tmp,
	callback = function(args)
		local win_num = vim.fn.winnr("$")
		local tab_num = vim.fn.tabpagenr("$")

		if tab_num > 1 then
			require("lualine").hide({ place = { "tabline" }, unhide = true })
		else
			require("lualine").hide({ place = { "tabline" } })
		end
		if win_num >= 2 and args.event == "WinNew" then
			require("lualine").hide({ place = { "tabline" }, unhide = true })
		elseif win_num <= 2 and args.event == "WinClosed" then
			require("lualine").hide({ place = { "tabline" } })
		end
	end,
})
