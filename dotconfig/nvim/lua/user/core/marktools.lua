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

--- @param conf table|string: The highlight configuration. It can be a table with custom options (e.g., fg, bg, bold) and optionally a 'from_group' field,
--- or a string indicating an existing highlight group name.
--- @return table|string|nil: The resolved highlight configuration. If a table is returned, it contains the complete set of highlight options.
local function resolve_highlight(conf)
  if type(conf) == "table" then
    if conf.from_group then
      local group_hl = vim.api.nvim_get_hl(0, { name = conf.from_group })
      local hl = vim.tbl_extend("force", {}, conf)
      hl.from_group = nil -- Remove o campo para não ser interpretado pelo set_hl
      if group_hl.fg and not hl.fg then
        hl.fg = string.format("#%06x", group_hl.fg)
      end
      if group_hl.bg and not hl.bg then
        hl.bg = string.format("#%06x", group_hl.bg)
      end
      return hl
    else
      return conf
    end
  elseif type(conf) == "string" then
    return conf
  end
end

M.config = {
  checkbox_cycle = {
    order = { ">", "x", "~", " " },
    write_on_change = true,
  },
  priorities = { "@p1", "@p2", "@p3" },
  highlight = {
    patterns = { "*.md" },
    -- events = { "BufWinEnter", "BufWrite", "BufNewFile", "BufRead", "InsertLeave" },
    events = { "BufWinEnter", "BufWrite", "BufNewFile", "BufRead", "InsertLeave", "TextChanged" },
    priority = {
      [1] = { from_group = "Error", bg = "None", bold = true },
      [2] = "WarningMsg",
      [3] = { bg = "None", from_group = "DiffAdded", bold = true },
      [4] = { from_group = "DiffChange", italic = true },
    },
  },
}
--- @param events? string[]: List of events to trigger the highlight update (default: M.config.highlight.events)
--- @param patterns? string[]: List of file patterns to which the highlight should be applied (default: M.config.highlight.patterns)
M.apply_priority_highlight = function(events, patterns)
  events = events or M.config.highlight.events
  patterns = patterns or M.config.highlight.patterns

  local ns = vim.api.nvim_create_namespace("marktools_priority")
  local augroup = vim.api.nvim_create_augroup("marktools-highlight", { clear = true })

  for index, _ in ipairs(M.config.priorities) do
    local hl_group = "PriorityP" .. index
    local conf = M.config.highlight.priority and M.config.highlight.priority[index]
    local resolved = resolve_highlight(conf)
    if type(resolved) == "table" then
      vim.api.nvim_set_hl(0, hl_group, resolved)
    elseif type(resolved) == "string" then
      vim.cmd(string.format("highlight! link %s %s", hl_group, resolved))
    else
      vim.cmd(string.format("highlight! link %s Normal", hl_group))
    end
  end

  local function create_highlight()
    local buffer = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(buffer, ns, 0, -1)
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for i, line in ipairs(lines) do
      for index, priority in ipairs(M.config.priorities) do
        local s, e = line:find(priority, 1, true)
        if s and e then
          local hl_group = "PriorityP" .. index
          vim.api.nvim_buf_add_highlight(buffer, ns, hl_group, i - 1, s - 1, e)
          break
        end
      end
    end
  end

  vim.api.nvim_create_autocmd(events, {
    group = augroup,
    pattern = patterns,
    callback = create_highlight,
  })
end

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

M.create_link = function()
  local mode = vim.fn.mode()
  if vim.tbl_contains({ "v", "V" }, mode) then
    local buf = vim.api.nvim_get_current_buf()
    local pos_start = vim.fn.getpos("'<")
    local pos_end = vim.fn.getpos("'>")
    local start_line = math.min(pos_start[2], pos_end[2]) - 1
    local end_line = math.max(pos_start[2], pos_end[2])

    if start_line < 0 or start_line > end_line then
      vim.api.nvim_echo({
        { "Invalid range: 'start' is higher than 'end'", "ErrorMsg" },
      }, true, {})
      return
    end

    local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, false)
    if #lines == 0 then
      return
    end

    lines[1] = "[" .. lines[1] .. "]()"
    vim.api.nvim_buf_set_lines(buf, start_line, end_line, false, lines)
    local new_col = #lines[1] - 1
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    vim.api.nvim_win_set_cursor(0, { start_line + 1, new_col })
    vim.cmd("startinsert")
  else
    local text = vim.fn.expand("<cword>")
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local col_start, col_end = line:find(text, 1, true)
    if col_start and col_end then
      vim.api.nvim_buf_set_text(0, row - 1, col_start - 1, row - 1, col_end, { "[" .. text .. "]()" })
      vim.api.nvim_win_set_cursor(0, { row, col_end + 3 })
      vim.cmd("startinsert")
    end
  end
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
    vim.api.nvim_echo("Invalid range: 'start' is higher than 'end'", true, { err = true })
    return
  end

  local lines = vim.api.nvim_buf_get_lines(buffer, start_line, end_line, false)
  local priority_lines = {}
  local other_lines = {}

  for _, line in ipairs(lines) do
    --  FIX: this it will not work if change @p<number> pattern
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
