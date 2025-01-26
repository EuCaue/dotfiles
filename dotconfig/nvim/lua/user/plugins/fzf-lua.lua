local function buffer_dir()
  return vim.fn.expand("%:p:h")
end

return {
  enabled = true,
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function()
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
      { cmd = "tpix", args = { "{file}" } },
      { cmd = "ueberzug", args = {} },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["svg"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "cover",
        },
      },
      winopts = {
        width = 0.525,
        height = 0.725,
        row = 0.5,
        col = 0.5,
        -- split = "botright vnew", -- open in split right of current window
        preview = {
          scrollchars = { "┃", "" },
          layout = "vertical",
        },
      },
      files = {
        cwd_prompt = false,
        git_icons = true,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,
  keys = {
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>,", "<cmd>FzfLua buffers sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>FzfLua files cwd=$HOME/.config/nvim<cr>", desc = "Find Config File" },
    { "<leader>fd", "<cmd>FzfLua zoxide<cr>", desc = "Find Directories" },
    {
      "<leader>fF",
      function()
        require("fzf-lua").files({ cwd = buffer_dir() })
      end,
      desc = "Find Files (cwd)",
    },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Find Old Files" },
    { "<leader>fO", "<cmd>FzfLua oldfiles cwd=vim.uv.cwd()<cr>", desc = "Find Old Files (cwd)" },
    -- git
    { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
    -- search
    { "<leader>sr", "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },

    {
      "<leader>sg",
      function()
        require("fzf-lua").live_grep({ cwd = buffer_dir() })
      end,
      desc = "Grep (buffer dir)",
    },

    { "<leader>sG", "<cmd>FzfLua live_grep<cr>", desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    { "<leader>sM", "<cmd>FzfLua manpages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    -- { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    {
      "<leader>sw",
      function()
        require("fzf-lua").grep_cword({ cwd = buffer_dir() })
      end,
      desc = "Word (buffer dir)",
    },
    { "<leader>sW", "<cmd>FzfLua grep_cword<cr>", desc = "Word (cwd)" },
    {
      "<leader>sw",
      "<cmd>FzfLua grep_cWORD<cr>",
      mode = "v",
      desc = "Selection",
    },

    { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
    { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },
  },
}
