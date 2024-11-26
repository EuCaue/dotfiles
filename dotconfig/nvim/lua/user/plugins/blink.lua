return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  build = "cargo build --release",
  event = "InsertEnter",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
    },
    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },
    fuzzy = {
      use_typo_resistance = true,
    },
    windows = {
      autocomplete = {
        border = vim.g.border_type,
      },
      documentation = {
        auto_show = true,
        border = vim.g.border_type,
      },
      signature_help = {
        border = vim.g.border_type,
      },
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets" },
      },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = -10,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {},
            ignored_filetypes = {},
          },
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          fallback_for = { "lsp" },
        },
      },
    },

    kind_icons = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",

      Field = "",
      Variable = "",
      Property = "",

      Class = "",
      Interface = "",
      Struct = "",
      Module = "",

      Unit = "",
      Value = "",
      Enum = "",
      EnumMember = "",

      Keyword = "",
      Constant = "",

      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  },
}
