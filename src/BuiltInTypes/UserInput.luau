--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")

local combinedInputEnums = Enum.UserInputType:GetEnumItems()

for _, e in ipairs(Enum.KeyCode:GetEnumItems()) do
	combinedInputEnums[#combinedInputEnums + 1] = e
end

local userInputType = {
	Transform = function (text)
		local findEnum = Fuzzy.makeFuzzyFinder(combinedInputEnums)

		return findEnum(text)
	end,

	Validate = function (enums)
		return #enums > 0
	end,

	Autocomplete = function (enums)
		return Fuzzy.getNames(enums)
	end,

	Parse = function (enums)
		return enums[1]
	end,
}

return function (coco)
	coco:registerType("userInput", userInputType)
	coco:registerType("userInputs", TypeUtils.makeListableType(userInputType))
end