local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.diagnostic.config({ virtual_text = false })
vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- VIM
	vim.cmd("colorscheme rose-pine") -- colorscheme
	vim.cmd('let g:netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"')
	vim.keymap.set("n", "<space>o", "<cmd>LSoutlineToggle<CR>", bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-l>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- local lsp_flags = {
-- 	debounce_text_changes = 150,
-- }
--
-- require("lspconfig").tsserver.setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
--
-- require("lspconfig").cssls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = {
-- 		"css",
-- 		"scss",
-- 		"less",
-- 		"typescript",
-- 		"ts",
-- 		"typescriptreact",
-- 		"javascript",
-- 		"javascirptreact",
-- 		"js",
-- 	},
-- 	settings = {
-- 		css = { validate = true },
-- 		scss = { validate = true },
-- 		less = { validate = true },
-- 	},
-- })
-- require("lspconfig").cssmodules_ls.setup({
-- 	on_attach = on_attach,
-- })
--
-- require("lspconfig").html.setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
-- require("lspconfig").quick_lint_js.setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
-- require("lspconfig").jsonls.setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
--
-- require("lspconfig").sumneko_lua.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			-- Do not send telemetry data containing a randomized but unique identifier
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
