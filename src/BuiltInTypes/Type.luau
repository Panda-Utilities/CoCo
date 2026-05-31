--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")

return function (coco)
	local typeType = {
		Transform = function (text)
			local findCommand = Fuzzy.makeFuzzyFinder(coco:getTypeNames())

			return findCommand(text)
		end,

		Validate = function (commands)
			return #commands > 0, "No type with that name could be found."
		end,

		Autocomplete = function (commands)
			return commands
		end,

		Parse = function (commands)
			return commands[1]
		end,
	}

	coco:registerType("type", typeType)
	coco:registerType("types", TypeUtils.makeListableType(typeType))
end