local M = {}

M.create_select_menu = function(prompt, options_table) -- Or M.create_select_menu = function(prompt, options_table)
  -- Given the table of options, populate a list with option display names
  local option_names = {}
  local n = 0
  for i, _ in pairs(options_table) do
    n = n + 1
    option_names[n] = i
  end
  table.sort(option_names)

  -- Return the prompt function. These global function var will be used when assigning keybindings
  local menu = function()
    vim.ui.select(
      option_names, --> the list we populated above
      {
        prompt = prompt, --> Prompt passed as the argument Remove this variable if you want to keep the numbering in front of option names
        format_item = function(item)
          return item:gsub("%d. ", "")
        end,
      },

      function(choice)
        local action = options_table[choice]
        -- When user inputs ESC or q, don't take any actions
        if action ~= nil then
          if type(action) == "string" then
            vim.cmd(action)
          elseif type(action) == "function" then
            action()
          end
        end
      end
    )
  end

  return menu
end

M.border_status = "single" -- "single" "double" "rounded" "none"

M.servers = {
  "prosemd_lsp",
  -- "stylua",
  -- "markdownlint",
  -- "prettier",
  "eslint",
  "bashls",
  "lua_ls",
  "emmet_ls",
  "svelte",
  "marksman",
  "html",
  "cssls",
  "jsonls",
}

M.icons = require("user.utils.icons").icons

M.icons_selected = M.icons.kinds.nvchad

return M
