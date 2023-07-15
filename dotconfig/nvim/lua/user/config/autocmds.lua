local utils = require("user.utils")
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "spectre_panel",
    "lspinfo",
    "oil",
    "vim",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- Autoformat
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = augroup("format_on_save"),
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })

-- check with eslint exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("eslint_exists"),
  pattern = { "*" },
  callback = function()
    local root_dir = vim.fn.getcwd()
    local eslint_config_path = vim.fn.expand(root_dir .. "/*.eslint*")
    local eslint_config_exists = vim.loop.fs_stat(eslint_config_path)
    if eslint_config_exists ~= nil then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- better highlight on styled.js
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("styled"),
  pattern = { "styled.js" },
  callback = function()
    vim.cmd([[TSBufDisable highlight]])
  end,
})

vim.api.nvim_create_autocmd("BufNew", {
  group = augroup("ColorScheme"),
  callback = function()
    vim.cmd("hi FlashCurrent guibg=none")
    vim.cmd("hi FlashMatch guibg=none")
    --  TODO: make this get the colorscheme
    vim.cmd("hi FlashLabel guifg=White guibg=#E55C67 cterm=bold")
  end,
})

-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   group = augroup("LuaSniptHistory"),
--   pattern = "*",
--   callback = function()
--     if
--         ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
--         and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--         and not require("luasnip").session.jump_active
--     then
--       require("luasnip").unlink_current()
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("WinLeave", {
--   callback = function()
--     if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
--     end
--   end,
-- })

vim.api.nvim_create_user_command("BG", utils.toggle_transparency, {})
