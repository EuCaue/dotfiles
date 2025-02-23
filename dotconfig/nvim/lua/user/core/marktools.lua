--- @class CheckboxCycleConfig
--- @field order string[]
--- @field write_on_change boolean

--- @class PriorityConfig
--- @field priorities string[]

--- @class MarkToolsConfig
--- @field checkbox_cycle CheckboxCycleConfig
--- @field priorities PriorityConfig

--- @param tbl table: The table to search in
--- @param value any: The value to find
--- @return number|nil: The index of the value or nil if not found
local function table_index_of(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end

--- @param line string: The line to check
--- @param priorities PriorityConfig: The line to check
--- @return number: The priority index (lower is higher priority)
local function get_priority(line, priorities)
  for i, priority in ipairs(priorities) do
    if line:find(priority) then
      return i
    end
  end
  return #priorities + 1
end

local M = {}

M.config = {
  checkbox_cycle = {
    order = { ">", "x", "~", " " },
    write_on_change = true,
  },
  priorities = { "@p1", "@p2", "@p3" },
}
--- @param checkboxes? CheckboxCycleConfig: The order of checkboxes to cycle through (default: M.config.checkbox_cycle.order)
--- @param write? boolean: Whether to save the file after changing (default: M.config.checkbox_cycle.write_on_change)
--- @param line_num? number: The line number to operate on (default: current line)
M.cycle_checkbox = function(checkboxes, write, line_num)
  checkboxes = checkboxes or M.config.checkbox_cycle.order
  write = write or M.config.checkbox_cycle.write_on_change

  line_num = line_num or vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  -- If line doesn't have a checkbox, convert it into one
  if not line:match("^%s*- %[.") then
    line = line:gsub("^(%s*)[-*+] ", "%1- [ ] ")
  else
    -- Cycle through the checkboxes
    for i, check_char in ipairs(checkboxes) do
      if line:match("^%s*- %[" .. check_char .. "%]") then
        local next_char = checkboxes[i + 1] or checkboxes[1]
        line = line:gsub("%[" .. check_char .. "%]", "[" .. next_char .. "]")
        break
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { line })
  if write then
    vim.cmd("write")
  end
end

--- @param priorities? PriorityConfig: The list of priority tags to cycle through (default: M.config.priorities)
M.toggle_priority = function(priorities)
  priorities = priorities or M.config.priorities
  local line = vim.api.nvim_get_current_line()
  local current_priority = line:match("@p%d")

  if current_priority then
    local current_index = table_index_of(priorities, current_priority)
    if current_priority == priorities[#priorities] then
      line = line:gsub("%s*" .. priorities[#priorities], "")
    else
      local next_index = (current_index % #priorities) + 1
      line = line:gsub(current_priority, priorities[next_index])
    end
  else
    line = line .. " " .. priorities[1]
  end

  vim.api.nvim_set_current_line(line)
end

--  TODO: capture nested todos

--- @param priorities? PriorityConfig: The list of priority tags to order by (default: M.config.priorities)
M.order_by_priority = function(priorities)
  priorities = priorities or M.config.priorities
  local buffer = vim.api.nvim_get_current_buf()
  local start_line, end_line

  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local pos_start = vim.fn.getpos("'<")
    local pos_end = vim.fn.getpos("'>")
    start_line = math.min(pos_start[2], pos_end[2]) - 1
    end_line = math.max(pos_start[2], pos_end[2])
  else
    start_line = 0
    end_line = -1
  end

  if start_line < 0 or (end_line >= 0 and start_line > end_line) then
    vim.api.nvim_err_writeln("Invalid range: 'start' is higher than 'end'")
    return
  end

  local lines = vim.api.nvim_buf_get_lines(buffer, start_line, end_line, false)
  local priority_lines = {}
  local other_lines = {}

  for _, line in ipairs(lines) do
    if line:match("@p%d+") then
      table.insert(priority_lines, line)
    else
      table.insert(other_lines, line)
    end
  end

  table.sort(priority_lines, function(a, b)
    return get_priority(a, priorities) < get_priority(b, priorities)
  end)

  local sorted_lines = {}
  local priority_index = 1
  for _, line in ipairs(lines) do
    if line:match("@p%d+") then
      table.insert(sorted_lines, priority_lines[priority_index])
      priority_index = priority_index + 1
    else
      table.insert(sorted_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(buffer, start_line, end_line, false, sorted_lines)
end

--- @param config? MarkToolsConfig: The configuration to apply (default: M.config)
M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

return M
