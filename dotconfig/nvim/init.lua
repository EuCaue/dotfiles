--  TODO: make some menu to set the filetype
--  TODO: improve tabline
--  TODO: show window names when split
--  TODO: disable icons is broken

---@param ... string
_P = function(...)
  ---@type string
  local result = "[LOG]:"
  for _, text in ipairs({ ... }) do
    result = result .. " " .. text
  end
  print(vim.inspect(result))
end
require("user.core.options")
require("user.core.keymaps")
require("user.core.autocmds")
require("user.core.lazy")
require("user.core.custom_commands")
