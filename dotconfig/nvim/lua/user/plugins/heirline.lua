--  TODO: shorten the file path

return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  enabled = true,
  config = function()
    local icons = require("user.core.icons")
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")
    local padding = require("user.core.helpers").padding

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "N",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "V",
          vs = "Vs",
          V = "V_",
          Vs = "Vs",
          ["\22"] = "^V",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "I",
          ic = "Ic",
          ix = "Ix",
          R = "R",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "C",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
        -- mode_colors = {
        --     n = "red" ,
        --     i = "green",
        --     v = "cyan",
        --     V =  "cyan",
        --     ["\22"] =  "cyan",
        --     c =  "orange",
        --     s =  "purple",
        --     S =  "purple",
        --     ["\19"] =  "purple",
        --     R =  "orange",
        --     r =  "orange",
        --     ["!"] =  "red",
        --     t =  "red",
        -- }
      },
      -- We can now access the value of mode() that, by now, would have been
      -- computed by `init()` and use it to index our strings dictionary.
      -- note how `static` fields become just regular attributes once the
      -- component is instantiated.
      -- To be extra meticulous, we can also add some vim statusline syntax to
      -- control the padding and make sure our string is always at least 2
      -- characters long. Plus a nice Icon.
      provider = function(self)
        -- return "%2(" .. self.mode_names[self.mode] .. "%)"
        return padding(self.mode_names[self.mode], 2, 0)
      end,
      hl = function(self)
        return { bold = true }
      end,
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
    }
    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileName = {
      provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        --  TODO: user a short path by default
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" and vim.bo.filetype ~= "alpha" then
          return padding(icons.ui.FileHidden, 1)
        end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return padding(filename, vim.bo.modified and 1 or 2, 2)
      end,
      hl = { fg = utils.get_highlight("Directory").fg, bold = true },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified and vim.bo.filetype ~= "alpha"
        end,
        provider = padding(icons.ui.Pencil, 2),
        hl = {},
      },
      {
        condition = function()
          return not vim.bo.modifiable and vim.bo.filetype ~= "alpha" or vim.bo.readonly
        end,
        provider = padding(icons.ui.Lock, 2, 1),
        hl = {},
      },
    }

    -- Now, let's say that we want the filename color to change if the buffer is
    -- modified. Of course, we could do that directly using the FileName.hl field,
    -- but we'll see how easy it is to alter existing components using a "modifier"
    -- component

    local FileNameModifer = {
      hl = function()
        if vim.bo.modified then
          -- use `force` because we need to override the child's hl foreground
          return { bold = true, force = true }
        end
      end,
    }

    -- let's add the children to our FileNameBlock component
    FileNameBlock = utils.insert(
      FileNameBlock,
      FileFlags,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
      { provider = "%< " } -- this means that the statusline is cut here when there's not enough space
    )
    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,

      hl = { fg = utils.get_highlight("Bold").fg },

      { -- git branch name
        provider = function(self)
          return padding(icons.git.Branch, 0, 1) .. self.status_dict.head
        end,
        hl = { bold = true },
      },
      -- You could handle delimiters, icons and counts similar to Diagnostics
      -- {
      --   condition = function(self)
      --     return self.has_changes
      --   end,
      --   provider = "(",
      -- },
      -- {
      --   provider = function(self)
      --     local count = self.status_dict.added or 0
      --     return count > 0 and ("+" .. count)
      --   end,
      --   hl = { fg = "git_add" },
      -- },
      -- {
      --   provider = function(self)
      --     local count = self.status_dict.removed or 0
      --     return count > 0 and ("-" .. count)
      --   end,
      --   hl = { fg = "git_del" },
      -- },
      -- {
      --   provider = function(self)
      --     local count = self.status_dict.changed or 0
      --     return count > 0 and ("~" .. count)
      --   end,
      --   hl = { fg = "git_change" },
      -- },
      -- {
      --   condition = function(self)
      --     return self.has_changes
      --   end,
      --   provider = ")",
      -- },
    }
    local FileIcon = {
      provider = function()
        local ft = vim.bo.filetype
        return vim.g.have_nerd_font and padding(require("mini.icons").get("filetype", ft), 0, 0) or ""
      end,
      hl = function()
        local ft = vim.bo.filetype
        local _, hl_name, _ = require("mini.icons").get("filetype", ft)
        local hl = utils.get_highlight(hl_name).fg
        return { fg = (vim.g.have_nerd_font and hl) or "" }
      end,
    }
    local FileType = {
      provider = function()
        return string.upper(vim.bo.filetype)
      end,
      hl = { fg = utils.get_highlight("Type").fg, bold = true },
    }

    local SearchCount = {
      condition = function()
        return vim.v.hlsearch ~= 0
      end,
      init = function(self)
        local ok, search = pcall(vim.fn.searchcount)
        if ok and search.total then
          self.search = search
        end
      end,
      provider = function(self)
        local search = self.search
        return padding(icons.ui.Search, 2, 1) .. search.current .. "/" .. math.min(search.total, search.maxcount)
      end,
      hl = { fg = utils.get_highlight("IncSearch").bg, bold = true },
    }

    local MacroRec = {
      condition = function()
        return vim.fn.reg_recording() ~= ""
      end,
      provider = padding(icons.ui.Recording, 1, 1),
      hl = { bold = true },
      utils.surround({ "[", "]" }, nil, {
        provider = function()
          return vim.fn.reg_recording()
        end,
        hl = { fg = utils.get_highlight("diffAdded").fg, bold = true },
      }),
      update = {
        "RecordingEnter",
        "RecordingLeave",
      },
    }
    -- We're getting minimalist here!
    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      -- provider = "%7(%l/%3L%):%2c",
      provider = padding(icons.ui.Text, 2, 1) .. "LINE" .. padding("%l/%L", 1, 1) .. padding("", 0, 1) .. padding(
        "COL",
        0,
        1
      ) .. padding('%v|%{virtcol("$") - 1}', 0, 1),
      hl = { bold = true },
    }
    local Diagnostics = {
      condition = conditions.lsp_attached and conditions.has_diagnostics,
      static = {
        error_icon = icons.diagnostics.Error,
        warn_icon = icons.diagnostics.Warning,
        info_icon = icons.diagnostics.Information,
        hint_icon = icons.diagnostics.Hint,
      },

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      update = { "DiagnosticChanged", "BufEnter" },

      {
        provider = function(self)
          return self.errors > 0 and (padding(self.error_icon, 0, 1) .. padding(self.errors, 0, 1))
        end,
        hl = { fg = utils.get_highlight("DiagnosticError").fg },
      },
      {
        provider = function(self)
          return self.warnings > 0 and (padding(self.warn_icon, 0, 0) .. padding(self.warnings, 0, 1))
        end,
        hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
      },
      {
        provider = function(self)
          return self.info > 0 and (padding(self.info_icon, 0, 0) .. padding(self.info, 0, 1))
        end,
        hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
      },
      {
        provider = function(self)
          return self.hints > 0 and (padding(self.hint_icon, 0, 0) .. padding(self.hints, 0, 1))
        end,
        hl = { fg = utils.get_highlight("DiagnosticHint").fg },
      },
    }

    local WordCount = {
      condition = function()
        return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
      end,
      provider = function()
        local wc = vim.fn.wordcount()
        return padding(icons.ui.Comment, 2, 0)
          .. padding(wc.words, 1, 0)
          .. "WORDS"
          .. padding("󰾹", 1, 1)
          .. wc.chars
          .. "CHARS"
      end,
      hl = { fg = utils.get_highlight("Comment").fg, bold = true },
    }

    require("heirline").setup({
      statusline = {
        MacroRec,
        ViMode,
        FileNameBlock,
        Git,
        { provider = "%=" },
        Diagnostics,
        FileIcon,
        { provider = " " },
        FileType,
        SearchCount,
        WordCount,
        Ruler,
      },
    })
  end,
}
