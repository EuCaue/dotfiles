return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "bydlw98/blink-cmp-env" },
  version = "*",
  event = "InsertEnter",
  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },
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
        max_height = 15,
        draw = {
          padding = { 0, 1 },
          gap = 1,
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return " " .. kind_icon .. " "
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return { { group = hl, priority = 20000 } }
              end,
            },
          },
          treesitter = { "lsp" },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
  },
}
