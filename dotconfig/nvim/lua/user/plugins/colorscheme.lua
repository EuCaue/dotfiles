local pale = {
	"JoosepAlviste/palenightfall.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("palenightfall").setup({
			transparent = true,
		})
	end,
}

local onedark = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			transparent = true,
			term_colors = true,
			lualine = {
				transparent = true, -- lualine center bar transparency
			},
			style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
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
				keywords = "bold",
				functions = "bold",
				strings = "italic",
				variables = "none",
			},
		})
		vim.cmd([[colorscheme onedark]])
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
				conditionals = { bold = true },
				folds = { bold = true },
				loops = { bold = true },
				functions = { bold = true },
				keywords = { italic = true },
				strings = {},
				variables = {},
				numbers = {},
				booleans = { italic = true },
				properties = {},
				types = { italic = true },
				operators = { italic = true },
			},
			transparent_background = {
				enabled = true,
				floating_windows = true,
				telescope = true,
				file_tree = true,
				cursor_line = false,
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
		vim.cmd("hi CursorLine guibg=#101010")
	end,
}

local gh = {
	"projekt0n/github-nvim-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("github-theme").setup({
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/github-theme",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
				hide_nc_statusline = true, -- Override the underline style for non-active statuslines
				transparent = true, -- Disable setting background
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				styles = { -- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
					functions = "bold",
					keywords = "italic",
					variables = "NONE",
					conditionals = "bold",
					constants = "NONE",
					numbers = "NONE",
					operators = "bold",
					strings = "NONE",
					types = "bold",
				},
			},
		})
		vim.cmd("colorscheme github_dark_high_contrast")
	end,
}

local nordic = {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nordic").setup({
			-- Enable bold keywords.
			bold_keywords = true,
			-- Enable italic comments.
			italic_comments = true,
			-- Enable general editor background transparency.
			transparent_bg = true,
			-- Enable brighter float border.
			bright_border = true,
			-- Reduce the overall amount of blue in the theme (diverges from base Nord).
			reduced_blue = true,
			-- Swap the dark background with the normal one.
			swap_backgrounds = true,
			-- Override the styling of any highlight group.
			override = {},
			-- Cursorline options.  Also includes visual/selection.
			cursorline = {
				-- Bold font in cursorline.
				bold = true,
				-- Bold cursorline number.
				bold_number = true,
				-- Avialable styles: 'dark', 'light'.
				theme = "dark",
				-- Blending the cursorline bg with the buffer bg.
				blend = 0.7,
			},
			telescope = {
				-- Available styles: `classic`, `flat`.
				style = "classic",
			},
		})
		require("nordic").load()
	end,
}

local gruber_dark = {
	"thimc/gruber-darker.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruber-darker").setup({
			transparent = true, -- removes the background
			underline = true, -- disables underline fonts
			bold = true, -- disables bold fonts
		})
		vim.cmd.colorscheme("gruber-darker")
	end,
}

return {
  me,
}
