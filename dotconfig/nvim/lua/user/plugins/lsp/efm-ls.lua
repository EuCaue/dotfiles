local prettier = {
	formatCommand = "prettier --single-attribute-per-line ${INPUT}",
	formatStdin = true,
	env = {
		"PRETTIERD_LOCAL_PRETTIER_ONLY=1",
	},
}

local sh_lint = {
	formatCommand = "shfmt ${INPUT}",
	formatStdin = true,
}

local json_lint = {
	lintCommand = "jsonlint --compact",
	lintFormats = { "%f:%l %m" },
	lintStdin = true,
}

local markdown_lint = {
	lintCommand = "markdownlint --stdin",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l %m" },
	formatCommand = "prettier --parser markdown ${INPUT}",
	formatStdin = true,
}

local lua_lint = {
	lintCommand = "luacheck -g vim --formatter plain --codes --ranges --filename ${INPUT} -",
	lintFormats = { "%f:%l %m" },
	lintStderr = true,
	lintStdin = true,
	formatCommand = "stylua --search-parent-directories --stdin-filepath ${INPUT} -",
	formatStderr = false,
	formatStdin = true,
}

local fish_lint = {
	lintCommand = "fish --no-execute ${INPUT}",
	lintIgnoreExitCode = true,
	lintFormats = { "%.%#(line %l): %m" },
	formatCommand = "fish_indent",
	formatStdin = true,
}

local languages = {
	css = { prettier },
	fish = { fish_lint },
	sh = { sh_lint },
	bash = { sh_lint },
	html = { prettier },
	javascript = { prettier },
	javascriptreact = { prettier },
	json = { prettier, json_lint },
	jsonc = { prettier, json_lint },
	lua = { lua_lint },
	markdown = { markdown_lint },
	scss = { prettier },
	typescript = { prettier },
	svelte = { prettier },
	typescriptreact = { prettier },
	yaml = { prettier },
}

require("lspconfig").efm.setup({
	filetypes = vim.tbl_keys(languages),
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { vim.loop.cwd() },
		languages = languages,
	},
})
