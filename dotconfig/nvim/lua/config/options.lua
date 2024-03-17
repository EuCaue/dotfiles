local opt = vim.opt
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.clipboard = "" -- disable systemclip board
opt.mouse = "a" -- disable mouse support
opt.conceallevel = 0 -- disable conceallevel
opt.pumblend = 0 -- popup menu blend
opt.pumheight = 15 -- pop up menu height
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.relativenumber = false

if vim.g.neoray then
  opt.guifont = "NotoSansMono:h12, SymbolsNerdFont, Noto Color Emoji"
  vim.cmd([[
    NeoraySet ContextMenu true
    NeoraySet BoxDrawing true
    NeoraySet ImageViewer true
    NeoraySet WindowState maximized
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
  ]])
  return
end
opt.guifont = "Noto Sans Mono:h12"
