local title2
return {
  enabled = false,
  "epwalsh/obsidian.nvim",
  version = "*",
  cmd = { "ObsidianSearch", "ObsidianQuickSwitch", "ObsidianNewFromTemplate" },
  keys = {
    {
      mode = { "n", "v", "x" },
      "<leader>ms",
      "<cmd>ObsidianQuickSwitch<cr>",
      desc = "Search Notes",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mg",
      "<cmd>ObsidianSearch<cr>",
      desc = "Grep Notes",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>ml",
      "<cmd>ObsidianLink<cr>",
      desc = "Create Link with word under cursor",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mln",
      "<cmd>ObsidianLinkNew<cr>",
      desc = "Create new note and link it",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mal",
      "<cmd>ObsidianLinks<cr>",
      desc = "List all links in the current buffer",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>me",
      "<cmd>ObsidianExtractNote<cr>",
      desc = "Extract word under cursor into new note",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mp",
      "<cmd>ObsidianPasteImg<cr>",
      desc = "Paste image from clipboard",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mt",
      "<cmd>ObsidianTags<cr>",
      desc = "Search tags in notes",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mr",
      "<cmd>ObsidianRename<cr>",
      desc = "Rename the note of the current buffer or reference under the cursor,",
      ft = "markdown",
    },
    {
      mode = { "n", "v", "x" },
      "<leader>mn",
      "<cmd>ObsidianNew<cr>",
      desc = "Create new note",
    },
  },
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      external_link_icon = { icon = "" },
    },
    daily_notes = {
      folder = "zk/journal",
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      title2 = tostring(os.date("%Y%m%d%H%M%S")) .. "-" .. suffix:lower()
      return title2
    end,

    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url })
    end,

    attachments = {
      img_folder = "images/",
      img_text_func = function(client, path)
        local full_path = path
        path = client:vault_relative_path(path) or path
        local cmd = "sh -c "
          .. vim.fn.shellescape("convert " .. full_path.filename .. " -quality 70 " .. full_path.filename)
        vim.fn.system(cmd)
        return string.format("![%s](%s)", path.name, path)
      end,
    },
    templates = {
      subdir = ".zk/templates/",
      title = function()
        local texto = title2:match("-%s*(.+)$")
        -- Substitui caracteres não alfanuméricos por espaços e converte para minúsculas
        local slug = texto:gsub("%W+", "-"):lower()
        -- Remove hifens no início ou no fim da string
        slug = slug:gsub("^%-+", ""):gsub("%-+$", "")
        return slug
      end,
      substitutions = {
        ['format-date now "long"'] = function()
          return os.date("%B %d, %Y")
        end,
        content = function()
          return ""
        end,
        ["filename-stem"] = function()
          local file_name = vim.fn.expand("%:t:r")
          return file_name
        end,
      },
    },
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/vault/zk/",
      },
    },
  },
}
