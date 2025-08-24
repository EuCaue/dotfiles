local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("myvim_" .. name, { clear = true })
end

-- autocmd("BufNewFile", {
--   group = augroup("new_file"),
--   pattern = "*",
--   callback = function()
--     local filename = vim.api.nvim_buf_get_name(0)
--     filename = vim.fn.fnamemodify(filename, ":.")
--     if filename == "" and vim.bo.filetype ~= "alpha" then
--       vim.bo.filetype = "markdown"
--     end
--   end,
-- })

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

autocmd("FileType", {
  desc = "Automatically Split help Buffers to the right",
  pattern = "help",
  command = "wincmd L",
})

autocmd({ "VimEnter" }, {
  group = augroup("enable_tab_line"),
  callback = function()
    require("user.core.tabline").setup()
  end,
})

autocmd({ "BufWinEnter" }, {
  group = augroup("disable_continuo_comment"),
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- close some filetypes with <q>
autocmd({ "FileType" }, {
  group = augroup("close_with_q"),
  pattern = {
    "netrw",
    "checkhealth",
    "qf",
    "git",
    "undotree",
    "help",
    "man",
    "lspinfo",
    "DressingSelect",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  group = augroup("man_unlisted"),
  desc = "make it easier to close man-files when opened inline",
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

autocmd("FileType", {
  group = augroup("wrap_spell"),
  desc = "wrap and check for spell in text filetypes",
  pattern = { "text", "gitcommit", "markdown" },
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" then
      return
    end

    -- TODO: organize this
    local map = vim.keymap.set
    local buffer = event.buf
    vim.opt_local.spell = true
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.textwidth = 100
    local marktools = require("user.core.marktools")
    require("user.core.markdown_pasting").setup()
    marktools.setup()
    marktools.apply_priority_highlight()
    map("n", "<leader>mt", marktools.cycle_checkbox, { desc = "cycle checkboxes state", buffer = buffer })
    map("n", "<CR>", marktools.cycle_checkbox, { desc = "cycle checkboxes state", buffer = buffer })
    map({ "n", "v" }, "<leader>mo", marktools.order_by_priority, { desc = "order by priority", buffer = buffer })
    map("n", "<leader>mp", marktools.toggle_priority, { desc = "cycle priority", buffer = buffer })
    map({ "n", "v" }, "<leader>ml", marktools.create_link, { desc = "create link", buffer = buffer })
    map("i", "<C-n>", "- [ ]  @p1 ()", { noremap = true, silent = false, desc = "create todo" })
  end,
})

--  TODO: move this to marktools 
autocmd("ColorScheme", {
  group = augroup("testin"),
  callback = function()
    if vim.bo.filetype == "markdown" then
      local marktools = require("user.core.marktools")
      marktools.setup()
      marktools.apply_priority_highlight()
    end
  end,
})

autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Big file
vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and "bigfile"
          or nil
      end,
    },
  },
})

autocmd({ "FileType" }, {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    vim.b.minianimate_disable = true
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd("quit")
  end,
})

autocmd({ "VimResized" }, {
  group = augroup("resize"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd({ "TextYankPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({ higroup = "DiffDelete", timeout = 250 })
  end,
})

autocmd("FileType", {
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
  end,
})

autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  desc = "resize splits if window got resized",
  callback = function()
    -- local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    -- vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
    vim.opt_local.formatoptions:append("o") -- `o` in normal mode
    vim.opt_local.comments = {
      "b:- [ ]", -- tasks
      "b:- [x]",
      "b:- [>]",
      "b:- [~]",
      "b:*", -- unordered list
      "b:-",
      "b:+",
    }
  end,
})
