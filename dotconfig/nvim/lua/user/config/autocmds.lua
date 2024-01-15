local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- better commments format
autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- resize windows
autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "spectre_panel",
    "lspinfo",
    "oil",
    "vim",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
    "",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

autocmd("FileType", {
  group = augroup("MyQuickFixGroup"),
  pattern = { "qf" },
  callback = function()
    vim.opt_local.wrap = true
    vim.keymap.set(
      "n",
      "<Leader>sr",
      [[:cdo s/<C-r><C-w>//gc | update <C-Left><C-Left><Left><Left><Left><Left>]],
      { buffer = true, desc = "qf search and replace cword" }
    )
    vim.keymap.set(
      "v",
      "<Leader>sr",
      'y:cdo s/<C-R>"//gc | update <C-Left><C-Left><Left><Left><Left><Left>',
      { buffer = true, desc = "qf search and replace selection" }
    )
  end,
  once = false,
})

autocmd("FileType", {
  group = augroup("quickfix"),
  pattern = {
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = event.buf, silent = true })
  end,
})

-- highlight yank
autocmd({ "TextYankPost" }, {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- Autoformat
autocmd("BufWritePost", {
  group = augroup("format_on_save"),
  callback = function(args)
    require("conform").format({
      async = true,
      bufnr = args.buf,
      lsp_fallback = true,
    })
  end,
})

-- Applying transparency
autocmd("VimEnter", {
  group = augroup("ColorSchemeVimEnter"),
  callback = function()
    vim.cmd("Transparent")
  end,
})

autocmd("ColorScheme", {
  group = augroup("ColorScheme"),
  callback = function()
    vim.cmd("Transparent")
  end,
})

-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
autocmd("ModeChanged", {
  group = augroup("LuaSniptHistory"),
  pattern = "*",
  callback = function()
    if
      (
        (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
        or vim.v.event.old_mode == "i"
      )
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

vim.cmd([[
autocmd BufEnter * silent! :lcd %:p:r
]]) -- for netrw
