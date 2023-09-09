local utils = require("user.utils")

local ad = {
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

local c = {
	"titanzero/zephyrium",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme zephyrium]])
		vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi NonText guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi VertSplit guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi Folded guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi SignColumn guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi LineNr guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi EndOfBuffer guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi StatusLine guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi StatusLineNC guibg=NONE ctermbg=NONE]])
	end,
}

local d = {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- Optional; default configuration will be used if setup isn't called.
	config = function()
		require("everforest").setup({
			---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
			---Default is "medium".
			background = "medium",
			---How much of the background should be transparent. 2 will have more UI
			---components be transparent (e.g. status line background)
			transparent_background_level = 2,
			---Whether italics should be used for keywords and more.
			italics = false,
			---Disable italic fonts for comments. Comments are in italics by default, set
			---this to `true` to make them _not_ italic!
			disable_italic_comments = false,
			---By default, the colour of the sign column background is the same as the as normal text
			---background, but you can use a grey background by setting this to `"grey"`.
			sign_column_background = "none",
			---The contrast of line numbers, indent lines, etc. Options are `"high"` or
			---`"low"` (default).
			ui_contrast = "medium",
			---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
			---
			---When this option is used in conjunction with show_eob set to `false`, the
			---end of the buffer will only be hidden inside the active window. Inside
			---inactive windows, the end of buffer filler characters will be visible in
			---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
			dim_inactive_windows = false,
			---Some plugins support highlighting error/warning/info/hint texts, by
			---default these texts are only underlined, but you can use this option to
			---also highlight the background of them.
			diagnostic_text_highlight = false,
			---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
			diagnostic_virtual_text = "coloured",
			---Some plugins support highlighting error/warning/info/hint lines, but this
			---feature is disabled by default in this colour scheme.
			diagnostic_line_highlight = false,
			---By default, this color scheme won't colour the foreground of |spell|, instead
			---colored under curls will be used. If you also want to colour the foreground,
			---set this option to `true`.
			spell_foreground = false,
			---Whether to show the EndOfBuffer highlight.
			show_eob = false,
			---You can override specific highlights to use other groups or a hex colour.
			---This function will be called with the highlights and colour palette tables.
			---@param highlight_groups Highlights
			---@param palette Palette
			on_highlights = function(highlight_groups, palette) end,
			---You can override colours in the palette to use different hex colours.
			---This function will be called once the base and background colours have
			---been mixed on the palette.
			---@param palette Palette
			colours_override = function(palette) end,
		})
		vim.cmd([[colorscheme everforest]])
	end,
}

return {
	pale,
}
