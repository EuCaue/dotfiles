local one_monokai = {
	"cpea2506/one_monokai.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("one_monokai").setup({
			themes = function()
				return {
					Normal = { bg = "#000000" },
				}
			end,
		})
		vim.cmd([[colorscheme one_monokai]])

		local links = {
			["@lsp.type.namespace"] = "@namespace",
			["@lsp.type.type"] = "@type",
			["@lsp.type.class"] = "@type",
			["@lsp.type.enum"] = "@type",
			["@lsp.type.interface"] = "@type",
			["@lsp.type.struct"] = "@structure",
			["@lsp.type.parameter"] = "@parameter",
			["@lsp.type.variable"] = "@variable",
			["@lsp.type.property"] = "@property",
			["@lsp.type.enumMember"] = "@constant",
			["@lsp.type.function"] = "@function",
			["@lsp.type.method"] = "@method",
			["@lsp.type.macro"] = "@macro",
			["@lsp.type.decorator"] = "@function",
		}
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
}

local gruvbox = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			inverse = true, -- invert background for search, diffs, statuslines and errors
			palette_overrides = {
				dark0 = "#000000",
				dark1 = "#000000",
			},
			overrides = {
				Normal = { bg = "#000000" },
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}

local onedarkpro = {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			highlights = {
				Normal = { bg = "#000000" },
			},
		})
		vim.cmd([[colorscheme onedark_dark]])
		local links = {
			["@lsp.type.namespace"] = "@namespace",
			["@lsp.type.type"] = "@type",
			["@lsp.type.class"] = "@type",
			["@lsp.type.enum"] = "@type",
			["@lsp.type.interface"] = "@type",
			["@lsp.type.struct"] = "@structure",
			["@lsp.type.parameter"] = "@parameter",
			["@lsp.type.variable"] = "@variable",
			["@lsp.type.property"] = "@property",
			["@lsp.type.enumMember"] = "@constant",
			["@lsp.type.function"] = "@function",
			["@lsp.type.method"] = "@method",
			["@lsp.type.macro"] = "@macro",
			["@lsp.type.decorator"] = "@function",
		}
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
}

local onenord = {
	"rmehri01/onenord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onenord").setup({
			theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
			borders = true, -- Split window borders
			custom_highlights = {}, -- Overwrite default highlight groups
			custom_colors = { bg = "#000000", active = "#000000" }, -- Overwrite default colors
		})
		vim.cmd([[colorscheme onenord]])
	end,
}

local gruvbox_baby = {
	"luisiacc/gruvbox-baby",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_baby_background_color = "dark"
		vim.g.gruvbox_baby_highlights = {
			Normal = { bg = "#000000" },
		}
		vim.g.gruvbox_baby_color_overrides = {
			background = "#000000",
			-- dark_gray = "#202020",
			background_light = "#202020",
			medium_gray = "#202020",
		}
		vim.cmd([[colorscheme gruvbox-baby]])
		vim.cmd([[hi LineNr guifg=#504945]])
		vim.cmd([[hi TelescopeMatching guifg=Gray]])

		local links = {
			["@lsp.type.namespace"] = "@namespace",
			["@lsp.type.type"] = "@type",
			["@lsp.type.class"] = "@type",
			["@lsp.type.enum"] = "@type",
			["@lsp.type.interface"] = "@type",
			["@lsp.type.struct"] = "@structure",
			["@lsp.type.parameter"] = "@parameter",
			["@lsp.type.variable"] = "@variable",
			["@lsp.type.property"] = "@property",
			["@lsp.type.enumMember"] = "@constant",
			["@lsp.type.function"] = "@function",
			["@lsp.type.method"] = "@method",
			["@lsp.type.macro"] = "@macro",
			["@lsp.type.decorator"] = "@function",
		}
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
}
local onedark = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			-- Main options --
			style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			-- Custom Highlights --
			colors = { bg0 = "#000000", bg1 = "#000000", bg2 = "#101010", bg3 = "#101010", bg_d = "#000000" }, -- Override default colors
			highlights = {}, -- Override highlight groups
			diagnostics = {
				darker = false, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		})
		vim.cmd([[colorscheme onedark]])

		local links = {
			["@lsp.type.namespace"] = "@namespace",
			["@lsp.type.type"] = "@type",
			["@lsp.type.class"] = "@type",
			["@lsp.type.enum"] = "@type",
			["@lsp.type.interface"] = "@type",
			["@lsp.type.struct"] = "@structure",
			["@lsp.type.parameter"] = "@parameter",
			["@lsp.type.variable"] = "@variable",
			["@lsp.type.property"] = "@property",
			["@lsp.type.enumMember"] = "@constant",
			["@lsp.type.function"] = "@function",
			["@lsp.type.method"] = "@method",
			["@lsp.type.macro"] = "@macro",
			["@lsp.type.decorator"] = "@function",
		}
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
}
local darkrose = {
	"water-sucks/darkrose.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme darkrose]])

		local links = {
			["@lsp.type.namespace"] = "@namespace",
			["@lsp.type.type"] = "@type",
			["@lsp.type.class"] = "@type",
			["@lsp.type.enum"] = "@type",
			["@lsp.type.interface"] = "@type",
			["@lsp.type.struct"] = "@structure",
			["@lsp.type.parameter"] = "@parameter",
			["@lsp.type.variable"] = "@variable",
			["@lsp.type.property"] = "@property",
			["@lsp.type.enumMember"] = "@constant",
			["@lsp.type.function"] = "@function",
			["@lsp.type.method"] = "@method",
			["@lsp.type.macro"] = "@macro",
			["@lsp.type.decorator"] = "@function",
		}
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
}

return onedark 
