local M = {}

M.telescope = {
	{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", mode = "n", desc = "Recent Files" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", mode = "n", desc = "Find Files" },
	{ "<leader>fb", "<cmd>Telescope file_browser<cr>", mode = "n", desc = "File Browser" },
	{ "<leader>b", "<cmd>Telescope buffers<cr>", mode = "n", desc = "Find Buffers" },
	{ "<leader>fr", "<cmd>Telescope current_buffer_fuzzy_find<cr>", mode = "n", desc = "Fuzzy Find in Buffer" },
	{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", mode = "n", desc = "LSP diagnostics" },
	{ "<leader>fl", "<cmd>Telescope live_grep<cr>", mode = "n", desc = "Find Words" },
	{ "<leader>fs", "<cmd>Telescope grep_string<cr>", mode = "n", desc = "Find Word under the cursor" },
	-- { "<leader>fp", "<cmd>Telescope project<cr>", mode = "n", desc = "Find Projects" },
	{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", mode = "n", desc = "Change Colorscheme" },
	{ "<leader>fg", "<cmd>Telescope git_status<cr>", mode = "n", desc = "Check git status" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", mode = "n", desc = "Keymaps" },
	-- { "<leader>fu", "<cmd>Telescope undo<cr>", mode = "n", desc = "Undo Tree" },
	{ "<leader>fv", "<cmd>cd ~/Documents/vault/ | Telescope file_browser<cr>", mode = "n", desc = "Personal Notes" },
	{ "<leader>ft", "<cmd>TodoTelescope<cr>", mode = "n", desc = "Find Todos" },
	-- { "<leader>fh", "<cmd>Telescope harpoon marks<cr>", mode = "n", desc = "See harpoon marks" },
	{ "<leader>fj", "<cmd>Telescope jumplist<cr>", mode = "n", desc = "Telescope Jumplist" },
	{ "<leader>fj", "<cmd>Telescope jumplist<cr>", mode = "n", desc = "Telescope Jumplist" },
	{ "<leader><leader>t", "<cmd>Telescope<cr>", mode = "n", desc = "Telescope Builtins Options" },
	{ "<leader>fa", "<cmd>lua require('search').open()<cr>", mode = "n", desc = "Search all things" },
}

M.minifiles = {
	{ "<leader>mf", "<cmd>lua MiniFiles.open()<cr>", mode = { "n", "v" }, desc = "Open MiniFiles" },
}

M.session_manager = {
	{ "<leader>sl", "<cmd>SessionManager load_session<cr>", mode = "n", desc = "List Sessions" },
	{ "<leader>sd", "<cmd>SessionManager delete_session<cr>", mode = "n", desc = "Delete Sessions" },
	{ "<leader>sc", "<cmd>SessionManager save_current_session<cr>", mode = "n", desc = "Save Current Session" },
	{ "<leader>ss", "<cmd>SessionManager load_last_session<cr>", mode = "n", desc = "Load Last Session" },
}

M.harpoon = {
	{
		"<leader>ha",
		"<cmd>lua require('harpoon.mark').add_file(vim.fn.expand('%')) vim.notify('File add to harpoon: ' .. vim.fn.expand('%:t'))<cr>",
		mode = { "n", "v" },
		desc = "Add a file to harpoon",
	},
	{ "<leader>hs", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", mode = "n", desc = "Open harpoon UI" },
	{ "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", mode = "n", desc = "Harpoon Go Next" },
	{ "<leader>hp", "<cmd>lua require('harpoon.tmux-ui').nav_prev()<cr>", mode = "n", desc = "Harpoon Go Prev" },
	{
		"<leader>hc",
		"<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",
		mode = "n",
		desc = "Harpoon Commands UI",
	},
}

M.git_signs = {
	{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", mode = { "n", "v" }, desc = "Preview Git Hunk" },
	{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>", mode = { "n", "v" }, desc = "Git Blame Line" },
}

M.neogit = {
	{ "<leader>gf", "<cmd>Neogit kind=floating<cr>", mode = { "n", "v" }, desc = "Neogit floating" },
	{ "<leader>gv", "<cmd>Neogit kind=vsplit<cr>", mode = { "n", "v" }, desc = "Neogit vsplit" },
}

M.ufo = {
	{ "zp", "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<cr>", mode = "n", desc = "Preview Fold" },
}

M.toggler = {
	{ "<leader>i", "<cmd>lua require('nvim-toggler').toggle()<cr>", mode = "n", desc = "Toggle Things" },
}

M.notify = {
	{
		"<leader>cn",
		"<cmd>lua require('notify').dismiss({ silent = true, pending = true })<cr>",
		mode = { "n", "v" },
		desc = "Close All Notifications",
	},
}

M.ccc = {
	{
		"<leader>ct",
		"<cmd>CccConvert<cr>",
		mode = "n",
		desc = "Toggle color type",
	},
	{
		"<leader>ct",
		"<cmd>CccPick<cr>",
		mode = "n",
		desc = "Open Color Picker",
	},
}

M.todo_comments = {
	{
		"gcmh",
		function()
			vim.cmd("norm gcO HACK:  ")
			vim.cmd("startinsert")
		end,
		mode = "n",
		desc = "Create a hack comment",
	},
	{
		"gcmn",
		function()
			vim.cmd("norm gcO NOTE:  ")
			vim.cmd("startinsert")
		end,
		mode = "n",
		desc = "Create a note comment",
	},
	{
		"gcmt",
		function()
			vim.cmd("norm gcO TODO:  ")
			vim.cmd("startinsert")
		end,
		mode = "n",
		desc = "Create a todo comment",
	},
	{
		"gcmf",
		function()
			vim.cmd("norm gcO FIX:  ")
			vim.cmd("startinsert")
		end,
		mode = "n",
		desc = "Create a fix comment",
	},
	{
		"gcmb",
		function()
			vim.cmd("norm gcO BUG:  ")
			vim.cmd("startinsert")
		end,
		mode = "n",
		desc = "Create a bug comment",
	},
	{
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		mode = "n",
		desc = "Next todo comment",
	},
	{
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		mode = "n",
		desc = "Previous todo comment",
	},
}

M.comments = {
	{
		"<C-_>",
		"<cmd>normal gcA<cr>",
		mode = { "n", "i", "x" },
		desc = "Comment",
	},
	{
		"<C-/>",
		"<cmd>normal gcA<cr>",
		mode = { "n", "i", "x" },
		desc = "Comment",
	},
	{
		"gcy",
		function()
			vim.cmd("norm yy")
			vim.cmd("norm gcc")
		end,
		mode = "n",
		desc = "Yank and comment",
	},
}

return M
