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

db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently files                             ",
		action = "Telescope oldfiles",
		shortcut = "  SPC f f",
	},
	{
		icon = "  ",
		desc = "File Browser                               ",
		action = "NvimTreeToggle",
		shortcut = "  SPC g  ",
	},
	{
		icon = "  ",
		desc = "Config                                       ",
		action = "e ~/dotfiles/nvim/init.lua",
		shortcut = "SPC d ",
	},
	{
		icon = "  ",
		desc = "Dev                                          ",
		action = ":NvimTreeToggle ~/Dev",
		shortcut = "SPC D  ",
	},
}
