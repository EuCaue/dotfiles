local cmd = vim.api.nvim_create_user_command
vim.g.diagnostics_visible = true

local build_commands = {
	c = "g++ -std=c++17 -o %:p:r.o %",
	typescript = "bun %",
	cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
	rust = "cargo build --release",
	fish = "./%",
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
			vim.cmd("sp")
			print(file)
			vim.cmd("term " .. command)
			vim.cmd("resize 12N")
			local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
			break
		end
	end
end, {})

-- cmd("ToggleInlayHints", function()
-- 	vim.lsp.inlay_hint.enable(0, vim.lsp.inlay_hint.is_enabled(0))
-- end, {})

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
	vim.cmd("hi TelescopePreviewSize guibg=NONE ctermbg=NONE")
	vim.cmd("hi TelescopePreviewExecute guibg=NONE ctermbg=NONE")
	vim.cmd("hi TelescopePreviewHyphen guibg=NONE ctermbg=NONE")
	vim.cmd("hi FloatBorder ctermbg=NONE guibg=NONE")
	vim.cmd("hi CursorLine gui=bold cterm=bold")
	vim.cmd("hi CmpItemAbbrMatch guibg=NONE ctermbg=NONE")
	vim.cmd("hi CmpItemAbbr guibg=NONE ctermbg=NONE")
end, { desc = "Transparent background" })

cmd("Update", function()
	vim.cmd("Lazy update")
	vim.cmd("MasonUpdate")
end, { desc = "Update" })

--  TODO: work more on this.
cmd("Scratch", function()
	local opts = {
		relative = "editor",
		width = 120,
		height = 30,
		row = 100,
		col = 100,
		border = "single",
		title = "Scratch",
		title_pos = "center",
		style = "minimal",
	}

	local bufnr = vim.fn.bufnr("scratch")
	if bufnr ~= -1 then
		local win = vim.api.nvim_open_win(bufnr, true, opts)
		vim.api.nvim_set_current_win(win)
		return
	end

	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(buf, "scratch")
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>hide<cr>", { desc = "Hide Scratch" })
	vim.api.nvim_open_win(buf, true, opts)
end, { desc = "Open Scratch Buffer" })

cmd("DisableLspSemantic", function()
	for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		vim.api.nvim_set_hl(0, group, {})
	end
end, {})

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
