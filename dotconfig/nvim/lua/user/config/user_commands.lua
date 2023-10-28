local cmd = vim.api.nvim_create_user_command
vim.g.diagnostics_visible = true

local build_commands = {
	c = "g++ -std=c++17 -o %:p:r.o %",
	typescript = "bun %",
	cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
	rust = "cargo build --release",
	fish = "./%",
	python = "python3 %",
	go = "go build",
}

local debug_build_commands = {
	c = "g++ -std=c++17 -g -o %:p:r.o %",
	cpp = "g++ -std=c++17 -g -o %:p:r.o %",
	rust = "cargo build",
	go = "go build",
}

local run_commands = {
	c = "%:p:r.o",
	typescript = "bun %",
	python = "python3 %",
	cpp = "%:p:r.o",
	rust = "cargo run --release",
	go = "go run .",
	fish = "./%",
}

cmd("Build", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(build_commands) do
		if filetype == file then
			vim.cmd("!" .. command)
			break
		end
	end
end, {})

cmd("DebugBuild", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(debug_build_commands) do
		if filetype == file then
			vim.cmd("!" .. command)
			break
		end
	end
end, {})

cmd("LspFormat", function()
	require("conform").format({ async = true, bufnr = 0, lsp_fallback = true })
end, { desc = "Format with LSP" })

cmd("ToggleCursor", function()
	local opt = vim.api.nvim_get_option_value("guicursor", {})
	local pos = string.find(opt, "block", 0, false)

	if pos == 7 then
		vim.api.nvim_set_option_value("guicursor", "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", {})
	else
		vim.api.nvim_set_option_value("guicursor", "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50", {})
	end
end, { desc = "Toggle between cursors styles" })

cmd("Run", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(run_commands) do
		if filetype == file then
			-- vim.cmd("vsplit")
			vim.cmd("sp")
			print(file)
			vim.cmd("term " .. command)
			-- vim.cmd("vertical-resize 120")
			vim.cmd("resize 12N")
			local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
			break
		end
	end
end, {})

cmd("ToggleInlayHints", function()
	-- TODO: get the status of the inlay hints
	vim.lsp.inlay_hint(0, true)
end, {})

cmd("Ha", function()
	vim.cmd([[Build]])
	vim.cmd([[Run]])
end, {})

cmd("Transparent", function()
	vim.cmd("hi Normal ctermbg=NONE guibg=NONE")
	vim.cmd("hi NormalFloat ctermbg=NONE guibg=NONE")
	vim.cmd("hi NormalNC ctermbg=NONE guibg=NONE")
	vim.cmd("hi Pmenu ctermbg=NONE guibg=NONE")
	vim.cmd("hi WinBar ctermbg=NONE guibg=NONE")
	vim.cmd("hi SignColumn ctermbg=NONE guibg=NONE")
	vim.cmd("hi TelescopeNormal ctermbg=NONE guibg=NONE")
	vim.cmd("hi TelescopeBorder ctermbg=NONE guibg=NONE")
	vim.cmd("hi TelescopePromptTitle ctermbg=NONE guibg=NONE")
	vim.cmd("hi TelescopePromptBorder ctermbg=NONE guibg=NONE")
	vim.cmd("hi TelescopePromptNormal ctermbg=NONE guibg=NONE")
	vim.cmd("hi FloatBorder ctermbg=NONE guibg=NONE")
	vim.cmd("hi CursorLine gui=bold cterm=bold")
end, { desc = "Transparent background" })

cmd("Update", function()
	vim.cmd("Lazy update")
	vim.cmd("MasonUpdate")
end, { desc = "Update" })

cmd("ToggleLspDiag", function()
	local buf_clients = vim.lsp.get_clients()
	if next(buf_clients) == nil then
		if type(buf_clients) == "boolean" or #buf_clients == 0 then
			vim.notify("No LSP client found")
			return
		end
	end
	if vim.g.diagnostics_visible then
		vim.g.diagnostics_visible = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_visible = true
		vim.diagnostic.enable()
	end
end, {})
