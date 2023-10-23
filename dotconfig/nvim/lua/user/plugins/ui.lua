local icons = require("user.utils").icons_selected
local utils = require("user.utils")

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

	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	event = "BufReadPost",
	-- 	keys = require("user.config.plugin_keymaps").notify,
	-- 	config = function()
	-- 		vim.notify = require("notify")
	-- 		require("notify").setup({
	-- 			timeout = 500,
	-- 			render = "minimal",
	-- 			background_colour = "#00000000",
	-- 		})
	-- 	end,
	-- }, -- better vim.notify

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			require("dressing").setup({})
		end,
	}, -- better ui

	-- {
	--   "folke/noice.nvim",
	--   -- event = "BufRead",
	--
	--   config = function()
	--     require("noice").setup({
	--       popupmenu = {
	--         backend = "cmp",
	--       },
	--       lsp = {
	--         documentation = {
	--           enabled = false,
	--         },
	--         progress = {
	--           enabled = false,
	--           throttle = 8000 / 10, -- frequency to update lsp progress message
	--         },
	--         override = {
	--           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--           ["vim.lsp.util.stylize_markdown"] = true,
	--           ["cmp.entry.get_documentation"] = true,
	--         },
	--       },
	--       presets = {
	--         long_message_to_split = true, -- long messages will be sent to a split
	--         inc_rename = false,           -- enables an input dialog for inc-rename.nvim
	--         lsp_doc_border = false,       -- add a border to hover docs and signature help
	--       },
	--     })
	--   end,
	-- }, -- better ui's

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

	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require("scrollbar").setup()
	-- 		require("scrollbar.handlers.gitsigns").setup()
	-- 	end,
	-- }, -- scrollbar

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
