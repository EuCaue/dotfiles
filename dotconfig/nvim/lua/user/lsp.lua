local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
capabilities.textDocument.completion.completionItem.snippetSupport = true

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

-- vim.o.updatetime = 250
-- vim.cmd([[autocmd! CursorHold,CursorHoldI * :lua vim.lsp.buf.signature_help()]])

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
local function get_opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, get_opts("Line diagnostic"))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, get_opts("Jump to prev diagnostic"))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, get_opts("Jump to next diagnostic"))
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, get_opts("Diagnostics loclist"))

local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local function get_bufopts(desc)
		return { noremap = true, silent = true, buffer = bufnr, desc = desc }
	end

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, get_bufopts("Go to declaration"))
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", get_bufopts("Go to definitions"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, get_bufopts("Hover documentation"))
	vim.keymap.set("n", "<space>o", "<cmd>Navbuddy<CR>", get_bufopts("Outline Icons"))
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", get_bufopts("Go to implementations"))
	vim.keymap.set("n", "<space>l", vim.lsp.buf.signature_help, get_bufopts("Signature help"))
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, get_bufopts("Add workspace folder"))
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, get_bufopts("Remove workspace folder"))
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, get_bufopts("List workspace folders"))
	vim.keymap.set("n", "D", "<cmd>Telescope lsp_type_definitions<CR>", get_bufopts("Go to type definition"))
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, get_bufopts("LSP Rename"))
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, get_bufopts("Code action"))
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", get_bufopts("References"))
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, get_bufopts("LSP Format"))
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		navbuddy.attach(client, bufnr)
	end
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
	"tsserver",
	"bashls",
	"lua_ls",
	"pyright",
	"gopls",
	-- "tailwindcss",
	"eslint",
	"marksman",
	"html",
	"rust_analyzer",
	"cssls",
	"cssmodules_ls",
	"clangd",
	"jsonls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
		completions = {
			completeFunctionCalls = true,
		},
	})
end

require("lspconfig").bashls.setup({
	filetypes = { "sh", "zsh", "fish" },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	float = {
		border = "single",
		focusable = true,
		style = "minimal",
		source = "always",
		header = "",
		prefix = "",
	},
	virtual_text = true,
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = false,
})
