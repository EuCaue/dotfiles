local cmd = vim.api.nvim_create_user_command

local build_commands = {
  c = "g++ -std=c++17 -o %:p:r.o %",
  cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
  typescript = "bun %",
  rust = "cargo build --release",
  fish = "./%",
  go = "go build",
  java = "javac %",
  javascript = "node %",
}

local run_commands = {
  javascript = "node %",
  typescript = "bun %",
  rust = "cargo run --release",
  go = "go run .",
  python = "python3 %",
}

-- Helper function to execute a command for the current filetype
local function execute_command(commands)
  local ft = vim.bo.filetype
  local cmd_template = commands[ft]
  if not cmd_template then
    print("No command defined for filetype: " .. ft)
    return
  end
  -- Expand filename placeholders
  local command = vim.fn.expand(cmd_template)
  vim.cmd("!" .. command)
end

cmd("Build", function()
  execute_command(build_commands)
end, {})

cmd("Run", function()
  local ft = vim.bo.filetype
  local cmd_template = run_commands[ft]
  if not cmd_template then
    print("No run command defined for filetype: " .. ft)
    return
  end
  local command = vim.fn.expand(cmd_template)
  vim.cmd("split") -- open a horizontal split
  vim.cmd("resize 12") -- resize terminal
  vim.cmd("term " .. command) -- run command in terminal
end, {})

cmd("BuildRun", function()
  vim.cmd("Build")
  vim.cmd("Run")
end, {})

cmd("Log", require("user.core.helpers").debug, { desc = "Logging" })
cmd("Transparent", require("user.core.helpers").toggle_transparency, { desc = "Transparent" })
