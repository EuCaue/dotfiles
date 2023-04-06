local icons = require("user.icons")
return {
	-- Colorscheme

	{
		"RRethy/nvim-base16",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.colors_name = "base16-da-one-black"
			-- require("base16-colorscheme").setup({
			-- 	base00 = "#000000",
			-- 	base01 = "#000000",
			-- 	base02 = "#202020",
			-- 	base03 = "#888888",
			-- 	base04 = "#c8c8c8",
			-- 	base05 = "#ffffff",
			-- 	base06 = "#ffffff",
			-- 	base07 = "#ffffff",
			-- 	base08 = "#fa7883",
			-- 	base09 = "#ffc387",
			-- 	base0A = "#ff9470",
			-- 	base0B = "#98c379",
			-- 	base0C = "#8af5ff",
			-- 	base0D = "#6bb8ff",
			-- 	base0E = "#e799ff",
			-- 	base0F = "#b3684f",
			-- })
			-- require("base16-colorscheme").setup({
			-- 	base00 = "#000000",
			-- 	base01 = "#000000",
			-- 	base02 = "#202020",
			-- 	base03 = "#6c6c66",
			-- 	base04 = "#918f88",
			-- 	base05 = "#b5b3aa",
			-- 	base06 = "#d9d7cc",
			-- 	base07 = "#fdfbee",
			-- 	base08 = "#ff6c60",
			-- 	base09 = "#e9c062",
			-- 	base0A = "#ffffb6",
			-- 	base0B = "#a8ff60",
			-- 	base0C = "#c6c5fe",
			-- 	base0D = "#96cbfe",
			-- 	base0E = "#ff73fd",
			-- 	base0F = "#b18a3d",
			-- })
			require("base16-colorscheme").setup({
				base00 = "#000000",
				base01 = "#000000",
				base02 = "#202020",
				base03 = "#545454",
				base04 = "#7e7e7e",
				base05 = "#a8a8a8",
				base06 = "#d2d2d2",
				base07 = "#fcfcfc",
				base08 = "#fc5454",
				base09 = "#a85400",
				base0A = "#fcfc54",
				base0B = "#54fc54",
				base0C = "#54fcfc",
				base0D = "#5454fc",
				base0E = "#fc54fc",
				base0F = "#00a800",
			})
			-- 	-- vim.cmd([[colorscheme elflord]])
		end,
	},

	{
		"bluz71/vim-moonfly-colors",
		-- 	lazy = false,
		-- 	priority = 1000,
		-- 	config = function()
		-- 		vim.cmd([[colorscheme moonfly]])
		-- 		vim.api.nvim_command("highlight Normal guibg=#000000")
		-- 	end,
	},
	{
		"olimorris/onedarkpro.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme onedark_dark]])
		-- end,
	},
	--
	-- BetterComment
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- Better JSX + TSX comment

	--  BetterHighlight
	{ "styled-components/vim-styled-components" }, -- highlight for styled-components
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufReadPost" }, -- a better highlight for everything
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "NvChad/nvim-colorizer.lua" }, -- CSS COLORS
	{ "p00f/nvim-ts-rainbow" }, -- {} colored
	{ "theRealCarneiro/hyprland-vim-syntax" }, -- Better syntax highlight in hyprland.conf

	-- Snippets
	{
		--  Snippet Engine
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip").filetype_extend("typescript", { "css" })
		end,
	},
	{ "rafamadriz/friendly-snippets", priority = 51 }, -- a bunch of snippets
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		build = "yarn install --frozen-lockfile && yarn compile",
		priority = 51,
	},

	-- IDE
	{ "kyazdani42/nvim-web-devicons" }, -- icons
	{ "neovim/nvim-lspconfig", event = "BufReadPre" }, -- LSP
	{ "SmiteshP/nvim-navic" }, -- better location
	{
		"SmiteshP/nvim-navbuddy",
		event = "LspAttach",
		config = function()
			require("nvim-navbuddy").setup({
				icons = icons,
			})
		end,
	},
	{ "simrat39/symbols-outline.nvim" },
	{ "mattn/emmet-vim" }, -- emmet
	{ "mbbill/undotree" }, -- undo tree
	{ "kdheepak/lazygit.nvim" }, -- lazygit inside nvim
	{ "lukas-reineke/indent-blankline.nvim" }, -- indent blankline
	{ "akinsho/bufferline.nvim", version = "v3.*" },
	{ "editorconfig/editorconfig-vim" }, -- Editorconfig
	{ "terryma/vim-multiple-cursors" }, -- CTRL + N for multiple cursors
	{ "windwp/nvim-autopairs" }, -- auto close ({[
	{ "nvim-lualine/lualine.nvim" }, -- status bar
	{ "windwp/nvim-ts-autotag" }, -- <> autoclose tag
	{ "lewis6991/gitsigns.nvim" }, -- Git
	{ "nvim-telescope/telescope.nvim", version = "0.1.x" }, -- fzf finder
	{ "nvim-lua/plenary.nvim" },
	{ "karb94/neoscroll.nvim" }, -- better scroll
	{ "folke/which-key.nvim", lazy = true }, -- which key
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
	{ "petertriho/nvim-scrollbar" }, -- scrollbar
	{ "nvim-telescope/telescope-project.nvim" }, -- find projects
	{ "onsails/lspkind.nvim" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({})
		end,
	},
	-- { "Exafunction/codeium.vim" }, -  ia like copilot
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({})
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		version = "*",
		dependencies = { "MunifTanjim/nui.nvim", lazy = true },
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},

	{
		"utilyre/barbecue.nvim",
		version = "*",
		config = function()
			local icons = require("user.icons")
			require("barbecue").setup({
				kinds = icons,
			})
		end,
	}, -- winbar + navic

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
	}, -- notify
	{ "debugloop/telescope-undo.nvim" }, -- telescope for undo tree
	{ "shortcuts/no-neck-pain.nvim" }, -- center neovim
	{ "goolord/alpha-nvim" }, -- title screen
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				window = {
					relative = "editor", -- where to anchor, either "win" or "editor"
					blend = 0, -- &winblend for the window
				},
			})
		end,
	}, -- lsp status
	{ "yamatsum/nvim-cursorline" }, -- highlight cursor on things
	{ "antoinemadec/FixCursorHold.nvim" }, -- depen
	{ "asiryk/auto-hlsearch.nvim" }, -- better search
	{ "tamago324/lir.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "kosayoda/nvim-lightbulb" }, --  show code actions
	{ "akinsho/toggleterm.nvim" }, -- show a "portable" terminal

	-- Useful
	{
		"antonk52/markdowny.nvim", -- nice keybinds for md
		config = function()
			require("markdowny").setup()
		end,
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" }, -- preview markdow
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "<leader>H", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>h", ":HopWord<cr>", { silent = true })
		end,
	},

	{ "nvim-lua/popup.nvim" }, -- PopUp API for neovim
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	}, -- TODO:
	{
		"JellyApple102/flote.nvim",
		config = function()
			require("flote").setup({})
		end,
		cmd = "Flote",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	}, -- preview markdown files on browser
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({ window = { width = 0.85, backdrop = 0.85, height = 80 } })
		end,
	}, -- zenmode

	-- CMP :
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"dburian/cmp-markdown-link",
			"hrsh7th/cmp-buffer",
			"jcha0713/cmp-tw2css",
			-- { "tzachar/cmp-tabnine", build = "./install.sh" },
			{ "mtoohey31/cmp-fish", ft = "fish" },
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"amarakon/nvim-cmp-fonts",
			"saadparwaiz1/cmp_luasnip",
			"dcampos/cmp-emmet-vim",
			"ray-x/cmp-treesitter",
		},
		config = function()
			require("user.cmp")
		end,
	},

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
}
