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
	--
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	event = "BufRead",
	-- 	init = function()
	-- 		require("user.plugins.settings.barbar")
	-- 	end,
	--
	-- 	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	-- },

	{ "j-morano/buffer_manager.nvim", opts = {} },

	-- {
	--   "tiagovla/scope.nvim",
	--   config = function()
	--     require("scope").setup()
	--   end,
	-- },

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
				icons = icons,
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
				icons = icons,
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

	-- {
	--   "utilyre/barbecue.nvim",
	--   event = { "BufReadPre", "BufNewFile" },
	--   version = "*",
	--   config = function()
	--     -- triggers CursorHold event faster
	--     vim.opt.updatetime = 200
	--
	--     require("barbecue").setup({
	--       create_autocmd = false, -- prevent barbecue from updating itself automatically
	--       kinds = icons,
	--     })
	--
	--     vim.api.nvim_create_autocmd({
	--       "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	--       "BufWinEnter",
	--       "CursorHold",
	--       "InsertLeave",
	--
	--       -- include this if you have set `show_modified` to `true`
	--       "BufModifiedSet",
	--     }, {
	--       group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	--       callback = function()
	--         require("barbecue.ui").update()
	--       end,
	--     })
	--   end,
	-- }, -- winbar + navic

	{
		"Bekaboo/dropbar.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
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
			menu = {
				win_confings = {
					border = utils.border_status,
				},
			},
		},
	},

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
