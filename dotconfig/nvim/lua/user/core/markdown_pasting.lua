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
  local host = url:match("://([^/]+)")
  host = host:gsub("^www%.", "")
  local parts = {}
  for part in host:gmatch("([^.]+)") do
    table.insert(parts, part)
  end

  if #parts >= 2 then
    return parts[#parts - 1]
  else
    return parts[1] or ""
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
