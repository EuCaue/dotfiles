return {

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		event = "BufReadPost",
		dependencies = {
			{ "windwp/nvim-ts-autotag", event = "BufReadPre", opts = {} }, -- <> autoclose tag
			{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" }, -- Better JSX + TSX comment
		},
		config = function()
			require("user.plugins.settings.treesitter")
		end,
	}, -- a better highlight for everything

	{
		"L3MON4D3/LuaSnip",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets
		},
		build = "make install_jsregexp",
		config = function()
			require("user.plugins.settings.luasnip")
		end,
	}, --  Snippet Engine

	{
		"barrett-ruth/import-cost.nvim",
		event = "BufReadPost",
		build = "sh install.sh yarn",
		config = true,
	},

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
		ft = "html",
		build = "yarn global add live-server",
		config = function()
			require("live-server").setup({
				args = { "--port=5137", "--browser=min" },
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
			require("user.plugins.lsp.efm-ls")
		end,
	}, -- LSP

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
		cmd = "Mason",
	}, -- LSP Package Manager
	{ "williamboman/mason-lspconfig.nvim" },
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

	{
		"jcdickinson/codeium.nvim",
		event = "BufRead",
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		config = function()
			require("nvim-lightbulb").setup({
				sign = {
					enabled = true,
					-- Text to show in the sign column.
					-- Must be between 1-2 characters.
					text = "󱧣",
					-- Highlight group to highlight the sign column text.
					hl = "Yellow",
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
	},
}
