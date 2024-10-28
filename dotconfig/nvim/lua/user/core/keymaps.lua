local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

local commentsTags = {
  t = { "todo", "t" },
  h = { "hack", "h" },
  n = { "note", "n" },
  f = { "fix", "f" },
  b = { "bug", "b" },
}

for _, tag in pairs(commentsTags) do
  local tag_text = tag[1]
  local tag_key = tag[2]
  local key = "gcm" .. tag_key
  map("n", key, function()
    vim.cmd("norm gcO " .. string.upper(tag_text) .. ":  ")
    vim.cmd("startinsert")
  end, get_opts("Create a " .. tag_text .. " comment"))
end

map("n", "<space>R", "q", get_opts("R to q"))
map("", "q", "<Nop>", get_opts("remove default q keymap"))
map("n", "<leader>q", "<cmd>quitall!<cr>", get_opts("Quit all"))
map({ "n", "i" }, "<C-a>", "<cmd>norm ggVG<cr>", get_opts("Select all text in the buffer"))
map("n", "<leader>a", "<cmd>norm ggVG<cr>", get_opts("Select all text in the buffer"))
map("n", "<BS>", '"_ciw', get_opts("Cut the inner word"))
map("n", "vv", "viw", get_opts("Select word under cursor"))
map("i", "<C-BS>", "<C-w>", get_opts("Delete a word backward"))
map("n", "dd", function()
  return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, get_opts("Smarter DD", true))
map({ "n", "x" }, "<m-/>", "<esc>/\\%V", get_opts("Search within selection"))
map("n", "<A-C-l>", "<cmd>vertical resize -2<cr>", get_opts("Decrease Window Width"))
map("n", "<A-C-h>", "<cmd>vertical resize +2<cr>", get_opts("Increase Window Width"))
map("n", "<A-C-j>", "<cmd>resize -2<cr>", get_opts("Decrease Window Height"))
map("n", "<A-C-k>", "<cmd>resize +2<cr>", get_opts("Increase Window Height"))
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", get_opts("Add Comment Below"))
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", get_opts("Add Comment Above"))
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>write<cr><esc>", get_opts("Save File"))
map("n", "<leader>cd", vim.diagnostic.open_float, get_opts("Line diagnostic"))
map("n", "<leader>l", "<cmd>Lazy<cr>", get_opts("open lazy menu"))
map("n", "<CR>", "^", get_opts("Move to the first non-blank char"))
map("n", "<leader>M", "<cmd>messages<cr>", get_opts("see messages"))
map(
  "n",
  "<leader>;",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  get_opts("Redraw / Clear hlsearch / Diff Update")
)

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better system clipboard
map({ "n", "v" }, "<leader>y", '"+y', get_opts("Copy to system clipboard"))
map({ "n", "v" }, "<leader>c", '"+c', get_opts("Cut to system clipboard"))
map({ "n", "v" }, "<leader>p", '"+p', get_opts("Paste from system clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', get_opts("Delete for the void register"))
map({ "v", "x" }, "p", '"_dP', get_opts("greatest remap ever"))

-- Better up down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", get_opts("Down", true))
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", get_opts("Down", true))
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", get_opts("Up", true))
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", get_opts("Up", true))

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>bd", "<cmd>bp | sp | bn | bd<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", get_opts("Next Search Result", true))
map("x", "n", "'Nn'[v:searchforward]", get_opts("Next Search Result", true))
map("o", "n", "'Nn'[v:searchforward]", get_opts("Next Search Result", true))
map("n", "N", "'nN'[v:searchforward].'zv'", get_opts("Prev Search Result", true))
map("x", "N", "'nN'[v:searchforward]", get_opts("Prev Search Result", true))
map("o", "N", "'nN'[v:searchforward]", get_opts("Prev Search Result", true))

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- quick fix
map("n", "[q", vim.cmd.cprev, get_opts("Previous Quickfix"))
map("n", "]q", vim.cmd.cnext, get_opts("Next Quickfix"))

-- tabs
map("n", "<leader><tab>L", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- terminal
map("t", "<esc>", [[<C-\><C-n>]], get_opts("Esc in terminal"))

local function toggle_option(option)
  vim.o[option] = not vim.o[option]
end

-- toggles
map("n", "<leader>tw", function()
  toggle_option("wrap")
end, get_opts("toggle word wrap"))

map("n", "<leader>tn", function()
  toggle_option("number")
end, get_opts("toggle number"))

map("n", "<leader>tr", function()
  toggle_option("relativenumber")
end, get_opts("toggle relative number"))

map("n", "<leader>ts", function()
  toggle_option("spell")
end, get_opts("toggle spelling"))

map("n", "<leader>tS", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.signcolumn._value == "yes" then
    vim.opt.signcolumn = "no"
    return
  end
  vim.opt.signcolumn = "yes"
end, get_opts("toggle signcolumn"))

map("n", "<leader>tC", function()
  if vim.opt.cmdheight._value == 1 then
    vim.cmd("set cmdheight=0")
    return
  end
  vim.cmd("set cmdheight=1")
end, get_opts("toggle cmdheight"))

map("n", "<leader>tf", function()
  vim.g.autoformat = not vim.g.autoformat
end, get_opts("toggle auto format"))

map("n", "<leader>ta", function()
  vim.g.async_format = not vim.g.async_format
end, get_opts("toggle async format"))

map("n", "<leader>tt", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
    return
  end
  vim.treesitter.start()
end, get_opts("toggle treesitter"))

map("n", "<leader>td", function()
  if vim.diagnostic.is_enabled and vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    return
  end
  vim.diagnostic.enable(true)
end, get_opts("toggle diagnostics"))

map("n", "<leader>tc", function()
  if vim.wo.conceallevel == 0 then
    vim.wo.conceallevel = 2
    return
  end
  vim.wo.conceallevel = 0
end, get_opts("toggle conceallevel"))

-- Replace
map("n", "<leader>re", ":%s//<Left>", get_opts("Rename with substitute command"))

-- Check and uncheck todos
map(
  { "n", "v", "x" },
  "<leader>mc",
  [[:s/\v\[( |x)?\]/\=submatch(0) == '[ ]' ? '[x]' : '[ ]'<CR>:nohlsearch<CR>:nohl<CR>]],
  get_opts("Check/Uncheck todo")
)

map(
  { "n", "v" },
  "<leader>rr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  get_opts("Rename with substitute command based on current text")
)

map("n", "<C-t>", "<cmd>Ha<cr>", get_opts("Build and run"))

-- toggle executable
map("n", "<leader>x", function()
  local file = vim.fn.expand("%:p")
  if vim.fn.filereadable(file) == 1 then
    if vim.fn.executable(file) == 1 then
      vim.fn.system({ "chmod", "-x", file })
    else
      vim.fn.system({ "chmod", "+x", file })
    end
    print("Exec permission toggled for: " .. file)
  else
    print("File not found: " .. file)
  end
end, get_opts("toggle the current file executable"))

-- Center moviment on screen
map("n", "<C-d>", "<C-d>zz", get_opts("Scroll down half a page"))
map("n", "<C-u>", "<C-u>zz", get_opts("Scroll up half a page"))

vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
