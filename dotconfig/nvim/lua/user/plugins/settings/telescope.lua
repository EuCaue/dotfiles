local telescope = require("telescope")
local icons = require("user.utils").icons
local utils = require("user.utils")
local actions = require("telescope.actions")
local fb_actions = require("telescope._extensions.file_browser.actions")
local grep_args = { "--hidden", "--glob", "!**/.git/*" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})

local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

telescope.setup({
  defaults = require("telescope.themes").get_dropdown({
    initial_mode = "insert",
    border = utils.border_status ~= "none",
    results_title = false,
    borderchars = {
      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },

    width = 0.8,
    previewer = false,
    preview = false,
    prompt_title = false,

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
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
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
        -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
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
  }),
  pickers = {
    oldfiles = {},
    marks = {
      mark_type = "local",
    },
    colorscheme = {
      enable_preview = true,
    },

    find_files = {
      path_display = filenameFirst,
      find_command = {
        "fd",
        "--type",
        "f",
        "--hidden",
        "--follow",
        "--exclude",
        ".git",
      },
    },

    buffers = {
      sort_lastused = true,
      sort_mru = true,
      bufnr_width = 10,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
          ["dd"] = actions.delete_buffer,
        },
      },
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
  },
  extensions = {
    file_browser = {
      cwd_to_path = false,
      initial_mode = "normal",
      grouped = true,
      select_buffer = true,
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<bs>"] = false,
        },
        ["n"] = {
          ["h"] = fb_actions.backspace,
          ["-"] = fb_actions.backspace,
        },
      },
    },
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    -- telescope_code_actions = {},
    project = {
      base_dirs = {
        { "~/Dev/" },
      },
      hidden_files = true, -- default: false
      order_by = "asc",
    },
  },
})

require("telescope").load_extension("file_browser")

if vim.bo.filetype == "dart" then
  require("telescope").load_extension("flutter")
end
