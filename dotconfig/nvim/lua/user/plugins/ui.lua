local icons = require("user.utils").icons_selected
local utils = require("user.utils")

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("user.plugins.settings.lualine")
		end,
	}, -- status bar
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			return require("user.plugins.settings.alpha")
		end,
		cmd = "Alpha",
	}, -- title screen
	-- Lua

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			require("dressing").setup({})
		end,
	}, -- better ui

	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPost" },
		config = function()
			require("user.plugins.settings.hlchunk")
		end,
	},

	{
		"SmiteshP/nvim-navbuddy",
		event = "LspAttach",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("nvim-navbuddy").setup({
				icons = icons,
			})
		end,
		cmd = "Navbuddy",
	}, -- Outline symbols

	{
		"Bekaboo/dropbar.nvim",
		event = { "LspAttach" },
		opts = {
			icons = {
				kinds = {
					symbols = icons,
				},
				ui = {
					bar = {
						separator = "  ",
					},
				},
			},
			sources = {
				path = {
					relative_to = function(_)
						local current_directory = vim.fn.expand("%:p:h")
						local parent_directory = vim.fn.fnamemodify(current_directory, ":h")
						return parent_directory
					end,
				},
			},
			menu = {
				win_confings = {
					border = utils.border_status,
				},
			},
		},
	},

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	}, -- icons
	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true }, -- PopUp API for neovim
}
