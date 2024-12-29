return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  build = "cargo build --release",
  event = "InsertEnter",
  ---@module 'blink.cmp'
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
          fallbacks = { "lsp" },
        },
      },
    },
    completion = {
      list = { max_items = 100 },
      menu = {
        border = vim.g.border_type,
      },

      documentation = {
        auto_show = true,
        window = {
          border = vim.g.border_type,
        },
      },
    },
    appearance = {
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
  },
}
