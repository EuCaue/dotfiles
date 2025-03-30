return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default",
    },
    signature = {
      enabled = true,
      window = { border = vim.g.border_type },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        path = {
          score_offset = 10,
        },
        snippets = {
          score_offset = -10,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {},
            ignored_filetypes = {},
          },
        },
      },
    },
    completion = {
      list = {
        max_items = 100,
        selection = {
          auto_insert = false,
        },
      },
      menu = {
        border = vim.g.border_type,
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                -- if vim.g.have_nerd_Font == false then
                --   return ""
                -- end
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                -- if vim.g.have_nerd_Font == false then
                --   return
                -- end
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
          treesitter = { "lsp" },
        },
      },

      documentation = {
        auto_show = true,
        window = {
          border = vim.g.border_type,
        },
      },
    },
  },
}
