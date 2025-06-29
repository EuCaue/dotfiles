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
  local output = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
  local mode = output:match("'(.-)'") or output
  local is_dark = (mode == "prefer-dark")

  if is_dark and opts.dark then
    opts.dark()
  elseif not is_dark and opts.light then
    opts.light()
  end
  return is_dark
end

return M
