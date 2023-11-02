local utils = require("user.utils")

return {
	-- { dir = "~/Dev/lua/markvim.nvim", config = true },

	{ "nacro90/numb.nvim", config = true, event = "BufReadPost" },
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				use_devicons = true,
				mappings = {},
			})
		end,
	},

	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "BufReadPost",
		config = true,
		init = function()
			vim.g.loaded_matchparen = 1
		end,
	},

	{
		"uga-rosa/ccc.nvim",
		keys = require("user.config.plugin_keymaps").ccc,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local ccc = require("ccc")

			ccc.setup({
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
				win_opts = {
					border = utils.border_status,
				},
			})
		end,
	},

	{
		"m4xshen/hardtime.nvim",
		event = { "BufReadPre" },
		config = function()
			require("hardtime").setup({
				restricted_keys = {
					["j"] = {},
					["k"] = {},
					["h"] = {},
					["l"] = {},
					["<Up>"] = {},
					["<Down>"] = {},
				},
				disabled_keys = {
					["<Up>"] = {},
					["<Down>"] = {},
				},
			})
		end,
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

	-- {
	-- 	"echasnovski/mini.files",
	-- 	lazy = false,
	-- 	keys = require("user.config.plugin_keymaps").minifiles,
	-- 	config = function()
	-- 		require("mini.files").setup({
	-- 			mappings = {
	-- 				go_in_plus = "<CR>",
	-- 				go_out_plus = "<BS>",
	-- 			},
	-- 			windows = {
	-- 				preview = true,
	-- 				width_focus = 30,
	-- 				width_preview = 90,
	-- 			},
	-- 		})
	-- 	end,
	-- 	version = false,
	-- },

	{
		"lewis6991/gitsigns.nvim",
		keys = require("user.config.plugin_keymaps").git_signs,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("user.plugins.settings.gitsigns")
		end,
		cmd = "Gitsigns",
	}, --  git status on file

	-- {
	-- 	"NeogitOrg/neogit",
	-- 	keys = require("user.config.plugin_keymaps").neogit,
	-- 	cmd = "Neogit",
	-- 	config = true,
	-- },

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},

	{
		"Shatur/neovim-session-manager",
		keys = require("user.config.plugin_keymaps").session_manager,
		cmd = "SessionManager",
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
		keys = require("user.config.plugin_keymaps").todo_comments,
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	}, -- TODO: plugin

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
    event = "BufReadPost", 
		version = false,
		config = function()
			require("user.plugins.settings.miniclue")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		keys = require("user.config.plugin_keymaps").telescope,
		cmd = { "Telescope" },
		config = function()
			require("user.plugins.settings.telescope")
		end,
		dependencies = {
			{ "debugloop/telescope-undo.nvim" }, -- telescope for undo tree
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- {
			-- 	"nvim-telescope/telescope-fzf-native.nvim",
			-- 	build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			-- },
			{ "nvim-telescope/telescope-project.nvim" }, -- find projects
		},
	}, -- Telescope

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

	-- {
	-- 	"yamatsum/nvim-cursorline",
	-- 	config = true,
	-- }, -- highlight cursor on things

	{
		"tzachar/local-highlight.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("local-highlight").setup({ insert_mode = true })
		end,
	},

{
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recomended as each new version will have breaking changes
    opts={
        --Config goes here
    },
},
	-- {
	-- 	"m4xshen/autoclose.nvim",
	-- 	event = { "BufRead", "BufNewFile" },
	-- 	opts = {
	-- 		keys = {
	-- 			["("] = { escape = false, close = true, pair = "()" },
	-- 			["["] = { escape = false, close = true, pair = "[]" },
	-- 			["{"] = { escape = false, close = true, pair = "{}" },
	--
	-- 			[">"] = { escape = true, close = false, pair = "<>" },
	-- 			[")"] = { escape = true, close = false, pair = "()" },
	-- 			["]"] = { escape = true, close = false, pair = "[]" },
	-- 			["}"] = { escape = true, close = false, pair = "{}" },
	--
	-- 			['"'] = { escape = true, close = true, pair = '""' },
	-- 			["'"] = { escape = true, close = true, pair = "''" },
	-- 			["`"] = { escape = true, close = true, pair = "``" },
	-- 		},
	-- 		options = {
	-- 			disabled_filetypes = { "text" },
	-- 			disable_when_touch = true,
	-- 			touch_regex = "[%w(%[{]",
	-- 			pair_spaces = false,
	-- 			auto_indent = true,
	-- 			disable_command_mode = false,
	-- 		},
	-- 	},
	-- },
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {},
	},

	{ "tzachar/highlight-undo.nvim", config = true, event = "BufReadPost" }, -- awesome plugin.
	{ "nguyenvukhang/nvim-toggler", config = true, event = { "BufReadPre" } }, -- toggle states,
	{ "theRealCarneiro/hyprland-vim-syntax", lazy = true }, -- Better syntax highlight in hyprland.conf
	{ "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeFocus" } }, -- undo tree
	{ "christoomey/vim-tmux-navigator", event = "VimEnter" },
	{
		"ThePrimeagen/harpoon",
		event = "BufReadPre",
		keys = require("user.config.plugin_keymaps").harpoon,
		config = function()
			require("harpoon").setup({
				global_settings = {
					-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
					save_on_toggle = false,

					-- saves the harpoon file upon every change. disabling is unrecommended.
					save_on_change = true,

					-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
					enter_on_sendcmd = true,

					-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
					tmux_autoclose_windows = false,

					-- filetypes that you want to prevent from adding to the harpoon list menu.
					excluded_filetypes = { "harpoon" },

					-- set marks specific to each git branch inside git repository
					mark_branch = false,

					-- enable tabline with harpoon marks
					tabline = false,
					tabline_prefix = "   ",
					tabline_suffix = "   ",
				},
			})
		end,
	}, -- harpoon
}
