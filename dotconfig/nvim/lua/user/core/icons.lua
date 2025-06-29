local icon_definitions = {
  git = {
    LineAdded = " ",
    LineModified = " ",
    LineRemoved = " ",
    FileDeleted = " ",
    FileIgnored = "◌",
    FileRenamed = " ",
    FileStaged = "S",
    FileUnmerged = "",
    FileUnstaged = "",
    FileUntracked = "U",
    Diff = " ",
    Repo = " ",
    Octoface = " ",
    Copilot = " ",
    Branch = "",
  },
  ui = {
    ArrowCircleDown = "",
    Square = "■",
    ArrowCircleLeft = "",
    ArrowCircleRight = "",
    ArrowCircleUp = "",
    BoldArrowDown = "",
    BoldArrowLeft = "",
    BoldArrowRight = "",
    BoldArrowUp = "",
    BoldClose = "",
    BoldDividerLeft = "",
    BoldDividerRight = "",
    BoldLineLeft = "▎",
    BoldLineMiddle = "┃",
    BoldLineDashedMiddle = "┋",
    BookMark = "",
    BoxChecked = "",
    Bug = "",
    Stacks = "",
    Scopes = "",
    Watches = "󰂥",
    DebugConsole = "",
    Calendar = "",
    Check = "",
    ChevronRight = "",
    ChevronShortDown = "",
    ChevronShortLeft = "",
    ChevronShortRight = "",
    ChevronShortUp = "",
    Circle = "",
    Close = "󰅖",
    CloudDownload = " ",
    Code = "",
    Comment = "",
    Dashboard = "",
    DividerLeft = "",
    DividerRight = "",
    DoubleChevronRight = "»",
    Ellipsis = "",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "",
    FileHidden = "󰘓",
    FileSymlink = "",
    Files = "",
    FindFile = "󰈞",
    FindText = "󰊄",
    Fire = "",
    Folder = "󰉋",
    FolderOpen = "",
    FolderSymlink = "",
    Forward = "",
    Gear = "",
    History = "",
    Lightbulb = "",
    LineLeft = "▏",
    LineMiddle = "│",
    List = "",
    Lock = "",
    NewFile = "",
    Column = "󰠵",
    Note = "",
    Package = "",
    Pencil = "󰏫",
    Plus = "",
    Project = "",
    Recording = "󰻃",
    Search = "",
    SignIn = "",
    SignOut = "",
    Tab = "󰌒 ",
    Table = "",
    Target = "󰀘",
    Telescope = "",
    Text = "",
    Tree = "",
    Triangle = "󰐊",
    TriangleShortArrowDown = "",
    TriangleShortArrowLeft = "",
    TriangleShortArrowRight = "",
    TriangleShortArrowUp = "",
  },
  diagnostics = {
    BoldError = "",
    Error = "",
    BoldWarning = "",
    Warning = "",
    BoldInformation = "",
    Information = "",
    BoldQuestion = "",
    Question = "",
    BoldHint = "",
    Hint = "󰌶",
    Debug = "",
    Trace = "✎",
  },
  misc = {
    Robot = "󰚩",
    Squirrel = "",
    Tag = "",
    Watch = "",
    Smiley = "",
    Point = "󱅶",
    RestoreSession = "",
    Lazy = "󰒲",
    Package = "",
    CircuitBoard = "",
  },
}

local function merge_fallback(icon_tbl, manual_fallback)
  local merged = {}
  for key, value in pairs(icon_tbl) do
    if type(value) == "table" then
      merged[key] = merge_fallback(value, manual_fallback and manual_fallback[key] or nil)
    else
      if manual_fallback and manual_fallback[key] then
        merged[key] = manual_fallback[key]
      else
        merged[key] = ""
      end
    end
  end
  return merged
end

local manual_fallback_definitions = {
  git = {
    LineAdded = "+",
    LineModified = "~",
    LineRemoved = "-",
    FileDeleted = "x",
    Branch = "B",
  },
  ui = {
    BoldLineMiddle = "┃",
    BoldLineDashedMiddle = "┃",
    TriangleShortArrowRight = "_",
  },
}

local final_fallback_definitions = merge_fallback(icon_definitions, manual_fallback_definitions)

local function create_icon_proxy(icons, fallback_definitions)
  return setmetatable({}, {
    __index = function(_, key)
      if vim.g.have_nerd_font then
        return icons[key]
          or setmetatable({}, {
            __index = function()
              return ""
            end,
          })
      else
        return fallback_definitions[key]
          or setmetatable({}, {
            __index = function()
              return ""
            end,
          })
      end
    end,
  })
end

local icons = create_icon_proxy(icon_definitions, final_fallback_definitions)
return icons
