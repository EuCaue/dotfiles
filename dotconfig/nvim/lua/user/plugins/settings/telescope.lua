local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Plugin telescope not found", "error")
  return
end

local icons = require("user.utils").icons
local utils = require("user.utils")
local actions = require("telescope.actions")
local fb_actions = require("telescope._extensions.file_browser.actions")
local grep_args = { "--hidden", "--glob", "!**/.git/*" }

telescope.setup({
  defaults = {
    initial_mode = "normal",
    border = utils.border_status ~= "none",
    results_title = false,
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 1, -- Preview should always show (unless previewer = false)
      width = function(_, max_columns, _)
        return math.min(max_columns, 145)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 30)
      end,
    },

    -- selection_strategy = "reset",
    -- sorting_strategy = "descending",
    -- layout_strategy = "horizontal",
    -- layout_config = {
    --   horizontal = {
    --     prompt_position = "bottom",
    --     preview_width = 0.55,
    --     results_width = 0.6,
    --   },
    --   vertical = { mirror = false },
    --   width = 0.8,
    --   height = 0.80,
    --   preview_cutoff = 120,
    -- },
    --

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
        ["l"] = actions.select_default,
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
    oldfiles = {},
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
    },
    live_grep = {
      only_sort_text = true,
      additional_args = function()
        return grep_args
      end,
    },
    grep_string = {
      additional_args = function()
        return grep_args
      end,
    },
    keymaps = {
      theme = "ivy",
    },
  },
  extensions = {
    file_browser = {
      cwd_to_path = false,
      select_buffer = true,
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<bs>"] = false,
        },
        ["n"] = {
          ["h"] = fb_actions.backspace,
        },
      },
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
    telescope_code_actions = {},
    project = {
      base_dirs = {
        { "~/Dev/" },
      },
      hidden_files = true, -- default: false
      order_by = "asc",
    },
  },
  ["ui-select"] = {
    require("telescope.themes").get_dropdown({
      -- even more opts
    }),
  },
})

require("telescope").load_extension("project")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("lazygit")
require("telescope").load_extension("undo")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
