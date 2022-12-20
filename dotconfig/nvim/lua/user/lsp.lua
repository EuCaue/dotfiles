-- Add additional capabilities supported by nvim-cmp
local navic = require("nvim-navic")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
	vim.keymap.set("n", "<space>F", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
	vim.keymap.set("n", "<space>o", "<cmd>Lspsaga outline<CR>", bufopts)
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
	vim.keymap.set("n", "<C-l>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "D", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
	vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", bufopts)
	vim.keymap.set("n", "<space>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
	"tsserver",
	"bashls",
	"sumneko_lua",
	"pyright",
	"emmet_ls",
	"eslint",
	"marksman",
	"html",
	"cssls",
	"cssmodules_ls",
	"clangd",
	"jsonls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = false,
}
