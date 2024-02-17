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
-- turn off paste mode when leaving insert
autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "vim",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
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

vim.cmd([[
autocmd BufEnter * silent! :lcd %:p:r
]]) -- for netrw
