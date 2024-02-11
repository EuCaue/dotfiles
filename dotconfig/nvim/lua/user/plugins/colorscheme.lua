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
        enabled = true,
        floating_windows = true,
        telescope = true,
        file_tree = true,
        cursor_line = false,
        status_line = true,
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

local o = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Lua
    require("onedark").setup({
      -- Main options --
      style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = true, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = {
        "dark",
        "darker",
        "cool",
        "deep",
        "warm",
        "warmer",
        "light",
      }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    })
    vim.cmd("colorscheme onedark")
  end,
}

-- Lua with Lazy.nvim:
local ad = {
  "Mofiqul/adwaita.nvim",
  lazy = false,
  priority = 1000,

  -- configure and set on startup
  config = function()
    vim.g.adwaita_darker = true -- for darker version
    vim.g.adwaita_disable_cursorline = true -- to disable cursorline
    vim.g.adwaita_transparent = true -- makes the background transparent
    vim.cmd("colorscheme adwaita")
  end,
}

local base = {
  "echasnovski/mini.base16",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("mini.base16").setup({
      use_ctrm = true,
      palette = {

        base00 = "#000000", -- Background
        base01 = "#000000", -- cursor line
        base02 = "#000000", -- lua line
        base03 = "#c0bfbc", -- Cursor Text Color
        base04 = "#f9f06b", -- highlight current line
        base05 = "#f8f8f8", -- Foreground
        base06 = "#613583", -- idk debug coor for now
        base07 = "#e5a50a", -- Cursor
        base08 = "#73cef4", -- some keywords and dots
        base09 = "#ff7b63", -- var assignments value
        base0A = "#8ff0a4", -- Types
        base0B = "#cdab8f", -- string
        base0C = "#9a9996", -- comments andi imports
        base0D = "#a1d6ec", -- lsp error
        base0E = "#1161cb", -- declarations
        base0F = "#f8f8d7", -- special chars {}$ etc
        --
      },
    })
  end,
}

local r = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        -- Alternatively, set all headings at once.
        -- headings = "subtle",
      },

      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    })

    vim.cmd("colorscheme rose-pine-main")
  end,
}

local p = {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized-osaka").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = false },
        functions = { bold = true },
        variables = { bold = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors) end,
    })
    vim.cmd([[colorscheme solarized-osaka]])
  end,
}

local vesp = {
  "datsfilipe/vesper.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("vesper").setup({
      transparent = true, -- Boolean: Sets the background to transparent
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
      transparent = true, -- Boolean: Sets the background to transparent
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
local farout = {
  "thallada/farout.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("farout").setup({
      style = "night", -- The theme comes in two styles: `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        comments = { italic = true },
        keywords = { bold = false },
        functions = {},
        variables = {},
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      sidebars = { "qf", "help" },
    })
    vim.cmd([[colorscheme farout]])
  end,
}

return {
  min,
}
