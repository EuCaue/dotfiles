local icons = require("user.icons")
local theme = require("user.theme")
return {
	-- Colorscheme
	theme,
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
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "simrat39/rust-tools.nvim" },
	{
		"Saecki/crates.nvim",
		version = "v0.3.*",
		config = function()
			require("crates").setup({})
			require("crates").show()
		end,
	},
	{ "jose-elias-alvarez/typescript.nvim" },
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
		"Shatur/neovim-session-manager",
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
				path_replacer = "__", -- The character to which the path separator will be replaced for session files.
				colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
				autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit and on session switch.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
				autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
				autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
					"alpha",
					"gitcommit",
				},
				autosave_ignore_buftypes = {}, -- All buffers of these buffer types will be closed before the session is saved.
				autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
				max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})
		end,
	},

	{
		"utilyre/barbecue.nvim",
		version = "*",
		config = function()
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

	{ "ThePrimeagen/harpoon" },
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
		ft = "markdown",
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
		event = { "InsertEnter", "CmdlineEnter" },
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
			"ray-x/cmp-treesitter",
		},
		config = function()
			require("user.cmp")
		end,
	},

	{ "williamboman/mason.nvim", build = ":MasonUpdate", cmd = "Mason" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
}
