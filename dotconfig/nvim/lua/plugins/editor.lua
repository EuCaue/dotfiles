return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>r"] = { name = "+rename" }
      opts.defaults["<leader>m"] = { name = "+markdown" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
      },
    },
  },

  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccHighlighterToggle", "CccPick", "CccConvert" },
    keys = {
      {
        "<leader>uh",
        "<cmd>CccHighlighterToggle<cr>",
        desc = "Toggle Highlight Colors",
      },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "jvgrootveld/telescope-zoxide",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      {
        "<leader>fb",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local fb_actions = require("telescope._extensions.file_browser.actions")

      opts.defaults = vim.tbl_deep_extend(
        "force",
        opts.defaults,
        require("telescope.themes").get_dropdown({
          path_display = {
            "filename_first",
          },
          previewer = true,
          preview = true,
          borderchars = {
            { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
        })
      )
      opts.pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--follow",
            "--exclude",
            ".git",
            "--exclude",
            "node_modules",
            "--exclude",
            "dist",
          },
        },
      }
      opts.extensions = {
        file_browser = {
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
              ["-"] = fb_actions.backspace,
            },
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension("zoxide")
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "echasnovski/mini.starter",
    optional = true,
    opts = function(_, opts)
      local items = {
        {
          name = "Zoxide",
          action = "Telescope zoxide list",
          section = string.rep(" ", 22) .. "Telescope",
        },
        {
          name = "Vault",
          action = "cd $HOME/Documents/vault | ObsidianQuickSwitch",
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
      local cwd = vim.fn.getcwd()
      local start = string.find(cwd, "Personal")
      if start then
        vim.schedule(function()
          require("persistence").load()
        end)
      end
    end,
  },
  {
    "chrishrb/gx.nvim",
    keys = { { "<leader>gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      handler_options = {
        search_engine = "duckduckgo", -- or you can pass in a custom search engine
        select_for_search = true,
      },
    },
    submodules = false, -- not needed, submodules are required only for tests
  },
}
