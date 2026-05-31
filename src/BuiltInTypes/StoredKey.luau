--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")
local Sift = require("../../packages/sift")

local VALID_STORED_KEY_NAME_PATTERNS = {
	"^%a[%w_]*$",
	"^%$%a[%w_]*$",
	"^%.%a[%w_]*$",
	"^%$%.%a[%w_]*$",
}

return function (coco)
	local storedKeyType = {
		Autocomplete = function(text)
			local find = Fuzzy.makeFuzzyFinder(Sift.Dictionary.keys(coco:getStore("vars_used") or {}))

			return find(text)
		end,

		Validate = function(text)
			for _, pattern in ipairs(VALID_STORED_KEY_NAME_PATTERNS) do
				if text:match(pattern) then
					return true
				end
			end

			return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
		end,

		Parse = function(text)
			return text
		end,
	}
	coco:registerType("storedKey", storedKeyType)
	coco:registerType("storedKeys", TypeUtils.makeListableType(storedKeyType))
end
