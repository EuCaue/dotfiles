return {
  "zk-org/zk-nvim",
  ft = "markdown",
  name = "zk",
  cmd = {
    "ZkNC",
    "ZkNT",
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
  keys = {
    { mode = { "v" }, "<leader>zc", ":<cmd>'<,'><cr>ZkNC<cr>", desc = "Create a new note with content selected" },
    { mode = { "v" }, "<leader>zT", ":<cmd>'<,'><cr>ZkNT<cr>", desc = "Create a new note with title selected" },
    { "<leader>zn", "<cmd>ZkNotes<cr>", desc = "Search ZK Notes" },
    { "<leader>zt", "<cmd>ZkTags<cr>", desc = "Search ZK Notes Tags" },
    { "<leader>zf", "<cmd>ZkLf<cr>", desc = "Search ZK Fleet notes" },
    { "<leader>zb", "<cmd>ZkBacklinks<cr>", desc = "Search ZK Backlinks in the current note", ft = "markdown" },
    { "<leader>zl", "<cmd>ZkLinks<cr>", desc = "Search Links in the current note", ft = "markdown" },
    { "<leader>zil", "<cmd>ZkInsertLink<cr>", desc = "Insert a link for a note", ft = "markdown" },
    {
      mode = { "v" },
      "<leader>zis",
      ":<cmd>'<,'><cr>ZkInsertLinkAtSelection<cr>",
      desc = "Insert a link for a note with selection",
      ft = "markdown",
    },
    { "<leader>zjy", "<cmd>ZkYesterday<cr>", desc = "Open Journal Entry Yesterday" },
    { "<leader>zjd", "<cmd>ZkDaily<cr>", desc = "Open Journal Entry Daily" },
    { "<leader>zjt", "<cmd>ZkTomorrow<cr>", desc = "Open Journal Entry Tomorrow" },
    { "<leader>zT", "<cmd>e $ZK_NOTEBOOK_DIR/temp.md<cr>", desc = "Open temp.md" },
  },
  opts = {
    picker = "fzf_lua",
  },
  config = function(_, opts)
    local zk = require("zk")
    local api = require("zk.api")
    local util = require("zk.util")
    local commands = require("zk.commands")

    local function link_note(path, location, title)
      api.link(path, location, nil, { title = title }, function(err, res)
        if not res then
          error(err)
        end
      end)
    end

    local function create_note(initial_cmd, options)
      options = options or {}
      local cmd = initial_cmd or "zk new"
      options.insertLinkAtLocation = nil
      options.dryRun = nil
      options.inline = nil
      options.link = nil

      if options.dir then
        cmd = cmd .. " $ZK_NOTEBOOK_DIR/" .. options.dir
        options.dir = nil
      end

      -- Add the --id option if a title exists
      if options.title then
        cmd = cmd .. ' --id="' .. options.title .. '"'
      end

      -- Loop through options and append the correct flags
      for key, value in pairs(options) do
        cmd = cmd .. " --" .. key .. '="' .. value .. '"'
      end

      -- Add --print-path at the end
      cmd = cmd .. " --print-path"

      -- Execute the command and get the last line of the output
      local output = vim.fn.system(cmd):match("^(.-)%s*$")
      local file_path = output:match("([^\r\n]*)$")
      return file_path
    end

    local function make_edit_fn(defaults, picker_options)
      return function(options)
        options = vim.tbl_extend("force", defaults, options or {})
        zk.edit(options, picker_options)
      end
    end

    commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
    commands.add("ZkLf", make_edit_fn({ tags = { "fleet" } }))
    commands.add("ZkNC", function(options)
      local location = util.get_lsp_location_from_selection()
      local selected_text = util.get_selected_text()
      assert(selected_text ~= nil, "No selected text")
      local title = vim.fn.input("Title: ")
      options = options or {}
      options.title = title
      options.insertLinkAtLocation = location
      local cmd = "echo " .. vim.fn.shellescape(selected_text) .. " | zk new -i"
      local file_path = create_note(cmd, options)
      vim.cmd("edit" .. file_path)
      if options.link then
        local trimmed_path = file_path:match("zk/(.*)")
        link_note(trimmed_path, location, title)
      end
    end, { needs_selection = true })
    commands.add("ZkNT", function(options)
      local location = util.get_lsp_location_from_selection()
      local selected_text = util.get_selected_text()
      assert(selected_text ~= nil, "No selected text")
      options = options or {}
      options.title = selected_text
      options.insertLinkAtLocation = location
      local cmd = "zk new"
      local file_path = create_note(cmd, options)
      local trimmed_path = file_path:match("zk/(.*)")
      link_note(trimmed_path, location, selected_text)
      vim.cmd("edit" .. file_path)
    end, { needs_selection = true })
    commands.add("ZkNf", function(options)
      local file_path = create_note('zk new "$ZK_NOTEBOOK_DIR/fleets/"', options)
      vim.cmd("edit " .. file_path)
    end)
    commands.add("ZkN", function(options)
      local file_path = create_note("zk new", options)
      vim.cmd("edit " .. file_path)
    end)
    commands.add("ZkYesterday", function(options)
      local cmd = 'zk new --no-input $ZK_NOTEBOOK_DIR/journal --date="yesterday"'
      local file_path = create_note(cmd, options)
      vim.cmd("edit" .. file_path)
    end)
    commands.add("ZkDaily", function(options)
      local cmd = "zk new --no-input $ZK_NOTEBOOK_DIR/journal"
      local file_path = create_note(cmd, options)
      vim.cmd("edit" .. file_path)
    end)
    commands.add("ZkTomorrow", function(options)
      local cmd = 'zk new --no-input $ZK_NOTEBOOK_DIR/journal --date="tomorrow"'
      local file_path = create_note(cmd, options)
      vim.cmd("edit" .. file_path)
    end)
    zk.setup(opts)
  end,
}
