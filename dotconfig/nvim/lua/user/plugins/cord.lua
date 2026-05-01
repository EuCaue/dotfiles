local blacklist = {
  vim.fn.expand("$HOME/Documents/zk"),
}

local is_blacklisted = function(opts)
  return vim.tbl_contains(blacklist, opts.workspace)
end

return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    hooks = {
      workspace_change = function(opts)
        if is_blacklisted(opts) then
          opts.manager:hide()
        else
          opts.manager:resume()
        end
      end,
    },
  },
}
