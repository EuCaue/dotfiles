local cmd = vim.api.nvim_create_user_command
vim.g.diagnostics_visible = true

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
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
end, {})

cmd("Ha", function()
  vim.cmd([[Build]])
  vim.cmd([[Run]])
end, {})

cmd("Transparent", function()
  vim.cmd("hi Normal ctermbg=NONE guibg=NONE")
  vim.cmd("hi NormalFloat ctermbg=NONE guibg=NONE")
  vim.cmd("hi NormalNC ctermbg=NONE guibg=NONE")
  vim.cmd("hi Pmenu ctermbg=NONE guibg=NONE")
  vim.cmd("hi WinBar ctermbg=NONE guibg=NONE")
  vim.cmd("hi SignColumn ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopeNormal ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopeBorder ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopePromptTitle ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopePromptBorder ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopePromptNormal ctermbg=NONE guibg=NONE")
  vim.cmd("hi TelescopePreviewSize guibg=NONE ctermbg=NONE")
  vim.cmd("hi TelescopePreviewExecute guibg=NONE ctermbg=NONE")
  vim.cmd("hi TelescopePreviewHyphen guibg=NONE ctermbg=NONE")
  vim.cmd("hi FloatBorder ctermbg=NONE guibg=NONE")
  vim.cmd("hi CursorLine gui=bold cterm=bold")
  vim.cmd("hi CmpItemAbbrMatch guibg=NONE ctermbg=NONE")
  vim.cmd("hi CmpItemAbbr guibg=NONE ctermbg=NONE")
  vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
end, { desc = "Transparent background" })

cmd("Update", function()
  vim.cmd("Lazy update")
  vim.cmd("MasonUpdate")
end, { desc = "Update" })

cmd("ToggleLspDiag", function()
  local buf_clients = vim.lsp.get_clients()
  if next(buf_clients) == nil then
    if type(buf_clients) == "boolean" or #buf_clients == 0 then
      vim.notify("No LSP client found")
      return
    end
  end
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
  end
end, {})
