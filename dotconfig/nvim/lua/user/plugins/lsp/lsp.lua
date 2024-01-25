local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("user.utils")
local icons = utils.icons

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

vim.diagnostic.config({
  float = {
    border = "single",
    focusable = true,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "  ",
  },
  virtual_text = {
    prefix = "󱅶 ",
    suffix = icons.ui.arrow_left,
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.ui.lsp_error,
      [vim.diagnostic.severity.WARN] = icons.ui.lsp_warn,
      [vim.diagnostic.severity.INFO] = icons.ui.lsp_info,
      [vim.diagnostic.severity.HINT] = icons.ui.lsp_hint,
    },
    linehl = {
      -- [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      -- [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      -- [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      -- [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
})

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = utils.border_status }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = utils.border_status }
  ),
}

local function get_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end
local map = vim.keymap.set

map("n", "<leader>e", vim.diagnostic.open_float, get_opts("Line diagnostic"))
map("n", "[d", vim.diagnostic.goto_prev, get_opts("Jump to prev diagnostic"))
map("n", "]d", vim.diagnostic.goto_next, get_opts("Jump to next diagnostic"))
map(
  "n",
  "<leader>lc",
  vim.diagnostic.setloclist,
  get_opts("Set Diagnostics to loclist")
)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function get_bufopts(desc)
      return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    vim.keymap.set("n", "<space>lm", function()
      local options = {
        ["1. Start LSP"] = "LspStart",
        ["2. Stop LSP"] = "LspStop",
        ["3. Restart LSP"] = "LspRestart",
        ["4. Info"] = "LspInfo",
        ["5. Log"] = "LspLog",
      }
      utils.create_select_menu("Lsp Options", options)()
    end, get_bufopts("Lsp Menu Options"))

    map("n", "gD", vim.lsp.buf.declaration, get_bufopts("Go to declaration"))
    map(
      "n",
      "gd",
      "<cmd>Telescope lsp_definitions<CR>",
      get_bufopts("Go to definitions")
    )
    map("n", "K", vim.lsp.buf.hover, get_bufopts("Hover documentation"))
    map("n", "<leader>lr", "<cmd>LspRestart<cr>", get_bufopts("Restart LSP"))
    map(
      "n",
      "gi",
      "<cmd>Telescope lsp_implementations<CR>",
      get_bufopts("Go to implementations")
    )
    map(
      "n",
      "gt",
      "<cmd>Telescope lsp_type_definitions<CR>",
      get_bufopts("Go to type definition")
    )
    map("n", "<leader>rn", vim.lsp.buf.rename, get_bufopts("LSP Rename"))
    map(
      "n",
      "<leader>ca",
      vim.lsp.buf.code_action,
      get_bufopts("LSP Code action")
    )
    map(
      "n",
      "gr",
      "<cmd>Telescope lsp_references<cr>",
      get_bufopts("LSP References")
    )
    map(
      "n",
      "<leader>lh",
      "<cmd>ToggleInlayHints<cr>",
      get_bufopts("Toggle LSP Inlay Hint")
    )
    map(
      "n",
      "<leader>ls",
      vim.lsp.buf.signature_help,
      get_bufopts("LSP Signature")
    )
    map("i", "<C-h>", vim.lsp.buf.signature_help, get_bufopts("LSP Signature"))
    map(
      "n",
      "<leader>ltd",
      "<cmd>ToggleLspDiag<cr>",
      get_bufopts("Toggle LSP Diagnostics")
    )
    map("n", "<leader>lf", "<cmd>LspFormat<cr>", get_bufopts("LSP Format"))
    map(
      "n",
      "<leader>o",
      "<cmd>Telescope lsp_document_symbols<cr>",
      get_bufopts("Document Symbols")
    )

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
    --
    if client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    elseif client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    elseif client.name == "html" then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})

for _, lsp in ipairs(utils.servers) do
  lspconfig[lsp].setup({
    handlers = handlers,
    capabilities = capabilities,
    completions = {
      completeFunctionCalls = true,
    },
  })
end

lspconfig.bashls.setup({
  handlers = handlers,
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
  filetypes = { "sh", "zsh" },
})

require("lspconfig").lua_ls.setup({
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true,
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
local TSOrganizeImports = function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports.ts" },
      diagnostics = {},
    },
  })
end
local TSRemoveUnused = function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.removeUnused.ts" },
      diagnostics = {},
    },
  })
end

lspconfig.tsserver.setup({
  -- on_attach = on_attach,
  handlers = handlers,
  cmd = { "bunx", "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  single_file_support = true,
  commands = {
    TSOrganizeImports = {
      TSOrganizeImports,
      description = "Organize Imports",
    },
    TSRemoveUnused = {
      TSRemoveUnused,
      description = "Remove unused",
    },
  },

  completions = {
    completeFunctionCalls = true,
  },
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = false,
      },
    },

    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = false,
      },
    },
  },
})

lspconfig.tailwindcss.setup({
  handlers = handlers,
  cmd = { "bunx", "tailwindcss-language-server", "--stdio" },
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
  root_dir = lspconfig.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.ts"
  ),
})

lspconfig.eslint.setup({
  on_attach = function(bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = tonumber(bufnr),
      command = "EslintFixAll",
    })
  end,
  handlers = handlers,
  cmd = { "bunx", "vscode-eslint-language-server", "--stdio" },
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
})
