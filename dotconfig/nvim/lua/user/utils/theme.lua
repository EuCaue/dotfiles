local M = {}

-- @param name:string
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
