local M = {}

M.cycle_checkbox = function(checkboxes, line_num)
  line_num = line_num or vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  if not line:match("^%s*- %[.") then
    line = line:gsub("^(%s*)[-*+] ", "%1- [ ] ")
  else
    for i, check_char in ipairs(checkboxes or { " ", "x" }) do
      if line:match("^%s*- %[" .. check_char .. "%]") then
        local next_char = checkboxes[i + 1] or checkboxes[1]
        line = line:gsub("%[" .. check_char .. "%]", "[" .. next_char .. "]")
        break
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { line })
end

M.setup = function()
  local checkboxes = { ">", "~", "x", " " } -- checkbox order
  M.cycle_checkbox(checkboxes)
end

return M
