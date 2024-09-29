local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- highlight yank
autocmd({ "TextYankPost" }, {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- Enable spell and markdown pasting link
autocmd("FileType", {
  group = augroup("markdown_pasting"),
  pattern = { "text", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    require("custom.markdown_pasting").setup()
  end,
})

-- better commments format and make CursorLine bold
autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.cmd([[
autocmd BufEnter * silent! :lcd %:p:r
]]) -- for netrw

vim.api.nvim_clear_autocmds({ group = "lazyvim_wrap_spell" })
