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

M.highlight_priority = function(configs)
  --  TODO: thinking in hoow to add support for passing just a group or complettly highlihgts
  --  TODO: optimize this code

  local patterns = {}
  for _, config in ipairs(configs) do
    local char = config.char
    local highlight_group = config.group
    local fg = config.fg
    local bg = config.bg
    local style = config.style

    -- Adiciona um padrão baseado no char
    table.insert(patterns, {
      pattern = "^%s*%- %[.?%] .-" .. char,
      group = highlight_group,
    })

    -- Verifica se o grupo de highlight já existe
    if highlight_group then
      -- Se o grupo já existe, apenas modifica
      local hl_exists = vim.fn.hlexists(highlight_group)
      if hl_exists == 0 then
        -- Se o grupo não existe, cria o grupo com as opções fornecidas
        vim.api.nvim_set_hl(0, highlight_group, {
          fg = fg or nil,
          bg = bg or nil,
          bold = style == "bold" and true or false,
          italic = style == "italic" and true or false,
          underline = style == "underline" and true or false,
        })
      else
        -- Caso o grupo exista, apenas atualiza
        vim.api.nvim_set_hl(0, highlight_group, {
          fg = fg,
          bg = bg,
          bold = style == "bold",
          italic = style == "italic",
          underline = style == "underline",
        })
      end
    end
  end
  for i = 0, vim.api.nvim_buf_line_count(0) - 1 do
    local line = vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
    for _, p in ipairs(patterns) do
      if line:match(p.pattern) then
        vim.api.nvim_buf_add_highlight(0, -1, p.group, i, 0, -1)
        break
      end
    end
  end
end

local function table_index_of(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end

M.toggle_priority = function()
  --  TODO: make this modular to support others prioritys systems?
  local line = vim.api.nvim_get_current_line()
  local priorities = { "@p1", "@p2", "@p3" }
  local current_priority = line:match("@p%d") -- make this use the pattern from priorities table

  if current_priority then
    local current_index = table_index_of(priorities, current_priority)
    if current_priority == "@p3" then -- use the last index of priorities
      -- removes @p3
      line = line:gsub("%s*@p3", "") -- use the last index of priorities
    else
      -- cycle to next value
      local next_index = (current_index % #priorities) + 1
      line = line:gsub(current_priority, priorities[next_index])
    end
  else
    -- adds @p1 if there's no priority.
    line = line .. " @p1" -- use first index of priorities table
  end

  vim.api.nvim_set_current_line(line)
end

M.setup = function()
  local checkboxes = { ">", "~", "x", " " } -- checkbox order
  M.cycle_checkbox(checkboxes)
end

return M
