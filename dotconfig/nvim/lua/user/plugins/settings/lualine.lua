local lualine = require("lualine")
local icons = require("user.utils").icons

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local lsp = {
  function(msg)
    local clients = 0
    msg = msg or "[LSP Inactive]"
    local buf_clients = vim.lsp.get_clients()
    if next(buf_clients) == nil then
      if type(msg) == "boolean" or #msg == 0 then
        return "[LSP Inactive]"
      end
      return msg
    end
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
      clients = clients + 1

      if client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end
    end

    local unique_client_names = vim.fn.uniq(buf_client_names)
    local language_servers = "["
      .. table.concat(unique_client_names, " ")
      .. "]"
    return language_servers
  end,
  cond = hide_in_width,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = {
    error = icons.ui.lsp_error,
    warn = icons.ui.lsp_warn,
    info = icons.ui.lsp_info,
    hint = icons.ui.lsp_hint,
  },
  colored = true,
  update_in_insert = true,
  always_visible = false,
}

local diff = {
  "diff",
  colored = true,
  symbols = {
    added = icons.git.add,
    modified = icons.git.modified,
    removed = icons.git.delete,
  }, -- changes diff symbols
  cond = hide_in_width,
}

local branch = {
  "b:gitsigns_head",
  padding = 1,
  icon = icons.git.git,
  color = { bg = "#141b24" },
  cond = hide_in_width,
}

local filename = {
  "filename",
  path = 4,
  symbols = {
    modified = icons.ui.plus_square, -- Text to show when the file is modified.
    readonly = icons.ui.minus_square, -- Text to show when the file is non-modifiable or readonly.
    unnamed = icons.ui.empty, -- Text to show for unnamed buffers.
    newfile = icons.ui.new, -- Text to show for newly created file before first write
  },
}

lualine.setup({
  options = {
    icons_enabled = true,
    component_separators = "|",
    section_separators = "",
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = false,
    globalstatus = false,
  },
  sections = {
    lualine_a = { { "mode", icons_enabled = true, icon = "", padding = 1 } },
    lualine_b = { filename },
    lualine_c = { lsp, diagnostics },
    lualine_x = {},
    lualine_y = { diff, branch },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  tabline = {},
  extensions = {},
})
