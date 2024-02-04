return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "InsertEnter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", event = "InsertEnter" }, -- Better JSX + TSX comment
    },
    config = function()
      require("user.plugins.settings.treesitter")
    end,
  }, -- a better highlight for everything

  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    dependencies = {
      -- { "rafamadriz/friendly-snippets" }, -- a bunch of snippets
    },
    build = "make install_jsregexp",
    config = function()
      require("user.plugins.settings.luasnip")
    end,
  }, --  Snippet Engine

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    opts = {
      {
        ui = {
          border = "single",
        },
      },
    },
  }, -- flutter tools

  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    build = "yarn install --frozen-lockfile && yarn compile",
  }, -- JS/JSX snippets

  {
    "numToStr/Comment.nvim",
    keys = require("user.config.plugin_keymaps").comments,
    event = "BufReadPost",
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  }, -- Comment Plugin

  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("user.plugins.lsp.lsp")
      require("user.plugins.lsp.mason")
      require("user.plugins.lsp.efm-ls")
    end,
  }, -- LSP

  {
    "stevearc/conform.nvim",
    event = "LspAttach",
    config = function()
      require("user.plugins.settings.conform")
    end,
  }, -- Formatter

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          "zbirenbaum/copilot.lua",
          cmd = "Copilot",
          config = function()
            require("copilot").setup({
              suggestion = { enabled = false },
              panel = { enabled = false },
            })
          end,
        },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      "hrsh7th/cmp-nvim-lsp",
      "FelipeLema/cmp-async-path",
    },
    config = function()
      require("user.plugins.lsp.cmp")
    end,
  }, -- Auto complete

  { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },

  {
    "amarakon/nvim-cmp-fonts",
    keys = {
      {
        "<leader><leader>lf",
        "<cmd>: print('Font Source loaded')<cr>",
        mode = "n",
        desc = "Add Font source for nvim-cmp",
      },
    },
  },

  { "mtoohey31/cmp-fish", ft = "fish" },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonUpdate", "MasonInstall" },
  }, -- LSP Package Manager

  { "williamboman/mason-lspconfig.nvim", event = "LspAttach" },

  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
  }, -- Better rust tools

  {
    "Saecki/crates.nvim",
    version = "v0.3.*",
    ft = "rust",
    config = function()
      require("crates").setup({})
      require("crates").show()
    end,
  }, -- Better Rust Management packages

  {
    "kevinhwang91/nvim-ufo",
    keys = require("user.config.plugin_keymaps").ufo,
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    opts = {},
  }, -- Magically Better folding

  {
    "jcdickinson/codeium.nvim",
    event = "InsertEnter",
    config = function()
      require("codeium").setup({})
    end,
  }, -- Auto Complete IA

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
  }, -- Debugging

  -- JAVA
  {
    "nvim-java/nvim-java",
    ft = "java",
    config = function()
      require("java").setup()
    end,
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
}
