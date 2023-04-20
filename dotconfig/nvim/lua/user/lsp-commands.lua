vim.api.nvim_create_user_command("LspCommands", function()
	local Menu = require("nui.menu")

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

	if #vim.lsp.buf_get_clients() == 0 then
		vim.notify("No LSP client active in buffer", vim.log.levels.WARN)
	else
		menu:mount()
	end
end, {})
