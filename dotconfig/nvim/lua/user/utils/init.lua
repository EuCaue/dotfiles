local M = {}

--[[ create_select_menu()
-- Create a menu to execute a Vim command or Lua function using vim.ui.select()
-- Example usage:
-- local options = {
--   [1. Onedark ] = "colo onedark"
--   [2. Tokyonight ] = function() vim.cmd("colo tokyonight") end
-- }
-- create_select_menu("Choose a colorscheme", options)
--
-- @arg prompt: the prompt to display
-- @arg options_table: Table of the form { [n. Display name] = lua-function/vim-cmd, ... }
--                    The number is used for the sorting purpose and will be replaced by vim.ui.select() numbering
--]]
M.create_select_menu = function(prompt, options_table) -- Or M.create_select_menu = function(prompt, options_table)
  -- Given the table of options, populate a list with option display names
  local option_names = {}
  local n = 0
  for i, _ in pairs(options_table) do
    n = n + 1
    option_names[n] = i
  end
  table.sort(option_names)

  -- Return the prompt function. These global function var will be used when assigning keybindings
  local menu = function()
    vim.ui.select(
      option_names, --> the list we populated above

      {
        prompt = prompt, --> Prompt passed as the argument
        -- Remove this variable if you want to keep the numbering in front of option names
        format_item = function(item) return item:gsub("%d. ", "") end
      },

      function(choice)
        local action = options_table[choice]
        -- When user inputs ESC or q, don't take any actions
        if action ~= nil then
          if type(action) == "string" then
            vim.cmd(action)
          elseif type(action) == "function" then
            action()
          end
        end
      end)
  end

  return menu
end

M.get_user = function()
  local user = ""
  if os.getenv("OS") ~= nil and os.getenv("OS"):match("^Windows") then
    user = os.getenv("USERNAME")
  else
    user = os.getenv("USER")
  end
  local s = string.upper(string.sub(user, 1, 1)) .. string.lower(string.sub(user, 2))
  return s
end

M.toggle_transparency = function()
  local data_dir = vim.fn.stdpath("data")
  local colorscheme = vim.g.colors_name
  local file_path = data_dir .. "/toggle_transparency.txt"

  local file = io.open(file_path, "r")
  local current_value = file:read("*all")
  file:close()

  local new_value = "true"
  if current_value == "true" then
    new_value = "false"
  end

  file = io.open(file_path, "w")
  file:write(new_value)
  file:close()

  if colorscheme == "onedark" then
    require("onedark").setup({ transparent = (new_value == "true") })
    require("onedark").load()
  end
end

M.get_transparency_value = function()
  local data_dir = vim.fn.stdpath("data")
  local file_path = data_dir .. "/toggle_transparency.txt"
  local file = io.open(file_path, "r")
  local current_value = file:read("*all")
  file:close()

  return current_value
end

M.border_status = "rounded" -- "single" "double" "rounded" "none"

M.servers = {
  -- "tsserver",
  -- "vtsls",
  "prosemd_lsp",
  "bashls",
  "pkgbuild_language_server",
  "lua_ls",
  "tailwindcss",
  "emmet_ls",
  "eslint",
  "svelte",
  "marksman",
  "html",
  "rust_analyzer",
  "cssls",
  "cssmodules_ls",
  "clangd",
  "jsonls",
  "gopls",
}

