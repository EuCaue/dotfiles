-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end
-- NOTE: end of the keybind section for the LSP

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").rome.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = capabilities,
	filetypes = {
		"css",
		"scss",
		"less",
		"typescript",
		"ts",
		"typescriptreact",
		"javascript",
		"javascirptreact",
		"js",
	},
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
		-- typescript = { validate = true},
		-- typescriptreact = { validate = true},
		-- javascript = { validate = true},
		-- javascirptreact = { validate = true},
		-- js = { validate = true},
		-- ts = { validate = true},
		-- tsx = { validate = true},
		-- jsx = { validate = true},
	},
})
require("lspconfig").cssmodules_ls.setup({})

require("lspconfig").html.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").quick_lint_js.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
