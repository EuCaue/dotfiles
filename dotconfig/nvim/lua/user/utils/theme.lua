local M = {}

M.toggle_transparency = function()
	local data_dir = vim.fn.stdpath("data")
	local colorscheme = vim.g.colors_name
	local file_path = data_dir .. "/toggle_transparency.txt"

	local file = io.open(file_path, "r")
	local current_value = file:read("*all")
	file:close()

	local new_value = "true"
	if current_value == "true" then
		new_value = "false"
	end

	file = io.open(file_path, "w")
	file:write(new_value)
	file:close()

	if colorscheme == "onedark" then
		require("onedark").setup({ transparent = (new_value == "true") })
		require("onedark").load()
	end
end

M.get_transparency_value = function()
	local data_dir = vim.fn.stdpath("data")
	local file_path = data_dir .. "/toggle_transparency.txt"
	local file = io.open(file_path, "r")
	local current_value = file:read("*all")
	file:close()

	return current_value
end

-- @param name
-- @return string?

M.get_hlcode = function(name)
	local hlnr = vim.fn.hlID(name)
	if type(hlnr) ~= "number" or hlnr <= 0 then
		return nil
	end
	local synnr = vim.fn.synIDtrans(hlnr)
	if type(synnr) ~= "number" or synnr <= 0 then
		return nil
	end
	local guicode = vim.fn.synIDattr(synnr, "fg", "gui")
	if type(guicode) == "string" and string.len(guicode) > 0 then
		return guicode
	end
	return vim.fn.synIDattr(synnr, "fg", "cterm")
end

return M