M.icons = {
  kinds = {
    new = {
      Text = "󰉿 ",
      Method = "󰆧 ",
      Function = "󰊕 ",
      Constructor = " ",
      Field = "󰜢 ",
      Variable = " ",
      Class = "󰠱 ",
      Interface = " ",
      Module = " ",
      Property = "󰜢 ",
      Unit = "󰑭 ",
      Value = "󰎠 ",
      Enum = " ",
      Keyword = "󰌋 ",
      Snippet = " ",
      Color = "󰏘 ",
      File = "󰈙 ",
      Reference = "󰈇 ",
      Folder = "󰉋 ",
      EnumMember = " ",
      Constant = "󰏿 ",
      Struct = "󰙅 ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = " ",
    },

    kind_icons = {
      Array = " ",
      Boolean = " ",
      Text = " ",
      Method = "󰆧 ",
      Function = "󰊕 ",
      Constructor = " ",
      Field = "󰇽 ",
      Variable = "󰂡 ",
      Class = "󰠱 ",
      Interface = " ",
      Module = " ",
      Null = "󰟢 ",
      Property = "󰜢 ",
      Unit = " ",
      Value = "󰎠 ",
      Enum = " ",
      Key = " ",
      Keyword = "󰌋 ",
      Snippet = " ",
      Package = " ",
      Color = "󰏘 ",
      File = "󰈙 ",
      Reference = " ",
      Folder = "󰉋 ",
      EnumMember = " ",
      Constant = "󰏿 ",
      Struct = " ",
      Object = " ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰅲 ",
    },

    codicons = {
      Text = " ",
      Method = " ",
      Function = " ",
      Constructor = " ",
      Field = " ",
      Variable = " ",
      Class = " ",
      Interface = " ",
      Module = " ",
      Property = " ",
      Unit = " ",
      Value = " ",
      Enum = " ",
      Keyword = " ",
      Snippet = " ",
      Color = " ",
      File = " ",
      Reference = " ",
      Folder = " ",
      EnumMember = " ",
      Constant = " ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },

    icons_icons = {
      Text = "󰉿 ",
      Method = "m ",
      Function = "󰊕 ",
      Constructor = " ",
      Field = " ",
      Variable = "󰆧 ",
      Class = "󰌗 ",
      Interface = " ",
      Module = " ",
      Property = " ",
      Unit = " ",
      Value = "󰎠 ",
      Enum = " ",
      Keyword = "󰌋 ",
      Snippet = " ",
      Color = "󰏘 ",
      File = "󰈙 ",
      Reference = " ",
      Folder = "󰉋 ",
      EnumMember = " ",
      Constant = "󰇽 ",
      Struct = " ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
    custom_icons = {
      Text = " ",
      Method = " ",
      Function = "󰊕 ",
      Constructor = "⌘ ",
      Field = "󰜢 ",
      Variable = "󰈜 ",
      Class = "󰠱 ",
      Interface = " ",
      Module = "󰏓 ",
      Property = "󰜢 ",
      Unit = "󰑭 ",
      Value = "󰎠 ",
      Enum = " ",
      Keyword = "󰔌 ",
      Snippet = "󰅱 ",
      Color = "󰏘 ",
      File = "󰈙 ",
      Reference = "󰈇 ",
      Folder = " ",
      EnumMember = " ",
      Constant = "󰐀 ",
      Struct = "󰙅 ",
      Event = " ",
      treesitter = " ",
      Operator = "󰆕 ",
      TypeParameter = " ",
      fonts = " ",
    },
  },
  ui = {
    file = "󰈔",
    files = "󰈢",
    folder = "󰉖",
    folders = "󰉓",
    open_folder = "󰝰",
    empty_folder = "󰉖",
    project_folder = "󰀼",
    buffers = "󰈙",
    restore = "󰦛",
    config = "󰒓",
    close = "󰅚",
    buffer_close = "󰅖",
    modified_buffer = "●",
    arrow_right_out = "󰧂",
    arrow_right = "󰁔",
    arrow_left = "",
    arrow_left_out = "󰧀",
    double_chevron = "󰄾",
    chevron = "󰅂",
    lsp_error = "󰅙 ",
    lsp_warn = "󰀦 ",
    lsp_hint = "󰌵 ",
    lsp_info = "󰋼 ",
    powerline_round_right = "",
    powerline_round_left = "",
    powerline_square_right = " ",
    powerline_square_left = " ",
    mode_icon = "󰀘 ",
    modified = "󰜄 ",
    plus_square = "󰜄",
    minus_square = "󰛲",
    empty = "󱋭",
    new = "󰎔",
    prompt_prefix = " ",
    selection_caret = " ",
  },
  git = {
    git = "󰊢 ",
    add = "󰐙 ",
    change = "󰐙 ",
    delete = "󰍷 ",
    unstaged = "● ",
    modified = "  ",
    renamed = "󱦰 ",
    ignored = "◌",
    conflict = "",
    staged = "S",
    untracked = "U",
  },
}

M.icons_selected = M.icons.kinds.custom_icons

return M
