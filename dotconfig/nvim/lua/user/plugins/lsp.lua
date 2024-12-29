---@diagnostic disable: need-check-nil
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        -- util.set_qflist(util.locations_to_items(result))
        vim.fn.setqflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

---@class LspCommand: lsp.ExecuteCommandParams
---@field handler? lsp.Handler
local function lsp_execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
end

local function lsp_action(action)
  return function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { action },
        diagnostics = {},
      },
    })
  end
end

vim.lsp.handlers["textDocument/definition"] = goto_definition("split")
return {
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    lazy = true,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
      local icons = require("user.core.icons")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("custom-lsp-attach", {}),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          if client.supports_method("textDocument/completion") then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("K", vim.lsp.buf.hover, "hover")
          map("gd", vim.lsp.buf.definition, "goto definition")
          map("gD", vim.lsp.buf.declaration, "goto declaration")
          map("gr", vim.lsp.buf.references, "goto references")
          map("gI", vim.lsp.buf.implementation, "goto implementation")
          map("gy", vim.lsp.buf.type_definition, "goto type definition")
          map("<leader>cr", vim.lsp.buf.rename, "code rename")
          map("<leader>ca", vim.lsp.buf.code_action, "code action")
          map("<leader>cl", "<cmd>LspInfo<cr>", "show lsp info")

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
            end, "toggle inlay hints")
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
            map("<leader>tc", function()
              vim.lsp.codelens.refresh({ bufnr = bufnr })
            end, "toggle code lens")
          end

          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "html" then
            client.server_capabilities.documentFormattingProvider = false
          end

          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          if client.name == "tailwindcss" then
            client.server_capabilities.completionProvider.triggerCharacters =
              { '"', "'", "`", ".", "(", "[", "!", "/", ":" }
          end
        end,
      })

      vim.diagnostic.config({
        signs = {
          active = vim.g.have_nerd_font,
          values = {
            { name = "DiagnosticSignError", text = icons.diagnostics.Error },
            { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
            { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
            { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
          },
        },
        virtual_text = {
          spacing = 4,
          prefix = icons.misc.Point,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = vim.g.border_type,
          source = "always",
          header = "",
          prefix = "",
        },
      })

      if vim.g.have_nerd_font then
        for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
          vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
        end
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border_type })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border_type })
      require("lspconfig.ui.windows").default_options.border = vim.g.border_type
      vim.lsp.handlers["textDocument/definition"] = goto_definition("vsplit")
      local servers = {
        -- ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.vimruntime,
                  "${3rd}/luv/library",
                  "${3rd}/busted/library",
                },
              },
            },
          },
        },
        pyright = {},
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          nit_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        -- jedi_language_server = {},
        gopls = {},
        rust_analyzer = {},
        -- markdown_oxide = {},
        tailwindcss = {
          flags = { debounce_text_changes = 300 },
          root_dir = require("lspconfig").util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.cjs",
            "postcss.config.ts"
          ),
        },
        eslint = {},
        cssls = {},
        bashls = {
          filetypes = { "sh", "zsh" },
        },
        html = {},
        vtsls = {
          settings = {
            complete_functions_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        jsonls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "markdownlint",
        "shellcheck",
        "prettier",
        "shfmt",
      })

      require("mason").setup({
        ui = {
          icons = {
            package_installed = icons.ui.Check,
            package_pending = icons.ui.ArrowCircleRight,
            package_uninstalled = icons.ui.Close,
          },
        },
        max_concurrent_installers = 10,
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
