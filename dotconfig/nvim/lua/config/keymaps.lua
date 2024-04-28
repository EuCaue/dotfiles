local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

map("n", "<space>R", "q", get_opts("R to q"))
map("", "q", "<Nop>", get_opts("remove default q keymap"))
map("n", "<leader>q", "<cmd>bp | sp | bn | bd<cr>", get_opts("Close current buffer"))
map("n", "<leader>Q", "<cmd>qa!<cr>", get_opts("Quit all"))
map("n", "<leader>a", "gg<S-v>G", get_opts("Select all text in the buffer"))
map("n", "<BS>", "ciw", get_opts("Cut the inner word"))
map("n", "<TAB>", "<C-6>", get_opts("Cut the inner word"))
map("n", "vv", "viw", get_opts("Select word under cursor"))

-- Better system clipboard
map({ "n", "v" }, "<leader>y", '"+y', get_opts("Copy to system clipboard"))
map({ "n", "v" }, "<leader>c", '"+c', get_opts("Cut to system clipboard"))
map({ "n", "v" }, "<leader>p", '"+p', get_opts("Paste from system clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', get_opts("Delete for the void register"))
map({ "v", "x" }, "p", '"_dP', get_opts("greatest remap ever"))

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

-- Make executable
map("n", "<leader>x", "<cmd>!chmod +x %<cr>", get_opts("Make the current file executable"))
map("n", "<leader><leader>x", "<cmd>!chmod -x %<cr>", get_opts("Make the current file not executable"))

-- Center moviment on screen
map("n", "<C-d>", "<C-d>zz", get_opts("Scroll down half a page"))
map("n", "<C-u>", "<C-u>zz", get_opts("Scroll up half a page"))

-- disable lazygit mappings
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
