--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")

return function (coco)
	local commandType = {
		Transform = function (text)
			local findCommand = Fuzzy.makeFuzzyFinder(coco:getCommandNames())

			return findCommand(text)
		end,

		Validate = function (commands)
			return #commands > 0, "No command with that name could be found."
		end,

		Autocomplete = function (commands)
			return commands
		end,

		Parse = function (commands)
			return commands[1]
		end,
	}

	coco:registerType("command", commandType)
	coco:registerType("commands", TypeUtils.makeListableType(commandType))
end