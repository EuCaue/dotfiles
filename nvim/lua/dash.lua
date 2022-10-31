local home = os.getenv("HOME")
local db = require("dashboard")
-- linux
-- db.preview_command = 'ueberzug'
-- db.preview_file_path = '/home/caue/Pictures/23.jpeg'
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
		desc = "Recently opened files                     ",
		action = "Telescope oldfiles",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Find Browser                              ",
		action = "Telescope file_browser",
		shortcut = "SPC f w",
	},
	{
		icon = "  ",
		desc = "File Tree Browser                           ",
		action = "NvimTreeToggle",
		shortcut = "SPC r ",
	},
	{
		icon = "  ",
		desc = "Init.lua                                   ",
		action = "e ~/dotfiles/nvim/init.lua",
		shortcut = "SPC d",
	},

	{
		icon = "  ",
		desc = "Dev                                         ",
		action = ":NvimTreeToggle ~/Dev",
		shortcut = "SPC D",
	},
}
