return {
  "zk-org/zk-nvim",
  ft = "markdown",
  name = "zk",
  cmd = {
    "ZkIndex",
    "ZkNew",
    "ZkNewFromTitleSelection",
    "ZkNewFromContentSelection",
    "ZkCd",
    "ZkNotes",
    "ZkBacklinks",
    "ZkLinks",
    "ZkInsertLink",
    "ZkMatch",
    "ZkTags",
    "ZkOrphans",
    "ZkN",
    "ZkNf",
    "ZkLf",
    "ZkYesterday",
    "ZkDaily",
    "ZkTomorrow",
  },
  opts = {
    picker = "telescope",
  },
  config = function(_, opts)
    local zk = require("zk")
    local commands = require("zk.commands")
    local function make_edit_fn(defaults, picker_options)
      return function(options)
        options = vim.tbl_extend("force", defaults, options or {})
        zk.edit(options, picker_options)
      end
    end

    commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
    commands.add("ZkLf", make_edit_fn({ tags = { "fleet" } }))
    commands.add("ZkYesterday", function(options)
      options = vim.tbl_extend("force", { dir = "journal", date = "yesterday" }, options or {})
      zk.new(options)
    end)

    commands.add("ZkNf", function(options)
      local title = options and options.title or ""
      local cmd = "zk nff"
      if #title > 0 then
        cmd = cmd .. " " .. title
      end
      local output = vim.fn.system(cmd)
      local filepath, content = output:match("^(.-)\n---\n(.*)$")
      if not filepath or filepath == "" then
        return
      end
      local file = io.open(filepath, "w")
      if not file then
        return
      end
      file:write(content)
      file:close()
      vim.cmd("edit " .. filepath)
    end)

    commands.add("ZkN", function(options)
      local title = options and options.title or "no-title"
      local extraArgs = options.extra or ""
      local cmd = "zk n " .. title .. " " .. extraArgs .. " -n"
      local output = vim.fn.system(cmd)
      local filepath, content = output:match("^(.-)\n---\n(.*)$")
      if not filepath or filepath == "" then
        return
      end
      local file = io.open(filepath, "w")
      if not file then
        return
      end
      file:write(content)
      file:close()
      vim.cmd("edit " .. filepath)
    end)
    commands.add("ZkDaily", function(options)
      options = vim.tbl_extend("force", { dir = "journal" }, options or {})
      zk.new(options)
    end)
    commands.add("ZkTomorrow", function(options)
      options = vim.tbl_extend("force", { dir = "journal", date = "tomorrow" }, options or {})
      zk.new(options)
    end)

    zk.setup(opts)
  end,
}
