local M = {}

--- Check if the URL is a valid URL: description
---@param url string:parameter
---@return boolean
local function is_url(url)
  local pattern = "^(https?://[%w-_%.%?%.:/%+=&]+)$"
  return url:match(pattern) ~= nil
end

--- Extracts the domain from a URL: description
---@param url string:parameter
---@return string
local function extract_domain(url)
  local domain = url:match("://([^/]+)")

  -- If the domain starts with 'www', remove it and return the result without it
  if domain:match("^www%.") then
    return domain:match("^www%.([^%.]+)")
  else
    return domain:match("([^%.]+)")
  end
end


function M.setup()
vim.paste = (function(overridden)
  return function(lines, phase)
    local new_lines = {}
    for i, line in ipairs(lines) do
      if is_url(line) then
        local url = lines[i]
        local domain = extract_domain(url)
        local formatted_url = "[" .. domain .. "]" .. "(" .. url .. ")"
        new_lines[i] = formatted_url
      else
        new_lines[i] = line
      end
    end
    overridden(new_lines, phase)
  end
end)(vim.paste)
end

return M

