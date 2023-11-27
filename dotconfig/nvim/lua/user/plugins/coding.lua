return {

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "InsertEnter",
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", event = "InsertEnter" }, -- Better JSX + TSX comment
		},
		config = function()
			require("user.plugins.settings.treesitter")
		end,
	}, -- a better highlight for everything

	{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} }, -- <> autoclose tags

	{
		"L3MON4D3/LuaSnip",
		event = { "InsertEnter" },
		dependencies = {
			{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets
		},
		build = "make install_jsregexp",
		config = function()
			require("user.plugins.settings.luasnip")
		end,
	}, --  Snippet Engine

	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		opts = {
			{
				ui = {
					border = "single",
				},
			},
		},
	}, -- flutter tools

	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		build = "yarn install --frozen-lockfile && yarn compile",
	}, -- JS/JSX snippets

	{
		"barrett-ruth/live-server.nvim",
		ft = "html",
		build = "yarn global add live-server",
		opts = {
			args = { "--port=5137", "--browser=min" },
		},
		cmd = { "LiveServerStart", "LiveServerStop" },
	}, -- LiveServer

	{
		"numToStr/Comment.nvim",
		keys = require("user.config.plugin_keymaps").comments,
		event = "BufReadPost",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	}, -- Comment Plugin

	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("user.plugins.lsp.lsp")
			require("user.plugins.lsp.mason")
			require("user.plugins.lsp.efm-ls")
		end,
	}, -- LSP

	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	}, -- Better tsserver

	{
		"stevearc/conform.nvim",
		event = "LspAttach",
		config = function()
			require("user.plugins.settings.conform")
		end,
	}, -- Formatter

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "mtoohey31/cmp-fish", ft = "fish" },
			"amarakon/nvim-cmp-fonts",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("user.plugins.lsp.cmp")
		end,
	}, -- Auto complete

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonUpdate", "MasonInstall" },
	}, -- LSP Package Manager

	{ "williamboman/mason-lspconfig.nvim" },
	{ "simrat39/rust-tools.nvim", ft = "rust" }, -- Rust tools

	{
		"Saecki/crates.nvim",
		version = "v0.3.*",
		ft = "rust",
		config = function()
			require("crates").setup({})
			require("crates").show()
		end,
	}, -- Better Rust Management packages

	{
		"kevinhwang91/nvim-ufo",
		keys = require("user.config.plugin_keymaps").ufo,
		event = "BufReadPost",
		dependencies = "kevinhwang91/promise-async",
		opts = {},
	}, -- Magically Better folding

	{
		"jcdickinson/codeium.nvim",
		event = "InsertEnter",
		opts = {},
	}, -- Auto Complete IA

	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		opts = {
			sign = {
				enabled = true,
				text = "󱧣",
				hl = "Yellow",
			},

			autocmd = {
				enabled = true,
				pattern = { "*" },
        events = { "CursorHold", "CursorHoldI" },
			},
		},
	}, -- show code actions

	{
		"mfussenegger/nvim-dap",
		cmd = { "DapContinue", "DapToggleBreakpoint" },
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					local dap = require("dap")
					local dapui = require("dapui")

					require("dapui").setup()
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
		},
		config = function()
			local dap = require("dap")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = 8123,
				executable = {
					command = "js-debug-adapter",
				},
			}

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						runtimeExecutable = "ts-node",
					},
				}
			end
		end,
	}, -- Debugging
}
