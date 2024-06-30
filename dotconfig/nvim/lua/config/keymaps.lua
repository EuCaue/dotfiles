local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

local del = vim.keymap.del

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
map("n", "<leader>q", "<cmd>bp | sp | bn | bd<cr>", get_opts("Close current buffer"))
map("n", "<leader>Q", "<cmd>qa!<cr>", get_opts("Quit all"))
map("n", "<leader>a", "gg<S-v>G", get_opts("Select all text in the buffer"))
map("n", "<BS>", "ciw", get_opts("Cut the inner word"))
map("n", "vv", "viw", get_opts("Select word under cursor"))
map("i", "<C-BS>", "<C-w>", get_opts("Delete a word backward"))
map("n", "dd", function()
  return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, get_opts("Smarter DD", true))
map({"n", "x"}, '<m-/>', "<esc>/\\%V", get_opts("Search within selection"))
map("n", "<C-S-l>", "<cmd>vertical resize -2<cr>", get_opts("Decrease Window Width"))
map("n", "<C-S-h>", "<cmd>vertical resize +2<cr>", get_opts("Increase Window Width"))
map("n", "<C-S-j>", "<cmd>resize -2<cr>", get_opts("Decrease Window Height"))
map("n", "<C-S-k>", "<cmd>resize +2<cr>", get_opts("Increase Window Height"))

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
del("n", "<leader>gg")
del("n", "<leader>gf")
del("n", "<leader>gl")
del("n", "<leader>gG")
