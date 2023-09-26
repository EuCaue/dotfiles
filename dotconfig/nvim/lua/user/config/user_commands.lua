local c = vim.api.nvim_create_user_command

local build_commands = {
	c = "g++ -std=c++17 -o %:p:r.o %",
	typescript = "bun %",
	cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
	rust = "cargo build --release",
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
}

c("Build", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(build_commands) do
		if filetype == file then
			vim.cmd("!" .. command)
			break
		end
	end
end, {})

c("DebugBuild", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(debug_build_commands) do
		if filetype == file then
			vim.cmd("!" .. command)
			break
		end
	end
end, {})

c("Run", function()
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

c("Ha", function()
	vim.cmd([[Build]])
	vim.cmd([[Run]])
end, {})
