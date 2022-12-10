local db = require("dashboard")
db.default_banner = {
	"",
	"",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"",
	" [ TIP: To exit Neovim, just power off your computer. ] ",
	"",
}

db.preview_command = "cat"
db.preview_file_path = "/home/caue/assss.txt"

db.preview_file_height = 11
db.preview_file_width = 90
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently files                             ",
		action = "Telescope oldfiles",
		shortcut = "  SPC t o",
	},
	{
		icon = "  ",
		desc = "Projects                                   ",
		action = "Telescope project",
		shortcut = "  SPC t p",
	},
	{
		icon = "  ",
		desc = "File Browser                               ",
		action = "NvimTreeToggle",
		shortcut = "  SPC g  ",
	},
	{
		icon = "  ",
		desc = "Dotfiles                                     ",
		action = ":NvimTreeToggle ~/dotfiles/",
		shortcut = "SPC X  ",
	},
	{
		icon = "  ",
		desc = "Config                                       ",
		action = "e ~/dotfiles/nvim/init.lua",
		shortcut = "SPC x ",
	},
	{
		icon = "  ",
		desc = "Dev                                          ",
		action = ":NvimTreeToggle ~/Dev",
		shortcut = "SPC D  ",
	},
}
