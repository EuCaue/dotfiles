local cmd = vim.api.nvim_create_user_command

local build_commands = {
	c = "g++ -std=c++17 -o %:p:r.o %",
	typescript = "bun %",
	cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
	rust = "cargo build --release",
	fish = "./%",
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
	vim.lsp.inlay_hint(0, true)
end, {})

cmd("Ha", function()
	vim.cmd([[Build]])
	vim.cmd([[Run]])
end, {})
