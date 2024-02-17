local markdown_lint = {
  lintCommand = "markdownlint --stdin",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l %m" },
}

 lua_lint = {
  lintCommand = "luacheck -g vim --formatter plain --codes --ranges --filename ${INPUT} -",
  lintFormats = { "%f:%l %m" },
  lintStderr = true,
  lintStdin = true,
}

local fish_lint = {
  lintCommand = "fish --no-execute ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = { "%.%#(line %l): %m" },
}

local languages = {
  fish = { fish_lint },
  lua = { lua_lint },
  markdown = { markdown_lint },
}

require("lspconfig").efm.setup({
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { vim.loop.cwd() },
    languages = languages,
  },
})
