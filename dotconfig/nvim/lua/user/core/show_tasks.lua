local M = {}

M.config = {
  do_pattern = "^%- %[%s%] ", -- '- [ ] ' with maybe spaces inside brackets
  doing_pattern = "^%- %[%>%] ", -- '- [>] ' exactly
  done_pattern = "^%- %[x%] ", -- '- [x] ' exactly (lowercase x)
}

local function parse_tasks(lines, config)
  local do_tasks, doing_tasks, done_tasks = {}, {}, {}

  for linenr, line in ipairs(lines) do
    if line and line:match(config.do_pattern) then
      table.insert(do_tasks, { line = linenr, text = line })
    elseif line and line:match(config.doing_pattern) then
      table.insert(doing_tasks, { line = linenr, text = line })
    elseif line and line:match(config.done_pattern) then
      table.insert(done_tasks, { line = linenr, text = line })
    end
  end

  return do_tasks, doing_tasks, done_tasks
end

function M.show_tasks()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local do_tasks, doing_tasks, done_tasks = parse_tasks(lines, M.config)
  local content = { "Do Tasks:" }
  for _, t in ipairs(do_tasks) do
    table.insert(content, string.format("%d: %s", t.line, t.text))
  end
  table.insert(content, "")
  table.insert(content, "Doing Tasks:")
  for _, t in ipairs(doing_tasks) do
    table.insert(content, string.format("%d: %s", t.line, t.text))
  end
  table.insert(content, "")
  table.insert(content, "Done Tasks:")
  for _, t in ipairs(done_tasks) do
    table.insert(content, string.format("%d: %s", t.line, t.text))
  end

  local win_width = 70
  local win_height = math.min(#content, 30)
  local ui = vim.api.nvim_list_uis()[1]
  local float_buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, content)

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = math.floor((ui.width - win_width) / 2),
    row = math.floor((ui.height - win_height) / 2),
    style = "minimal",
    border = "single",
  }

  local float_win = vim.api.nvim_open_win(float_buf, true, opts)

  vim.api.nvim_buf_set_keymap(float_buf, "n", "<CR>", "", {
    nowait = true,
    noremap = true,
    silent = true,
    callback = function()
      local cur_line = vim.api.nvim_win_get_cursor(float_win)[1]
      local line_entry = content[cur_line]
      local linenr = tonumber(line_entry:match("^(%d+):"))
      if linenr then
        vim.api.nvim_win_close(float_win, true)
        vim.api.nvim_set_current_win(vim.api.nvim_get_current_win())
        vim.api.nvim_win_set_cursor(0, { linenr, 0 })
      end
    end,
  })

  vim.api.nvim_set_option_value("number", false, {win = float_win})
  vim.api.nvim_set_option_value("relativenumber", false, {win = float_win})
  vim.api.nvim_set_option_value("filetype", "markdown", {buf = float_buf})
  vim.api.nvim_set_option_value("conceallevel", 0, {win = float_win})

  vim.api.nvim_buf_attach(float_buf, false, {
    on_lines = function(_, p_buf, changed_tick, firstline, lastline, new_lastline)
      vim.schedule(function()
        for i = firstline, new_lastline - 1 do
          local line_text = vim.api.nvim_buf_get_lines(p_buf, i, i + 1, false)[1]
          local linenr = tonumber(line_text:match("^(%d+):"))
          if linenr then
            local new_content = line_text:gsub("^%d+:%s*", "")
            vim.api.nvim_buf_set_lines(buf, linenr - 1, linenr, false, { new_content })
          end
        end
      end)
    end,
    on_detach = function() end,
  })
end

function M.setup(opts)
  opts = opts or {}
  for k, v in pairs(opts) do
    M.config[k] = v
  end
  vim.api.nvim_create_user_command("ShowTasks", M.show_tasks, {})
end

return M
