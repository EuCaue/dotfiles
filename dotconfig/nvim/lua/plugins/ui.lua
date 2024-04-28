return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      routes = {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
  },

  {
    "dressing.nvim",
    opts = {
      input = {
        -- When true, <Esc> will close the modal - Defaults to true
        insert_only = false,
      },
    },
  },
}
