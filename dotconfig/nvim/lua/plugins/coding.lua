return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cth", "<cmd>ToggleInlayHints<cr>", desc = "Toggle Inlay [H]ints" }
      keys[#keys + 1] = { "<leader>ctd", "<cmd>ToggleLspDiag<cr>", desc = "Toggle Lsp [D]iagnostics" }
    end,
    opts = {
      servers = {
        ["ltex"] = {
          settings = {
            ltex = {
              language = "en-US",
              enabled = true,
            },
          },
        },
      },
    },
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      {
        "gcmh",
        function()
          vim.cmd("norm gcO HACK:  ")
          vim.cmd("startinsert")
        end,
        mode = "n",
        desc = "Create a hack comment",
      },
      {
        "gcmn",
        function()
          vim.cmd("norm gcO NOTE:  ")
          vim.cmd("startinsert")
        end,
        mode = "n",
        desc = "Create a note comment",
      },
      {
        "gcmt",
        function()
          vim.cmd("norm gcO TODO:  ")
          vim.cmd("startinsert")
        end,
        mode = "n",
        desc = "Create a todo comment",
      },
      {
        "gcmf",
        function()
          vim.cmd("norm gcO FIX:  ")
          vim.cmd("startinsert")
        end,
        mode = "n",
        desc = "Create a fix comment",
      },
      {
        "gcmb",
        function()
          vim.cmd("norm gcO BUG:  ")
          vim.cmd("startinsert")
        end,
        mode = "n",
        desc = "Create a bug comment",
      },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        mode = "n",
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        mode = "n",
        desc = "Previous todo comment",
      },
    },
    opts = {
      pre_hook = function()
        return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "FelipeLema/cmp-async-path" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local i = 1
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
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "markdownlint",
      },
    },
  },

  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    build = "npm install --frozen-lockfile && npm run compile",
  }, -- JS/JSX snippets

  {
    "L3MON4D3/LuaSnip",
    dependencies = {},
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
        code_block,
        todo,
        link,
      }, { type = "snippets" })
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
