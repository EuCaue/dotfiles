local cmd = vim.api.nvim_create_user_command

local build_commands = {
  c = "g++ -std=c++17 -o %:p:r.o %",
  typescript = "bun %",
  cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
  rust = "cargo build --release",
  fish = "./%",
  go = "go build",
  java = "java %",
}

local run_commands = {
  c = "%:p:r.o",
  java = "java %",
  typescript = "bun %",
  python = "python3 %",
  cpp = "%:p:r.o",
  rust = "cargo run --release",
  go = "go run .",
  fish = "./%",
}

cmd("Build", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(build_commands) do
    if filetype == file then
      vim.cmd("!" .. command)
      break
    end
  end
end, {})

cmd("LspFormat", function()
  require("conform").format({ async = true, bufnr = 0, lsp_fallback = true })
end, { desc = "Format with LSP" })

cmd("Run", function()
  local filetype = vim.bo.filetype

  for file, command in pairs(run_commands) do
    if filetype == file then
      vim.cmd("sp")
      print(file)
      vim.cmd("term " .. command)
      vim.cmd("resize 12N")
      local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
      break
    end
  end
end, {})

cmd("ToggleInlayHints", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, {})

cmd("Ha", function()
  vim.cmd([[Build]])
  vim.cmd([[Run]])
end, {})

cmd("LtexLangChangeLanguage", function(data)
  local language = data.fargs[1]
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_active_clients({ bufnr = bufnr, name = "ltex" })
  if #client == 0 then
    vim.notify("No ltex client attached")
  else
    client = client[1]
    client.config.settings = {
      ltex = {
        language = language,
      },
    }
    client.notify("workspace/didChangeConfiguration", client.config.settings)
    vim.notify("Language changed to " .. language)
  end
end, {
  nargs = 1,
  desc = "Change Ltex Langunage",
  force = true,
})
