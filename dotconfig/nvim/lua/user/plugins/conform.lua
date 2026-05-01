return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = vim.g.async_format })
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, async = vim.g.async_format })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function()
    local prettier_only_ft = {
      "markdown",
      "markdown.mdx",
      "html",
      "css",
      "scss",
      "less",
      "yaml",
      "graphql",
      "handlebars",
    }

    local biome_and_prettier_ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
      "vue",
      "svelte",
      "astro",
      "css",
      "graphql",
    }

    local function has_biome_config(bufnr)
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      return vim.fs.find(
        { "biome.json", "biome.jsonc" },
        { path = filepath, upward = true }
      )[1] ~= nil
    end

    local function has_prettier_config(bufnr)
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      return vim.fs.find(
        {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.js",
          ".prettierrc.cjs",
          ".prettierrc.mjs",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          ".prettierrc.toml",
          "prettier.config.js",
          "prettier.config.cjs",
          "prettier.config.mjs",
        },
        { path = filepath, upward = true }
      )[1] ~= nil
    end

    local formatters_by_ft = {
      bash = { "shfmt" },
      sh   = { "shfmt" },
      zsh  = { "shfmt" },
      lua  = { "stylua" },
      dart = { "dart_format" },
      go   = { "goimports", "gofumpt", "golines" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    }

    for _, ft in ipairs(prettier_only_ft) do
      formatters_by_ft[ft] = { "prettier" }
    end

    for _, ft in ipairs(biome_and_prettier_ft) do
      formatters_by_ft[ft] = function(bufnr)
        if has_biome_config(bufnr) then
          return { "biome" }
        elseif has_prettier_config(bufnr) then
          return { "prettier" }
        else
          return { "prettier" }
        end
      end
    end

    return {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = formatters_by_ft,
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
      format_on_save = function(bufnr)
        if not vim.g.autoformat then
          return
        end
        return {
          timeout_ms = 3000,
          async = vim.g.async_format,
          lsp_format = "fallback",
        }
      end,
    }
  end,
}
