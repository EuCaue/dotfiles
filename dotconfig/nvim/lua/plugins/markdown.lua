return {
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.cmd([[do FileType]])
      vim.cmd([[
      function OpenMarkdownPreview (url)
      let cmd = "epiphany " . shellescape(a:url) . " &"
      silent call system(cmd)
      silent call setreg('+', a:url)
      endfunction
      ]])
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_port = "2512"
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
      vim.g.mkdp_open_ip = "localhost"
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_highlight_css = "/home/caue/dotfiles/dotconfig/highlight.css"
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    cmd = { "ObsidianSearch", "ObsidianQuickSwitch" },
    keys = {
      {
        mode = { "n", "v", "x" },
        "<leader>ms",
        "<cmd>ObsidianQuickSwitch<cr>",
        desc = "Search Notes",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mg",
        "<cmd>ObsidianSearch<cr>",
        desc = "Grep Notes",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>ml",
        "<cmd>ObsidianLink<cr>",
        desc = "Create Link with word under cursor",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mln",
        "<cmd>ObsidianLinkNew<cr>",
        desc = "Create new note and link it",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mal",
        "<cmd>ObsidianLinks<cr>",
        desc = "List all links in the current buffer",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>me",
        "<cmd>ObsidianExtractNote<cr>",
        desc = "Extract word under cursor into new note",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mp",
        "<cmd>ObsidianPasteImg<cr>",
        desc = "Paste image from clipboard",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mt",
        "<cmd>ObsidianTags<cr>",
        desc = "Search tags in notes",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mr",
        "<cmd>ObsidianRename<cr>",
        desc = "Rename the note of the current buffer or reference under the cursor,",
        ft = "markdown",
      },
      {
        mode = { "n", "v", "x" },
        "<leader>mn",
        "<cmd>ObsidianNew<cr>",
        desc = "Create new note",
      },
    },
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/vault/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/vault/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      note_id_func = function(title)
        return title or ("new-note-" .. os.time())
      end,

      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,

      attachments = {
        img_folder = "images/",
        img_text_func = function(client, path)
          local full_path = path
          path = client:vault_relative_path(path) or path
          local cmd = "sh -c "
            .. vim.fn.shellescape("convert " .. full_path.filename .. " -quality 70 " .. full_path.filename)
          vim.fn.system(cmd)
          return string.format("![%s](%s)", path.name, path)
        end,
      },
      templates = {
        subdir = "Templates",
        substitutions = {
          tags = function()
            local file_name = vim.fn.expand("%:t:r")
            local tags = {}
            for tag in file_name:gmatch("[^" .. "-" .. "]+") do
              table.insert(tags, tag)
            end
            return table.concat(tags, ", ")
          end,
        },
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/vault/",
        },
      },
    },
  },

  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    opts = {
      on_attach = function(bufnr)
        local function toggle(key)
          return "<Esc>gv<Cmd>lua require'markdown.inline'" .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
        end
        vim.keymap.set("x", "<C-b>", toggle("b"), { buffer = bufnr })
        vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
        vim.keymap.set("x", "<C-c>", toggle("c"), { buffer = bufnr })
      end,
    },
  },

  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = "markdown",
    config = function()
      require("render-markdown").setup({
        render_modes = { "n", "c", "x", "v" },
        win_options = {
          conceallevel = {
            rendered = 2,
          },
        },
        markdown_query = [[
            (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
            ] @heading)

            (thematic_break) @dash

            (fenced_code_block) @code

            (block_quote (block_quote_marker) @quote_marker)
            (block_quote (paragraph (inline (block_continuation) @quote_marker)))

            (pipe_table) @table
            (pipe_table_header) @table_head
            (pipe_table_delimiter_row) @table_delim
            (pipe_table_row) @table_row
        ]],
      })
    end,
  },

  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text" },
    opts = {},
    cmd = {
      "AutolistRecalculate",
      "AutolistNewBullet",
      "AutolistNewBulletBefore",
    },
    keys = {
      {
        mode = "i",
        "<c-t>",
        "<c-t><cmd>AutolistRecalculate<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "i",
        "<CR>",
        "<CR><cmd>AutolistNewBullet<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "n",
        "o",
        "o<cmd>AutolistNewBullet<cr>",
        ft = { "markdown", "text" },
      },

      {
        mode = "n",
        "O",
        "O<cmd>AutolistNewBulletBefore<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "n",
        ">>",
        ">><cmd>AutolistRecalculate<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "n",
        "<<",
        "<<<cmd>AutolistRecalculate<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "n",
        "dd",
        "dd<cmd>AutolistRecalculate<cr>",
        ft = { "markdown", "text" },
      },
      {
        mode = "v",
        "d",
        "d<cmd>AutolistRecalculate<cr>",
        ft = { "markdown", "text" },
      },
    },
  },
}
