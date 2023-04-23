local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Plugin telescope not found", "error")
  return
end

local icons = require("user.utils").icons
local actions = require("telescope.actions")
local grep_args = { "--hidden", "--glob", "!**/.git/*" }

require("telescope").load_extension("project")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("lazygit")
require("telescope").load_extension("undo")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_strategy = "center",
		results_title = false,
		layout_config = {
			preview_cutoff = 1, -- Preview should always show (unless previewer = false)
			height = 0.30,
			width = 0.55,
		},
		border = true,
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
		prompt_prefix = icons.ui.prompt_prefix,
		selection_caret = icons.ui.selection_caret,
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		-- hidden_files = true,
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		oldfiles = {
			-- theme = "dropdown",
		},
		colorscheme = {
			-- theme = "dropdown",
			enable_preview = true,
		},
		find_files = {
			-- theme = "dropdown",
			find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
		},
		live_grep = {
			-- theme = "dropdown",
			only_sort_text = true,
			additional_args = function(opts)
				return grep_args
			end,
		},
		grep_string = {
			-- theme = "dropdown",
			additional_args = function(opts)
				return grep_args
			end,
		},
		keymaps = {
			theme = "ivy",
		},
	},
	extensions = {
		file_browser = {
			-- theme = "dropdown",
			cwd_to_path = true,
			select_buffer = true,
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
		fzf = {
			-- theme = "dropdown",
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		telescope_code_actions = {},
		project = {
			base_dirs = {
				{ "~/Dev/" },
			},
			hidden_files = true, -- default: false
			-- theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = false, -- default false
		},
	},
	["ui-select"] = {
		require("telescope.themes").get_dropdown({
			-- even more opts
		}),

		-- pseudo code / specification for writing custom displays, like the one
		-- for "codeactions"
		-- specific_opts = {
		--   [kind] = {
		--     make_indexed = function(items) -> indexed_items, width,
		--     make_displayer = function(widths) -> displayer
		--     make_display = function(displayer) -> function(e)
		--     make_ordinal = function(e) -> string
		--   },
		--   -- for example to disable the custom builtin "codeactions" display
		--      do the following
		--   codeactions = false,
		-- }
	},
})
