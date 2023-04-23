local icons = require("user.utils").icons
return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.plugins.settings.lualine")
		end,
	}, -- status bar

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			return require("user.plugins.settings.alpha")
		end,
		cmd = "Alpha",
	}, -- title screen

	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("notify").setup({
				timeout = 500,
				render = "minimal",
				background_colour = "#00000000",
			})
		end,
	}, -- better vim.notify
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			require("dressing").setup({})
		end,
	}, -- better ui

	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	}, -- better ui's

	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		config = function()
			require("user.plugins.settings.bufferline")
		end,
	}, -- Tabs

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
			require("indent_blankline").setup({
				indentLine_enabled = 1,
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"lazy",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
					"",
				},
				buftype_exclude = { "terminal" },
				show_trailing_blankline_indent = false,
				show_first_indent_level = true,
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	}, -- indent blankline

	{
		"SmiteshP/nvim-navic",
		event = "LspAttach",
		config = function()
			return {
				icons = icons.kinds.icons,
				highlight = false,
				separator = "  ",
				depth_limit = 0,
				depth_limit_indicator = "..",
				safe_output = true,
			}
		end,
	}, -- better location

	{
		"SmiteshP/nvim-navbuddy",
		event = "LspAttach",
		config = function()
			require("nvim-navbuddy").setup({
				icons = icons.kinds.icons,
			})
		end,
		cmd = "Navbuddy",
	}, -- Outline symbols

	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	}, -- scrollbar

	{
		"utilyre/barbecue.nvim",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("barbecue").setup({
				kinds = icons.kinds.icons,
			})
		end,
	}, -- winbar + navic

	{
		"folke/zen-mode.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("zen-mode").setup({ window = { width = 0.85, backdrop = 0.85, height = 80 } })
		end,
		cmd = "ZenMode",
	}, -- zenmode

	{
		"shortcuts/no-neck-pain.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = "NoNeckPain",
	}, -- center neovim

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	}, -- icons
	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true }, -- PopUp API for neovim
	{ "nvim-telescope/telescope-ui-select.nvim" }, -- wrap vim.ui()
}
