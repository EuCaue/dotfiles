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

-- better commments format and make CursorLine bold
autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
    vim.cmd("hi CursorLine gui=bold cterm=bold")
  end,
})

vim.cmd([[
autocmd BufEnter * silent! :lcd %:p:r
]]) -- for netrw
