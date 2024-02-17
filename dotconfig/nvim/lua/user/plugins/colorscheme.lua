local me = {
  "ramojus/mellifluous.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("mellifluous").setup({
      dim_inactive = false,
      color_set = "tender", -- alduin, mountain, tender
      styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
        comments = { italic = true },
        conditionals = { bold = true },
        folds = { bold = true },
        loops = { bold = true },
        functions = { bold = true },
        keywords = { italic = true },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { italic = true },
        properties = {},
        types = { italic = true },
        operators = { italic = true },
      },
      transparent_background = {
        enabled = false,
        floating_windows = false,
        telescope = false,
        file_tree = false,
        cursor_line = false,
        status_line = false,
      },
      flat_background = {
        line_numbers = false,
        floating_windows = true,
        file_tree = false,
        cursor_line_number = false,
      },
      plugins = {
        cmp = true,
        gitsigns = true,
        indent_blankline = true,
        telescope = {
          enabled = true,
          nvchad_like = true,
        },
        startify = true,
      },
    })
    vim.cmd("colorscheme mellifluous")
    vim.cmd("hi CursorLine guibg=#101010")
  end,
}

local gh = {
  "projekt0n/github-nvim-theme",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("github-theme").setup({
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/github-theme",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
        hide_nc_statusline = true, -- Override the underline style for non-active statuslines
        transparent = true, -- Disable setting background
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        styles = { -- Style to be applied to different syntax groups
          comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          functions = "bold",
          keywords = "italic",
          variables = "NONE",
          conditionals = "bold",
          constants = "NONE",
          numbers = "NONE",
          operators = "bold",
          strings = "NONE",
          types = "bold",
        },
      },
    })
    vim.cmd("colorscheme github_dark_high_contrast")
  end,
}

local vesp = {
  "datsfilipe/vesper.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("vesper").setup({
      transparent = false, -- Boolean: Sets the background to transparent
      italics = {
        comments = true, -- Boolean: Italicizes comments
        keywords = false, -- Boolean: Italicizes keywords
        functions = true, -- Boolean: Italicizes functions
        strings = false, -- Boolean: Italicizes strings
        variables = false, -- Boolean: Italicizes variables
      },
      overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
    })
    vim.cmd.colorscheme("vesper")
  end,
}

local min = {
  "datsfilipe/min-theme.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("min-theme").setup({
      transparent = false, -- Boolean: Sets the background to transparent
      italics = {
        comments = true, -- Boolean: Italicizes comments
        keywords = false, -- Boolean: Italicizes keywords
        functions = true, -- Boolean: Italicizes functions
        strings = false, -- Boolean: Italicizes strings
        variables = false, -- Boolean: Italicizes variables
      },
      overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
    })
    vim.cmd.colorscheme("min-theme")
  end,
}

local adwaita = {
  "Mofiqul/adwaita.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme adwaita]])
  end,
}

return {
  adwaita,
}
