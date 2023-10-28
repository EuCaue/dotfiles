local M = {}

M.create_select_menu = function(prompt, options_table) -- Or M.create_select_menu = function(prompt, options_table)
	-- Given the table of options, populate a list with option display names
	local option_names = {}
	local n = 0
	for i, _ in pairs(options_table) do
		n = n + 1
		option_names[n] = i
	end
	table.sort(option_names)

	-- Return the prompt function. These global function var will be used when assigning keybindings
	local menu = function()
		vim.ui.select(
			option_names, --> the list we populated above
			{
				prompt = prompt, --> Prompt passed as the argument
				-- Remove this variable if you want to keep the numbering in front of option names
				format_item = function(item)
					return item:gsub("%d. ", "")
				end,
			},

			function(choice)
				local action = options_table[choice]
				-- When user inputs ESC or q, don't take any actions
				if action ~= nil then
					if type(action) == "string" then
						vim.cmd(action)
					elseif type(action) == "function" then
						action()
					end
				end
			end
		)
	end

	return menu
end

M.create_command = function(name, callback)
	vim.api.nvim_create_user_command(name, calback, {})
end

M.get_user = function()
	local user = ""
	if os.getenv("OS") ~= nil and os.getenv("OS"):match("^Windows") then
		user = os.getenv("USERNAME")
	else
		user = os.getenv("USER")
	end
	local s = string.upper(string.sub(user, 1, 1)) .. string.lower(string.sub(user, 2))
	return s
end

M.theme = require("user.utils.theme")

M.border_status = "single" -- "single" "double" "rounded" "none"

M.servers = {
	-- "tsserver",
	-- "vtsls",
	"prosemd_lsp",
	"jedi_language_server",
	"yamlls",
	"bashls",
	"pkgbuild_language_server",
	"lua_ls",
	-- "tailwindcss",
	"emmet_ls",
	"eslint",
	"svelte",
	"marksman",
	"html",
	"rust_analyzer",
	"cssls",
	-- "cssmodules_ls",
	"clangd",
	"jsonls",
	"gopls",
}

M.icons = require("user.utils.icons").icons

M.icons_selected = M.icons.kinds.nvchad

return M
