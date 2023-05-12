vim.g.barbar_auto_setup = false -- disable auto-setup
local icons = require("user.utils").icons
require("barbar").setup({
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = { "" },
  exclude_name = { "" },

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default) and 'right'
  focus_on_close = "left",

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = { extensions = false, inactive = false },

  -- Disable highlighting alternate buffers
  highlight_alternate = false,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = false,

  -- Enable highlighting visible buffers
  highlight_visible = false,

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = true,
    buffer_number = false,
    button = icons.ui.buffer_close,
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.ui.lsp_error },
      [vim.diagnostic.severity.WARN] = { enabled = false, icon = icons.ui.lsp_warn },
      [vim.diagnostic.severity.INFO] = { enabled = false, icons = icons.ui.lsp_info },
      [vim.diagnostic.severity.HINT] = { enabled = true, icons = icons.ui.lsp_hint },
    },
    gitsigns = {
      added = { enabled = false, icon = icons.git.add },
      changed = { enabled = false, icon = icons.git.modified },
      deleted = { enabled = false, icon = icons.git.delete },
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = { left = "▎", right = "" },

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = { button = icons.ui.modified_buffer },
    pinned = { button = "󰐃", filename = true, separator = { right = "" } },

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = { filetype = { enabled = false } },
    current = { buffer_index = true },
    inactive = { button = icons.ui.buffer_close },
    visible = { modified = { buffer_number = false } },
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = true,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 3,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 3,

  -- Sets the maximum buffer name length.
  maximum_length = 35,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = { text = "undotree" },
    -- Or, specify the event which the sidebar executes when leaving:
    -- ["neo-tree"] = { event = "BufWipeout" },
    -- Or, specify both
    Outline = { event = "BufWinLeave", text = "symbols-outline" },
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
})
