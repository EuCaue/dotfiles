return {
	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme rose-pine]])
		end,
	}, -- colorscheme

	{ "Mofiqul/adwaita.nvim" },
	{ "LunarVim/darkplus.nvim" },

	-- BetterComment
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- Better JSX + TSX comment

	--  BetterHighlight
	-- { "styled-components/vim-styled-components" }, -- highlight for styled-components
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- a better highlight for everything
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "NvChad/nvim-colorizer.lua" }, -- CSS COLORS
	{ "p00f/nvim-ts-rainbow" }, -- {} colored
	{ "theRealCarneiro/hyprland-vim-syntax" }, -- Better syntax highlight in hyprland.conf

	-- Snippets
	{ "l3mon4d3/luasnip" },
	{ "rafamadriz/friendly-snippets" },
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		build = "yarn install --frozen-lockfile && yarn compile",
	},

	-- IDE
	{ "kyazdani42/nvim-web-devicons" },
	{ "neovim/nvim-lspconfig", event = "BufReadPre" }, -- LSP
	{ "SmiteshP/nvim-navic" },
	{ "fgheng/winbar.nvim" },
	{ "simrat39/symbols-outline.nvim" },
	{ "kyazdani42/nvim-tree.lua" }, -- Tree file
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
	{ "lewis6991/gitsigns.nvim", version = "release" }, -- Git
	{ "nvim-telescope/telescope.nvim", version = "0.1.0" }, -- fzf finder
	{ "nvim-lua/plenary.nvim" },
	{ "karb94/neoscroll.nvim" }, -- better scroll
	{ "folke/which-key.nvim" }, -- which key
	{ "petertriho/nvim-scrollbar" }, -- scrollbar
	{ "nvim-telescope/telescope-project.nvim" }, -- find projects
	{ "rcarriga/nvim-notify" }, -- notify
	{ "debugloop/telescope-undo.nvim" },
	{ "shortcuts/no-neck-pain.nvim" },
	{ "goolord/alpha-nvim" }, -- title screen
	{ "LunarVim/Colorschemes" },
	{ "yamatsum/nvim-cursorline" },
	{ "j-hui/fidget.nvim" },
	{ "yamatsum/nvim-cursorline" },
	{ "antoinemadec/FixCursorHold.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "asiryk/auto-hlsearch.nvim" },
	{ "tamago324/lir.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "utilyre/barbecue.nvim" },
	{ "kosayoda/nvim-lightbulb" },
	{ "akinsho/toggleterm.nvim" }, -- show a "portable" terminal

	-- Useful

	{
		"antonk52/markdowny.nvim",
		config = function()
			require("markdowny").setup()
		end,
	},

	{ "nvim-lua/popup.nvim" }, -- PopUp API for neovim
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	}, -- TODO:
	{ "princejoogie/chafa.nvim" },
	{ "m00qek/baleia.nvim" },

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
			{ "mtoohey31/cmp-fish", ft = "fish" },
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"amarakon/nvim-cmp-fonts",
			"saadparwaiz1/cmp_luasnip",
			"dcampos/cmp-emmet-vim",
			{ "ray-x/cmp-treesitter" },
		},
		config = function()
			require("user.cmp")
		end,
	},

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
}
