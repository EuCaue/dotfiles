local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local lsp = {
	function(msg)
		local clients = 0
		msg = msg or "[LSP Inactive]"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			if type(msg) == "boolean" or #msg == 0 then
				return "[LSP Inactive]"
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
		local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"
		return language_servers
	end,
	color = { gui = "bold" },
	component_separators = { right = "", left = " " },
	cond = hide_in_width,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	colored = true,
	color = { gui = "bold" },
	update_in_insert = false,
	always_visible = false,
	component_separators = { right = "", left = " " },
	section_separators = { right = "", left = " " },
}

local mode = {
	function()
		return " " .. "" .. " "
	end,
	padding = { left = 0, right = 0 },
	color = {},
	cond = nil,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
	color = { gui = "bold" },
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon_only = false,
	padding = { left = 1, right = 1 },
	section_separators = { right = " ", left = " " },
	component_separators = { right = " ", left = " " },
}

local filename = {
	"filename",
	color = { gui = "bold" },
	icons_enabled = true,
	file_status = false,
}

local branch = {
	"b:gitsigns_head",
	icon = "",
	color = { gui = "bold" },
}

local location = {
	"location",
	-- padding = 0,
	color = { gui = "bold" },
}

local progress = {
	"progress",
	fmt = function()
		return "%P/%L"
	end,
	color = {},
}

local time = {
	"datetime",
	component_separators = { right = "", left = " " },
	fmt = function()
		return os.date("%H:%M:%S")
	end,
}

lualine.setup({
	options = {
		icons_enabled = true,
		component_separators = { right = "", left = " " },
		section_separators = { right = "", left = " " },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { diff, filetype },
		lualine_x = { time, diagnostics, lsp },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	-- winbar = winbar,
	tabline = {},
	extensions = { "nvim-tree", "neo-tree" },
})
