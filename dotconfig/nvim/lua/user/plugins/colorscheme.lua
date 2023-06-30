local onedark = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			transparent = true,
			lualine = {
				transparent = true, -- lualine center bar transparency
			},
			style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			colors = { bg0 = "#000000", bg1 = "#000000", bg2 = "#101010", bg3 = "#1e1e1e", bg_d = "#000000" }, -- Override default colors
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		})
		vim.cmd([[colorscheme onedark]])
	end,
}

local vscode = {
	"Mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark"
		require("vscode").setup({
			transparent = true,
			italic_comments = true,
			color_overrides = {
				vscBack = "#000000",
				vscTabOutside = "#000000",
				vscPopupBack = "#000000",
				vscTabOther = "#000000",
				vscTabCurrent = "#000000",
			},
		})
		require("vscode").load()
	end,
}

local material = {
	"marko-cerovac/material.nvim",
	lazy = false,
	priorit = 1000,
	config = function()
		local colors = require("material.colors")
		require("material").setup({
			contrast = {
				terminal = true, -- Enable contrast for the built-in terminal
				sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
				floating_windows = true, -- Enable contrast for floating windows
				cursor_line = false, -- Enable darker background for the cursor line
				non_current_windows = true, -- Enable darker background for non-current windows
				filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
			},

			high_visibility = {
				lighter = false, -- Enable higher contrast text for lighter style
				darker = false, -- Enable higher contrast text for darker style
			},

			lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

			async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

			custom_colors = function(colors)
				colors.editor.bg_alt = "#000000"
				colors.editor.bg = "#000000"
				colors.editor.selection = "#101010"
				colors.editor.border = "#000000"
			end, -- If you want to everride the default colors, set this to a function

			disable = {
				colored_cursor = false, -- Disable the colored cursor
				borders = false, -- Disable borders between vertically split windows
				background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
				term_colors = false, -- Prevent the theme from setting terminal colors
				eob_lines = true, -- Hide the end-of-buffer lines
			},
			custom_highlights = {
				NormalNC = { bg = "#000000" },
			},
		})
		vim.g.material_style = "deep ocean"
		vim.cmd([[colorscheme material]])
	end,
}

return {
	onedark,
}
