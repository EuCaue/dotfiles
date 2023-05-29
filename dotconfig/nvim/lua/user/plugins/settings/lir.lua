local status_ok, lir = pcall(require, "lir")
if not status_ok then
  vim.notify("Plugin lir not found", "error")
  return
end
local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

lir.setup({
  show_hidden_files = false,
  ignore = { "node_modules" }, -- { ".DS_Store" "node_modules" } etc.
  devicons = {
    enable = true,
    highlight_dirname = true,
  },
  mappings = {
    ["l"] = actions.edit,
    ["<CR>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["<C-v>"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,
    ["h"] = actions.up,
    ["<BACKSPACE>"] = actions.up,
    ["q"] = actions.quit,
    ["A"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["R"] = actions.rename,
    ["@"] = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["D"] = actions.delete,
    ["J"] = function()
      mark_actions.toggle_mark()
      vim.cmd("normal! j")
    end,
    ["C"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = false,
    },
  },
  hide_cursor = false,
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "lir" },
    callback = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )

      -- echo cwd
      vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
    end,
  }),
})
