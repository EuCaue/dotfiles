local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Plugin nvim-lspconfig not found", "error")
  return
end

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
    -- prefix = " ",
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

vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  get_opts("Line diagnostic")
)
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  get_opts("Jump to prev diagnostic")
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  get_opts("Jump to next diagnostic")
)
vim.keymap.set(
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
    local map = vim.keymap.set
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
        ["4. Log"] = "LspLog",
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
    map("n", "<leader>o", "<cmd>Navbuddy<CR>", get_bufopts("Outline Icons"))
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
      "<leader>ll",
      "<cmd>ToggleInlayHints<cr>",
      get_bufopts("Toggle LSP Inlay Hint")
    )
    map(
      "n",
      "<leader>ls",
      vim.lsp.buf.signature_help,
      get_bufopts("LSP Signature")
    )
    map(
      "n",
      "<leader>ltd",
      "<cmd>ToggleLspDiag<cr>",
      get_bufopts("Toggle LSP Diagnostics")
    )
    map("n", "<leader>lf", "<cmd>LspFormat<cr>", get_bufopts("LSP Format"))
    map(
      "n",
      "<leader>lo",
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

require("typescript-tools").setup({
  handlers = handlers,
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = "all",
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = false,
      quotePreference = "auto",
    },
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
  },
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
