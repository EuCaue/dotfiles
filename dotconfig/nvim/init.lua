--  TODO: try vim-be-good
--  TODO: make some menu to set the filetype 
--  TODO: improve tabline 
--  TODO: show window names when split  
--  TODO: disable icons is broken 
_P = function(any)
  print(vim.inspect(any))
end
require("user.core.options")
require("user.core.keymaps")
require("user.core.autocmds")
require("user.core.lazy")
