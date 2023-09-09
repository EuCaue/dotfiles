local utils = require("user.utils")
return {
	{ dir = "~/Dev/lua/markvim.nvim", config = true },
	-- {
	--   "nvim-neo-tree/neo-tree.nvim",
	--   version = "*",
	--   event = { "BufReadPost", "BufNewFile" },
	--   config = function()
	--     require("user.plugins.settings.neotree")
	--   end,
	--   cmd = "Neotree",
	-- }, -- tree file manager

	{ "christoomey/vim-tmux-navigator", event = "VimEnter" },
	{
		"m4xshen/hardtime.nvim",
		config = function()
			require("hardtime").setup({
				restricted_keys = {
					["j"] = {},
					["k"] = {},
				},
			})
		end,
	},

	{
		"tzachar/highlight-undo.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},

	{
		"BoaPi/task-toggler.nvim",
		config = true,
		ft = "markdown",
		keys = {
			{
				"<leader><leader>m",
				mode = { "n" },
				"<cmd>TaskTogglerCheck<cr>",
				desc = "Markdown Task Toggle",
			},
		},
	},

	{
		"echasnovski/mini.files",
		config = function()
			require("mini.files").setup({
				mappings = {
					go_in_plus = "<CR>",
					go_out_plus = "<BS>",
				},
			})
		end,
		version = false,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("user.plugins.settings.gitsigns")
		end,
		cmd = "Gitsigns",
	}, --  git status on file

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
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
				max_path_length = 130, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})
		end,
	}, -- Session Manager

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		cmd = { "TodoTelescope" },
	}, -- TODO: plugin

	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = true,
	}, --  move faster

	-- {
	--   "ellisonleao/glow.nvim",
	--   ft = "markdown",
	--   config = true,
	--   cmd = "Glow",
	-- }, -- preview markdown

	{
		"JellyApple102/flote.nvim",
		cmd = "Flote",
	}, -- Quick notes for projects

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.cmd([[
function OpenMarkdownPreview (url)
let cmd = "min --enable-features=UseOzonePlatform --ozone-platform=wayland " . shellescape(a:url) . " &"
silent call system(cmd)
endfunction
]])

			-- vim.g.mkdp_browser = "min"
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
			vim.g.mkdp_open_ip = "127.0.0.1"
			vim.g.mkdp_markdown_css = "/home/caue/dotfiles/dotconfig/markdown.css"
			vim.g.mkdp_highlight_css = "/home/caue/dotfiles/dotconfig/highlight.css"
			vim.g.mkdp_port = 8080
			-- vim.g.mkdp_preview_options = {
			--   content_editable = true,
			-- }
		end,
		cmd = { "MarkdownPreviewToggle" },
	}, -- preview markdown files on browser

	{
		"echasnovski/mini.clue",
		version = false,
		config = function()
			require("user.plugins.settings.miniclue")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		config = function()
			require("user.plugins.settings.telescope")
		end,
		dependencies = {
			{ "debugloop/telescope-undo.nvim" }, -- telescope for undo tree
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
			{ "nvim-telescope/telescope-project.nvim" }, -- find projects
		},
	}, -- Telescope

	{
		"AckslD/muren.nvim",
		event = "BufReadPost",
		config = true,
	},

	{
		"asiryk/auto-hlsearch.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("auto-hlsearch").setup({
				remap_keys = { "/", "?", "*", "#", "n", "N" },
				create_commands = true,
			})
		end,
	}, -- better search

	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup({
				user_default_options = {
					css = true,
					always_update = true,
					tailwind = true, -- Enable tailwind colors
				},
			})
		end,
	}, -- CSS COLORS

	{
		"yamatsum/nvim-cursorline",
		config = true,
	}, -- highlight cursor on things

	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				respect_scrolloff = false,
			})
			local t = {}
			t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
			t["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
			require("neoscroll.config").set_mappings(t)
		end,
	}, -- better scroll

	{
		"windwp/nvim-autopairs",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("user.plugins.settings.nvim-autopairs")
		end,
	}, -- auto close ({[

	{ "theRealCarneiro/hyprland-vim-syntax" }, -- Better syntax highlight in hyprland.conf
	{ "editorconfig/editorconfig-vim" }, -- Editorconfig
	{ "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeFocus" } }, -- undo tree
	{ "ThePrimeagen/harpoon" }, -- harpoon
}
