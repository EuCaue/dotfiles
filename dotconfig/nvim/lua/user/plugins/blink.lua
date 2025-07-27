return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "bydlw98/blink-cmp-env" },
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default",
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        sh = { inherit_defaults = true, "env" },
        zsh = { inherit_defaults = true, "env" },
        bash = { inherit_defaults = true, "env" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        buffer = {
          score_offset = -15,
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
        env = {
          score_offset = -2,
          name = "Env",
          module = "blink-cmp-env",
          opts = {
            show_braces = true,
            show_documentation_window = true,
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
        -- border = vim.g.border_type,
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
          -- border = vim.g.border_type,
        },
      },
    },
  },
}
