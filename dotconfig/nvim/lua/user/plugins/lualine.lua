local icons = require("user.core.icons")
local hide_lualine = true
local mode_map = {
  n = "(ᴗ_ ᴗ。)",
  nt = "(ᴗ_ ᴗ。)",
  i = "(•̀ - •́ )",
  R = "( •̯́ ₃ •̯̀)",
  v = "(⊙ _ ⊙ )",
  V = "(⊙ _ ⊙ )",
  no = "Σ(°△°ꪱꪱꪱ)",
  ["\22"] = "(⊙ _ ⊙ )",
  t = "(⌐■_■)",
  ["!"] = "Σ(°△°ꪱꪱꪱ)",
  c = "Σ(°△°ꪱꪱꪱ)",
  s = "SUB",
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>tl",
      function()
        hide_lualine = not hide_lualine
        ---@diagnostic disable-next-line: missing-fields
        require("lualine").hide({ unhide = hide_lualine })
      end,
      desc = "toggle lualine",
    },
  },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ""
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = {
    options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
      icons_enabled = vim.g.have_nerd_font,
      disabled_filetypes = { "alpha" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          icons_enabled = true,
          separator = {
            left = "",
            right = "",
            -- right = ""
          },
          fmt = function()
            return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
          end,
        },
      },
      lualine_b = {
        {
          "filename",
          symbols = {
            modified = icons.ui.Pencil, -- Text to show when the file is modified.
            readonly = icons.ui.Lock, -- Text to show when the file is non-modifiable or readonly.
            unnamed = icons.ui.FileHidden, -- Text to show for unnamed buffers.
            newfile = icons.ui.NewFile, -- Text to show for newly created file before first write
          },
        },
      },
      lualine_c = {
        "filetype",
      },
      lualine_x = {},
      lualine_y = {
        { "location", padding = 1, separator = { left = "", right = "" } },
        { "diagnostics", separator = { left = "", right = "" } },
        {
          "diff",
          separator = { left = "", right = "" },
          symbols = {
            added = icons.git.LineAdded,
            modified = icons.git.LineModified,
            removed = icons.git.LineRemoved,
          },
        },
      },
      lualine_z = {
        {
          "branch",
          icon = icons.git.Branch,
          separator = {
            left = "",
            right = "",
          },
        },
      },
    },
    extensions = { "quickfix", "man", "lazy", "mason" },
  },
}
