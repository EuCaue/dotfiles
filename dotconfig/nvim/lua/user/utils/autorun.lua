local M = {}

M.attach_buffer = function(pattern, command)
  vim.g.attach_buffnr = vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("AutoSLA", { clear = true }),
    pattern = pattern,
    callback = function()
      local buf = vim.fn.bufnr("auto")
      if buf ~= -1 then
        vim.api.nvim_win_set_buf(0, buf)
      else
        buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(buf, "auto")
        vim.api.nvim_command("vsplit")
        vim.api.nvim_win_set_buf(0, buf)
      end

      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(tonumber(buf), -1, -1, false, data)
        end
      end

      vim.api.nvim_buf_set_lines(tonumber(buf), 0, -1, false, { "Output: " })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

M.detach_buffer = function()
  if vim.g.attach_buffnr then
    vim.api.nvim_del_autocmd(vim.g.attach_buffnr)
  end
end

return M
