return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>ch", "<cmd>ToggleInlayHints<cr>", desc = "Toggle Inlay Hints" }
    end,
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ["bashls"] = {
          filetypes = { "sh", "zsh", "bash" },
        },
        ["marksman"] = {
          enabled = false,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        zsh = { "shfmt" },
        bash = { "shfmt" },
      },
    },
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    config = true,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    opts = {
      document_color = {
        kind = "background",
      },
      conceal = {
        enabled = true,
      },
    },
    cond = function()
      return LazyVim.extras.wants({
        root = {
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
        },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      search_method = "cover_or_nearest",
    },
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    opts = {},
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install("curl")
    end,
    opts = {},
    keys = {
      {
        "<leader>uD",
        function()
          require("dbee").toggle()
        end,
        mode = "n",
        desc = "Toggle Dbee UI",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "FelipeLema/cmp-async-path" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local i = 1
      -- make sure nvim_lsp it's always the first suggestion
      while i <= #opts.sources do
        if opts.sources[i].name == "nvim_lsp" then
          table.remove(opts.sources, i)
        else
          i = i + 1
        end
      end

      table.insert(opts.sources, 1, { name = "nvim_lsp", priority = 150, group_index = 1 })
      table.insert(opts.sources, { name = "async_path", priority = 150, group_index = 1 })

      opts.window = {
        completion = { scrollbar = false },
      }
    end,
    keys = function()
      return {}
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "tailwindcss-language-server",
        "shellcheck",
        "shfmt",
        "markdownlint",
      },
    },
  },

  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    build = "yarn install --frozen-lockfile && yarn run compile",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  }, -- JS/JSX snippets

  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      local fmt = require("luasnip.extras.fmt").fmt
      local todo = s({ trig = "todo" }, { t("- [ ] "), i(1, "todo") })
      local code = s("code", {
        t("`"),
        i(1, ""),
        t("`"),
      })

      local bold = s("b", {
        t("**"),
        i(1, ""),
        t("** "),
      })

      local italic = s("i", {
        t("_"),
        i(1, ""),
        t("_ "),
      })

      local link = s(
        "link",
        fmt("[{}]({})", {
          i(1, "name"),
          i(2, "url"),
        })
      )

      local code_block = s(
        "codeblock",
        fmt(
          [[```{}
  {}
  ```
  ]],
          {
            i(1, "lang"),
            i(2, ""),
          }
        )
      )
      ls.add_snippets("markdown", {
        code,
        bold,
        italic,
        code_block,
        todo,
        link,
      })
    end,
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
    },
  },
}
