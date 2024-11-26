return {
  "stevearc/conform.nvim",
  event = "LspAttach",
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
  opts = function(_, opts)
    local supported_prettier_ft = {
      "markdown.mdx",
      "javascript",
      "jsonc",
      "vue",
      "graphql",
      "handlebars",
      "less",
      "scss",
      "yaml",
      "typescript",
      "css",
      "json",
      "html",
      "javascriptreact",
      "markdown",
      "typescriptreact",
    }

    opts.default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    }
    opts.formatters_by_ft = {
      bash = { "shfmt" },
      dart = { "dart_format" },
      go = { "goimports", "gofumpt", "golines" },
      lua = { "stylua" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    }

    for _, ft in ipairs(supported_prettier_ft) do
      opts.formatters_by_ft[ft] = { "prettier" }
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        if vim.g.autoformat then
          require("conform").format({ bufnr = args.buf, async = vim.g.async_format })
        end
      end,
    })
  end,
}
