local icons = require("user.core.icons")

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
  },
  {
    "jvgrootveld/telescope-zoxide",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fb",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
          })
        end,
        desc = "File Browser",
      },
      {
        "<leader>fB",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser",
      },
      { "<leader>fc", "<cmd>Telescope find_files cwd=$HOME/.config/nvim<cr>", desc = "Find Config File" },
      { "<leader>fd", "<cmd>Telescope zoxide list<cr>", desc = "Find Directories" },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Find Files (cwd)",
      },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Old Files" },
      { "<leader>fO", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Find Old Files (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
      -- search
      { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Grep (buffer dir)",
      },
      { "<leader>sG", "<cmd>Telescope live_grep<cr>", desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Word (buffer dir)",
      },
      { "<leader>sW", "<cmd>Telescope grep_string<cr>", desc = "Word (cwd)" },
      {
        "<leader>sw",
        "<cmd>Telescope grep_string<cr>",
        mode = "v",
        desc = "Selection",
      },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Goto Symbol" },
      { "<leader>sS", "<cmd>Telescope lsp_dynamic_document_symbols<cr>", desc = "Goto Symbol (Workspace)" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
    opts = function()
      local actions = require("telescope.actions")
      local function find_command()
        if 1 == vim.fn.executable("fd") then
          return {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--follow",
            "--color",
            "never",
            "-E",
            ".git",
            "--ignore-file",
            "$HOME/.config/fd/ignore",
          }
        elseif 1 == vim.fn.executable("fdfind") then
          return {
            "fdfind",
            "--type",
            "f",
            "--hidden",
            "--follow",
            "--color",
            "never",
            "-E",
            ".git",
            "--ignore-file",
            "$HOME/.config/fd/ignore",
          }
        elseif 1 == vim.fn.executable("rg") then
          return {
            "rg",
            "--files",
            "--ignore-file",
            "$HOME/.config/fd/ignore",
            "--follow",
            "--hidden",
            "--color",
            "never",
            "-g",
            "!.git",
          }
        end
      end

      return {
        defaults = require("telescope.themes").get_dropdown({
          path_display = {
            "filename_first",
          },
          previewer = true,
          preview = true,
          layout_config = {
            height = function(_, _, max_lines)
              return math.min(max_lines, 12)
            end,
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
            "--glob=!.git/",
          },
          prompt_prefix = icons.ui.Telescope,
          selection_caret = icons.ui.Plus,
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        }),
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          find_files = {
            find_command = find_command,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          file_browser = {
            dir_icon = icons.ui.Folder,
            initial_mode = "normal",
            cwd_to_path = true,
            hijack_netrw = true,
            grouped = true,
            select_buffer = true,
            mappings = {
              ["i"] = {
                ["<bs>"] = false,
              },
              ["n"] = {
                ["-"] = require("telescope._extensions.file_browser.actions").backspace,
              },
            },
          },
        },
      }
    end,
  },
}
