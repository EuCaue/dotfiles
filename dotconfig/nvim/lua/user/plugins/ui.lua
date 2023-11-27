local icons = require("user.utils").icons_selected
local utils = require("user.utils")

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("user.plugins.settings.lualine")
		end,
	}, -- Status Bar

	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	}, -- LSP progress

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			require("user.plugins.settings.alpha")
		end,
		cmd = "Alpha",
	}, -- Splash Screen

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	}, -- better ui

	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPost" },
		config = function()
			require("user.plugins.settings.hlchunk")
		end,
	}, -- Highlight chunks

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
	}, -- IDE Breadcrumbs

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	}, -- icons

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true }, -- PopUp API for neovim
}
