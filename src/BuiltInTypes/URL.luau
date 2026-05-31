--!strict
local TypeUtils = require("../Shared/TypeUtils")

local storedKeyType = {
	Validate = function(text)
		if text:match("^https?://.+$") then
			return true
		end

		return false, "URLs must begin with http:// or https://"
	end,

	Parse = function(text)
		return text
	end,
}

return function (coco)
	coco:registerType("url", storedKeyType)
	coco:registerType("urls", TypeUtils.makeListableType(storedKeyType))
end
