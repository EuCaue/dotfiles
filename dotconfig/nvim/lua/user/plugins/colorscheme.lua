local one_monokai = {
  "cpea2506/one_monokai.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("one_monokai").setup({
      transparent = true,
      colors = {
        bg = "#000000",
        black = "#000000",
        vulcan = "#101010",
      },
    })
    vim.cmd([[colorscheme one_monokai]])
  end,
}

local gruvbox = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      inverse = false, -- invert background for search, diffs, statuslines and errors
      palette_overrides = {
        dark0 = "#000000",
        dark1 = "#000000",
        dark2 = "#000000",
      },
      -- transparent_mode = true,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}

local gruvbox_baby = {
  "luisiacc/gruvbox-baby",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_baby_background_color = "dark"
    vim.g.gruvbox_baby_highlights = {
      Normal = { bg = "#000000" },
    }
    vim.g.gruvbox_baby_color_overrides = {
      background = "#000000",
      background_light = "#000000",
    }
    vim.cmd([[colorscheme gruvbox-baby]])
    vim.cmd([[hi LineNr guifg=#504945]])
    vim.cmd([[hi TelescopeMatching guifg=Gray]])
    -- vim.g.gruvbox_baby_transparent_mode = 1
  end,
}

local onedark = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      transparent = true,
      style = "warmer",                                                                                  -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      colors = { bg0 = "#000000", bg1 = "#000000", bg2 = "#101010", bg3 = "#101010", bg_d = "#000000" }, -- Override default colors
      diagnostics = {
        darker = false,                                                                                  -- darker colors for diagnostic
        undercurl = true,                                                                                -- use undercurl instead of underline for diagnostics
        background = true,                                                                               -- use background color for virtual text
      },
    })
    vim.cmd([[colorscheme onedark]])
  end,
}

local vscode = {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    require("vscode").setup({
      transparent = true,
      italic_comments = true,
      color_overrides = {
        vscBack = "#000000",
        vscTabOutside = "#000000",
        vscPopupBack = "#000000",
        vscTabOther = "#000000",
        vscTabCurrent = "#000000",
      },
    })
    require("vscode").load()
  end,
}

local sonokai = {
  "sainnhe/sonokai",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.sonokai_diagnostic_virtual_text = "colored"
    vim.g.sonokai_transparent_background = true
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_colors_override = {
      bg0 = { "#000000", "235" },
      bg2 = { "#000000", "236" },
      bg1 = { "#000000", "237" },
      bg_dim = { "#000000", "237" },
    }
    vim.cmd([[colorscheme sonokai]])
  end,
}

local gruv = {
  "bartekprtc/gruv-vsassist.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    require("gruv-vsassist").setup({
      transparent = true,
      italic_comments = true,
      color_overrides = {
        vscBack = "#000000",
        vscTabOutside = "#000000",
        vscPopupBack = "#000000",
        vscTabOther = "#000000",
        vscTabCurrent = "#000000",
      },
    })
  end,
}

local material = {
  "marko-cerovac/material.nvim",
  lazy = false,
  priorit = 1000,
  config = function()
    local colors = require("material.colors")
    require("material").setup({
      contrast = {
        terminal = true,            -- Enable contrast for the built-in terminal
        sidebars = true,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true,    -- Enable contrast for floating windows
        cursor_line = false,        -- Enable darker background for the cursor line
        non_current_windows = true, -- Enable darker background for non-current windows
        filetypes = {},             -- Specify which filetypes get the contrasted (darker) background
      },

      high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false,  -- Enable higher contrast text for darker style
      },

      lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

      async_loading = true,      -- Load parts of the theme asynchronously for faster startup (turned on by default)

      custom_colors = function(colors)
        colors.editor.bg_alt = "#000000"
        colors.editor.bg = "#000000"
        colors.editor.selection = "#101010"
        colors.editor.border = "#000000"
      end, -- If you want to everride the default colors, set this to a function

      disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false,        -- Disable borders between vertically split windows
        background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false,    -- Prevent the theme from setting terminal colors
        eob_lines = true,       -- Hide the end-of-buffer lines
      },
      custom_highlights = {
        NormalNC = { bg = "#000000" },
      },
    })
    vim.g.material_style = "deep ocean"
    vim.cmd([[colorscheme material]])
  end,
}


return {
  material,
}
