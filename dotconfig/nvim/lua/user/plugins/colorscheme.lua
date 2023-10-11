local utils = require("user.utils")

local poi = {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("poimandres").setup({
			bold_vert_split = false, -- use bold vertical separators
			dim_nc_background = false, -- dim 'non-current' window backgrounds
			disable_background = true, -- disable background
			disable_float_background = true, -- disable background for floats
			disable_italics = false, -- disable italics
		})
	end,

	init = function()
		vim.cmd("colorscheme poimandres")
	end,
}

local pale = {
	"JoosepAlviste/palenightfall.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("palenightfall").setup({
			transparent = true,
			color_overrides = {
				background = "#000000",
				background_darker = "#000000",
			},
		})
	end,
}

local onedark = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			transparent = (utils.get_transparency_value() == "true"),
			term_colors = true,
			lualine = {
				transparent = true, -- lualine center bar transparency
			},
			style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			colors = {
				bg0 = "#000000",
				bg1 = "#000000",
				bg2 = "#101010",
				bg3 = "#1e1e1e",
				bg_d = "#000000",
			}, -- Override default colors
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
			code_style = {
				comments = "italic",
				keywords = "italic",
				functions = "none",
				strings = "italic",
				variables = "none",
			},
		})
		vim.cmd([[colorscheme onedark]])
	end,
}

local t = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			light_style = "dark", -- The theme is used when the background is set to light
			transparent = true, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
			sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		})
		vim.cmd("colorscheme tokyonight")
	end,
}

local me = {
	"ramojus/mellifluous.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("mellifluous").setup({
			dim_inactive = false,
			color_set = "tender", -- alduin, mountain, tender
			styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
				comments = { italic = true },
				conditionals = {},
				folds = { bold = true },
				loops = { bold = true },
				functions = {},
				keywords = { italic = true },
				strings = {},
				variables = {},
				numbers = {},
				booleans = { italic = true },
				properties = {},
				types = { italic = true },
				operators = {italic = true},
			},
			transparent_background = {
				enabled = true,
				floating_windows = true,
				telescope = true,
				file_tree = true,
				cursor_line = true,
				status_line = true,
			},
			flat_background = {
				line_numbers = false,
				floating_windows = true,
				file_tree = false,
				cursor_line_number = false,
			},
			plugins = {
				cmp = true,
				gitsigns = true,
				indent_blankline = true,
				telescope = {
					enabled = true,
					nvchad_like = true,
				},
				startify = true,
			},
		})
		vim.cmd("colorscheme mellifluous")
	end,
}

return {
	me,
}
