local get_theme = function()
  if vim.o.background == "dark" then
    return "github-dark"
  end
  return "github"
end
return {
  "charm-and-friends/freeze.nvim",
  cmd = "Freeze",
  opts = {
    command = "freeze",
    window = true,
    show_line_numbers = true,
    border = {
      radius = 10,
      width = 2,
    },
    shadow = {
      blur = 24,
      x = 5,
      y = 12,
    },
    padding = "20",
    margin = "0",
    open = true,
    font = {
      family = "MesloLGSDZ Nerd Font",
      size = 12,
    },
    language = vim.fn.expand("%:e"),
    line_height = 1.4,
    output = function()
      return "/tmp/" .. os.date("%Y-%m-%d") .. "_freeze.png"
    end,
    theme = get_theme(),
  },
}
