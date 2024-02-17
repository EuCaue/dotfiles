local map = vim.keymap.set
local cr = require("crates")
local bufnr = vim.api.nvim_get_current_buf()

local function get_opts(desc, bufnrnr)
  return { noremap = true, silent = true, desc = desc, buffer = bufnrnr }
end

map("n", "K", function()
  vim.cmd.RustLsp("codeAction")
end, get_opts("Rust LSP Hover", bufnr))

map("n", "<leader>ca", function()
  vim.cmd.RustLsp("{ 'hover', 'actions' }")
end, get_opts("Rust Tools Code Action", bufnr))

map("n", "<leader>rtr", function()
  vim.cmd.RustLsp("{'runnables'}")
end, get_opts("Rust Tools Runnables", bufnr))

map("n", "<leader>rtoc", function()
  vim.cmd.RustLsp("openCargo")
end, get_opts("Rust Tools Open Cargo Toml", bufnr))

map("n", "<leader>rtj", function()
  vim.cmd.RustLsp("joinLines")
end, get_opts("Rust Tools Join Lines", bufnr))

map("n", "<leader>rtcu", cr.update_crate, get_opts("Update Create"))

map("n", "<leader>rtcua", cr.update_all_crates, get_opts("Update All Create"))

map(
  "n",
  "<leader>rtcd",
  cr.open_documentation,
  get_opts("Open create documentation")
)

map("n", "<leader>rtcp", cr.show_popup, get_opts("Show Create Pop Up"))

map("n", "<leader>rtcup", cr.update, get_opts("Update Data"))
