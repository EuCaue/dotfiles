local opt = vim.opt
local g = vim.g

opt.backup = false -- disable backup
opt.writebackup = false -- disable backup
opt.swapfile = false -- disable swapfile
opt.clipboard = "" -- disable systemclip board
opt.mouse = "a" -- disable mouse support
opt.pumblend = 0 -- popup menu blend
opt.pumheight = 15 -- pop up menu height
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.relativenumber = false -- disable relative number
opt.colorcolumn = "80"

g.markdown_folding = 1 -- enable markdown folding
g.lazyvim_python_lsp = "basedpyright" -- basedpyright as python lsp
