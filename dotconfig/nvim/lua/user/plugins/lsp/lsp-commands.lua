vim.api.nvim_create_user_command("LspCommands", function()
	local status_ok, Menu = pcall(require, "nui.menu")
	if not status_ok then
		vim.notify("Plugin nui not found", "error")
		return
	end

	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "single",
			text = {
				top = "Select A LSP Command",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = {
			Menu.item("LspStart"),
			Menu.item("LspRestart"),
			Menu.item("LspStop"),
			Menu.item("LspInfo"),
			Menu.item("LspLog"),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>", "l" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			local cmd = item.text
			vim.cmd(cmd)
			vim.notify("Lsp Command:\n" .. cmd)
		end,
	})

	local menu_lsp = Menu({
		position = "50%",
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "single",
			text = {
				top = "Start LSP Server? ",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = {
			Menu.item("Yes"),
			Menu.item("No"),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>", "l" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			if item.text == "Yes" then
				vim.cmd([[LspStart]])
				vim.notify("Lsp's Started")
			end
		end,
	})

	if #vim.lsp.buf_get_clients() == 0 then
		menu_lsp:mount()
	else
		menu:mount()
	end
end, {})
