local M = {}

--- Add padding into a string
---@param str string
---@param left number|nil
---@param right number|nil
function M.padding(str, left, right)
  left = left or 0
  right = right or 0
  return string.rep(" ", left) .. str .. string.rep(" ", right)
end

--- make the bg transparent
--- @return nil
function M.transparent()
  vim.cmd([[
   highlight Normal      guibg=NONE ctermbg=NONE
   highlight NormalNC    guibg=NONE ctermbg=NONE
   highlight SignColumn  guibg=NONE ctermbg=NONE
   highlight VertSplit   guibg=NONE ctermbg=NONE
   highlight StatusLine  guibg=NONE ctermbg=NONE
   highlight CursorLineNr  guibg=NONE ctermbg=NONE
   highlight CursorLineFold guibg=NONE ctermbg=NONE
   highlight LineNr      guibg=NONE ctermbg=NONE
   highlight Folded      guibg=NONE ctermbg=NONE
   highlight EndOfBuffer guibg=NONE ctermbg=NONE
 ]])
  vim.cmd("hi Normal ctermbg=NONE guibg=NONE")
  vim.cmd("hi NormalFloat ctermbg=NONE guibg=NONE")
  vim.cmd("hi NormalNC ctermbg=NONE guibg=NONE")
  vim.cmd("hi Pmenu ctermbg=NONE guibg=NONE")
  vim.cmd("hi WinBar ctermbg=NONE guibg=NONE")
  vim.cmd("hi SignColumn ctermbg=NONE guibg=NONE")
  vim.cmd("hi FloatBorder ctermbg=NONE guibg=NONE")
  vim.cmd("hi CursorLine gui=bold cterm=bold")
  vim.cmd("hi CmpItemAbbrMatch guibg=NONE ctermbg=NONE")
  vim.cmd("hi CmpItemAbbr guibg=NONE ctermbg=NONE")
  vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
end

--- Applies a theme based on the system's color scheme (dark or light).
--- @param opts table A table containing optional `dark` and/or `light` callbacks.
--- @param opts.dark? fun(): nil Function to run if the system is in dark mode.
--- @param opts.light? fun(): nil Function to run if the system is in light mode.
--- @return boolean
function M.apply_theme_by_system_mode(opts)
  --  TODO: check if gsettings exists.
  local output = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
  local mode = output:match("'(.-)'") or output
  local is_dark = (mode == "prefer-dark")

  if is_dark and opts.dark then
    vim.opt.background = "dark"
    opts.dark()
  elseif not is_dark and opts.light then
    vim.opt.background = "light"
    opts.light()
  end
  return is_dark
end

--  TODO: get current scope/indenxt with ts
--  TODO: adapt for others languages
function M.debug()
  if not vim.bo.modifiable or vim.bo.readonly then
    return
  end
  local indent = vim.o.tabstop or vim.o.shiftwidth
  vim.cmd("norm yiw")
  local var_name = vim.fn.getreg('"')
  vim.cmd("norm o")
  local line = 'console.log("' .. string.upper(var_name) .. '", ' .. var_name .. ");"
  vim.api.nvim_set_current_line(M.padding(line, indent))
end

function M.map(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

vim.api.nvim_create_user_command("DD", M.debug, {})
M.map("n", "<leader>cD", M.debug, get_opts("log current variable"))

return M
