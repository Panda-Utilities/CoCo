--!strict
local TypeUtils = require("../Shared/TypeUtils")

local stringType = {
	Validate = function(value)
		return value ~= nil
	end,

	Parse = function(value)
		return tostring(value)
	end,
}

local numberType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil
	end,

	Parse = function(value)
		return value
	end,
}

local intType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil and value == math.floor(value), "Only whole numbers are valid."
	end,

	Parse = function(value)
		return value
	end,
}

local positiveIntType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil and value == math.floor(value) and value > 0, "Only positive whole numbers are valid."
	end,

	Parse = function(value)
		return value
	end,
}

local nonNegativeIntType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil and value == math.floor(value) and value >= 0, "Only non-negative whole numbers are valid."
	end,

	Parse = function(value)
		return value
	end,
}

local byteType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil and value == math.floor(value) and value >= 0 and value <= 255, "Only bytes are valid."
	end,

	Parse = function(value)
		return value
	end,
}

local digitType = {
	Transform = function(text)
		return tonumber(text)
	end,

	Validate = function(value)
		return value ~= nil and value == math.floor(value) and value >= 0 and value <= 9, "Only digits are valid."
	end,

	Parse = function(value)
		return value
	end,
}

local boolType do
	local truthy = TypeUtils.makeDictionary({"true", "t", "yes", "y", "on", "enable", "enabled", "1", "+"})
	local falsy = TypeUtils.makeDictionary({"false", "f", "no", "n", "off", "disable", "disabled", "0", "-"})

	boolType = {
		Transform = function(text)
			return text:lower()
		end,

		Validate = function(value)
			return truthy[value] ~= nil or falsy[value] ~= nil, "Please use true/yes/on or false/no/off."
		end,

		Parse = function(value)
			if truthy[value] then
				return true
			elseif falsy[value] then
				return false
			else
				return nil
			end
		end,
	}
end

return function(coco)
	coco:registerType("string", stringType)
	coco:registerType("number", numberType)
	coco:registerType("integer", intType)
	coco:registerType("positiveInteger", positiveIntType)
	coco:registerType("nonNegativeInteger", nonNegativeIntType)
	coco:registerType("byte", byteType)
	coco:registerType("digit", digitType)
	coco:registerType("boolean", boolType)

	coco:registerType("strings", TypeUtils.makeListableType(stringType))
	coco:registerType("numbers", TypeUtils.makeListableType(numberType))
	coco:registerType("integers", TypeUtils.makeListableType(intType))
	coco:registerType("positiveIntegers", TypeUtils.makeListableType(positiveIntType))
	coco:registerType("nonNegativeIntegers", TypeUtils.makeListableType(nonNegativeIntType))
	coco:registerType("bytes", TypeUtils.makeListableType(byteType))
	coco:registerType("digits", TypeUtils.makeListableType(digitType))
	coco:registerType("booleans", TypeUtils.makeListableType(boolType))
end
