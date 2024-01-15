return {
  { dir = "~/Dev/lua/markutils.nvim", opts = {}, ft = "markdown" }, -- yes.


  {
    "uga-rosa/ccc.nvim",
    keys = require("user.config.plugin_keymaps").ccc,
    cmd = {
      "CccHighlighterEnable",
      "CccHighlighterDisable",
      "CccHighlighterToggle",
      "CccConvert",
      "CccPick",
    },
    config = function()
      local ccc = require("ccc")

      ccc.setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        win_opts = {
          border = require("user.utils").border_status,
        },
      })
    end,
  },
  {

    "prichrd/netrw.nvim",
    event = "VeryLazy",
    opts = {
      {
        use_devicons = true,
        mappings = {},
      },
    },
  }, -- netrw++

  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  }, -- match parens++

  {
    "lewis6991/gitsigns.nvim",
    keys = require("user.config.plugin_keymaps").git_signs,
    event = { "BufReadPre" },
    config = function()
      require("user.plugins.settings.gitsigns")
    end,
    cmd = "Gitsigns",
  }, --  git status on file

  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  }, -- Surround things

  {
    "folke/todo-comments.nvim",
    keys = require("user.config.plugin_keymaps").todo_comments,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
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
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_markdown_css = "/home/caue/dotfiles/dotconfig/markdown.css"
      vim.g.mkdp_highlight_css = "/home/caue/dotfiles/dotconfig/highlight.css"
      vim.g.mkdp_port = 8080
    end,
    cmd = { "MarkdownPreview" },
  }, -- preview markdown files on browser

  {
    "echasnovski/mini.clue",
    event = "VimEnter",
    version = false,
    config = function()
      require("user.plugins.settings.miniclue")
    end,
  }, -- which key 2

  {
    "nvim-telescope/telescope.nvim",
    keys = require("user.config.plugin_keymaps").telescope,
    cmd = { "Telescope" },
    config = function()
      require("user.plugins.settings.telescope")
    end,
    dependencies = {
      {
        "FabianWirth/search.nvim",
        config = function()
          require("search").setup({
            append_tabs = {
              {
                name = "Lsp Symbols",
                tele_func = require("telescope.builtin").lsp_document_symbols,
                available = function()
                  return #vim.lsp.get_clients() > 0
                end,
              },
              {
                name = "Registers",
                tele_func = require("telescope.builtin").registers,
                available = function()
                  return true
                end,
              },
              {
                name = "Buffers",
                tele_func = require("telescope.builtin").buffers,
                available = function()
                  return true
                end,
              },
            },
          })
        end,
      },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
  }, -- Telescope - Fuzzy Finder

  {
    "asiryk/auto-hlsearch.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      {
        remap_keys = { "/", "?", "*", "#", "n", "N" },
        create_commands = true,
      },
    },
  }, -- remove search highlights

  {
    "tzachar/local-highlight.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      insert_mode = true,
    },
  }, -- highlight current word

  { "tzachar/highlight-undo.nvim", opts = {}, event = "BufReadPost" }, -- highlight undos.

  {
    "nguyenvukhang/nvim-toggler",
    opts = {
      {
        inverses = {
          ["vim"] = "emacs",
        },
        remove_default_keybinds = true,
      },
    },
    keys = require("user.config.plugin_keymaps").toggler,
  }, -- toggle states,

  { "theRealCarneiro/hyprland-vim-syntax", lazy = true }, -- Better syntax highlight in hyprland.conf
  {
    "mbbill/undotree",
    cmd = { "UndotreeShow", "UndotreeFocus", "UndotreeHide" },
  }, -- undo tree
  { "christoomey/vim-tmux-navigator", event = "VimEnter" }, -- navigate between vim and tmux pane
}
