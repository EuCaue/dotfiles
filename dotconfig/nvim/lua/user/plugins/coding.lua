return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		event = "BufReadPost",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			require("user.plugins.settings.treesitter")
		end,
	}, -- a better highlight for everything
	{
		"L3MON4D3/LuaSnip",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			history = true,
			region_check_events = "InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
		},
		build = "make install_jsregexp",
		config = function()
			require("luasnip").filetype_extend("typescript", { "css" })
		end,
	}, --  Snippet Engine

	{ "rafamadriz/friendly-snippets", priority = 51 }, -- a bunch of snippets

	{
		"akinsho/toggleterm.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("user.plugins.settings.toggleterm")
		end,
	}, -- show a "portable" terminal

	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		event = { "BufReadPost", "BufNewFile" },
		build = "yarn install --frozen-lockfile && yarn compile",
		priority = 51,
	}, -- JS snippets

	{
		"barrett-ruth/live-server.nvim",
		event = { "BufReadPost", "BufNewFile" },
		build = "yarn global add live-server",
		config = function()
			require("live-server").setup({
				args = { "--port=3000", "--browser=firefox-developer-edition" },
			})
		end,
		cmd = { "LiveServerStart", "LiveServerStop" },
	}, -- LiveServer

	{
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	}, -- Comment Plugin

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("user.plugins.lsp.lsp")
			require("user.plugins.lsp.mason")
			require("user.plugins.lsp.null-ls")
		end,
	}, -- LSP

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"dburian/cmp-markdown-link",
			"jcha0713/cmp-tw2css",
			{ "mtoohey31/cmp-fish", ft = "fish" },
			{ "hrsh7th/cmp-nvim-lua", ft = "lua" },
			"amarakon/nvim-cmp-fonts",
			"saadparwaiz1/cmp_luasnip",
			"dcampos/cmp-emmet-vim",
			"ray-x/cmp-treesitter",
		},
		config = function()
			require("user.plugins.lsp.cmp")
		end,
	}, -- Auto complete

	{
		"williamboman/mason.nvim",
		-- build = ":MasonUpdate",
		cmd = "Mason",
	}, -- LSP Package Manager
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" }, -- Global Formatter
	{ "simrat39/rust-tools.nvim", ft = "rust" }, -- Better rust tools

	{
		"Saecki/crates.nvim",
		version = "v0.3.*",
		ft = "rust",
		config = function()
			require("crates").setup({})
			require("crates").show()
		end,
	}, -- Better rust tools
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufRead", "BufNewFile" },
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({})
		end,
	}, --  better folding
	-- { "Exafunction/codeium.vim" }, -  ia like copilot
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				status_text = {
					enabled = true,
					-- Text to provide when code actions are available
					text = "💡",
					-- Text to provide when no actions are available
					text_unavailable = "",
				},
				autocmd = {
					enabled = true,
					-- see :help autocmd-pattern
					pattern = { "*" },
					-- see :help autocmd-events
					events = { "CursorHold", "CursorHoldI" },
				},
			})
		end,
	}, --  show code actions

	{ "jose-elias-alvarez/typescript.nvim" }, -- typescript lsp plugin
	{ "windwp/nvim-ts-autotag", event = "BufReadPre" }, -- <> autoclose tag
	{ "mattn/emmet-vim", event = { "BufReadPre", "BufNewFile" } }, -- emmet
	{ "styled-components/vim-styled-components" }, -- highlight for styled-components
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" }, -- Better JSX + TSX comment
}
