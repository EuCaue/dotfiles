local prettier = {
  formatCommand = "prettier --single-attribute-per-line ${INPUT}",
  formatStdin = true,
  env = {
    "PRETTIERD_LOCAL_PRETTIER_ONLY=1",
  },
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

local languages = {
  css = { prettier },
  fish = {
    {
      -- TODO: Figure out why linting doesn't work
      --
      -- lintCommand = "fish --no-execute",
      -- lintStdin = false,
      -- lintStderr = true,
      -- lintFormats = { "%f (line %l): %m" },
      --
      formatCommand = "fish_indent",
      formatStdin = true,
    },
  },
  html = { prettier },
  javascript = { prettier },
  javascriptreact = { prettier },
  json = { prettier, json_lint },
  jsonc = { prettier, json_lint },
  lua = {
    {
      lintCommand = "luacheck -g vim --formatter plain --codes --ranges --filename ${INPUT}",
      lintFormats = { "%f:%l %m" },
      lintStdin = true,
    },
  },
  markdown = { markdown_lint },
  scss = { prettier },
  typescript = { prettier },
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
