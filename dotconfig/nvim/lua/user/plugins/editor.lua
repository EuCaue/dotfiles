return {
  { dir = "~/Dev/lua/markvim.nvim",       config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.plugins.settings.neotree")
    end,
    cmd = "Neotree",
  }, -- tree file manager

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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end,
        desc = "Flash",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      local Path = require("plenary.path")
      require("session_manager").setup({
        sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),             -- The directory where the session files will be saved.
        path_replacer = "__",                                                    -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++",                                                   -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,                                            -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true,                                       -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {},                                               -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                                            -- All buffers of these file types will be closed before the session is saved.
          "alpha",
          "gitcommit",
        },
        autosave_ignore_buftypes = {},    -- All buffers of these buffer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 130,            -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
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

  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
    cmd = "Glow",
  }, -- preview markdown

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
      vim.g.mkdp_browser = "min"
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = 8080
    end,
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  }, -- preview markdown files on browser

  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("user.plugins.settings.whichkey")
  --   end,
  -- }, -- which key
  {
    'echasnovski/mini.clue',
    version = false,
    config = function()
      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },

        window = {

          delay = 200,
          config = {
            width = 400,
            height = 10,
            anchor = "SW",
            row = "auto",
            col = "auto"

          }
        }
      })
    end
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
      { "nvim-telescope/telescope-fzf-native.nvim",  build = "make", lazy = false },
      { "nvim-telescope/telescope-project.nvim" }, -- find projects
    },
  },                                               -- Telescope

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
  },                                         -- auto close ({[

  { "theRealCarneiro/hyprland-vim-syntax" }, -- Better syntax highlight in hyprland.conf
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    commit = "ebf8c2ff6c27d110d3bb7e6e3b4813fb8fd5c7b2",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = function()
      local N = require("multicursors.normal_mode")
      local I = require("multicursors.insert_mode")
      return {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          ["b"] = {
            -- assigning nil to method exits from multi cursor mode
            method = N.clear_others,
            -- description to show in hint window
            desc = "Clear others",
          },
        },
        insert_keys = {
          -- to change default lhs of key mapping change the key
          ["<CR>"] = {
            -- assigning nil to method exits from multi cursor mode
            method = I.Cr_method,
            -- description to show in hint window
            desc = "new line",
          },
        },
      }
    end,
    keys = {
      {
        "<Leader><leader>c",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
  { "editorconfig/editorconfig-vim" },                                             -- Editorconfig
  { "mbbill/undotree",              cmd = { "UndotreeToggle", "UndotreeFocus" } }, -- undo tree
  { "ThePrimeagen/harpoon" },                                                      -- harpoon
}
