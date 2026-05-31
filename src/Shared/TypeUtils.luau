--!strict
local Sift = require("../../packages/sift")
local String = require("./String")

local TypeUtils = {}

function TypeUtils.makeDictionary(array)
	local dictionary = {}

	for i = 1, #array do
		dictionary[array[i]] = true
	end

	return dictionary
end

function TypeUtils.makeListableType(type, override)
	local listableType = {
		Listable = true,
		Transform = type.Transform,
		Validate = type.Validate,
		ValidateOnce = type.ValidateOnce,
		Autocomplete = type.Autocomplete,
		Default = type.Default,
		ArgumentOperatorAliases = type.ArgumentOperatorAliases,
		Selectors = type.Selectors,
		Parse = function(...)
			return {type.Parse(...)}
		end
	}

	if override then
		for key, value in pairs(override) do
			listableType[key] = value
		end
	end

	return listableType
end

function TypeUtils.splitPrioritizedDelimeter(text, delimeters)
	for i, delimeter in ipairs(delimeters) do
		if text:find(delimeter) or i == #delimeters then
			return String.splitStringSimple(text, delimeter)
		end
	end
end

function TypeUtils.parsePrefixedUnionType(typeValue, rawValue)
	local split = String.splitStringSimple(typeValue)

	local types = {}
	for i = 1, #split, 2 do
		types[#types + 1] = {
			prefix = split[i - 1] or "",
			type = split[i]
		}
	end

	table.sort(
		types,
		function(a, b)
			return #a.prefix > #b.prefix
		end
	)

	for i = 1, #types do
		local t = types[i]

		if rawValue:sub(1, #t.prefix) == t.prefix then
			return t.type, rawValue:sub(#t.prefix + 1), t.prefix
		end
	end
end

function TypeUtils.makeSequenceType(options)
	options = options or {}

	if options.Parse == nil and options.Constructor == nil then
		error("MakeSequenceType: Must provide one of: Constructor, Parse")
	end

	options.TransformEach = options.TransformEach or function(...)
		return ...
	end

	options.ValidateEach = options.ValidateEach or function()
		return true
	end

	return {
		Prefixes = options.Prefixes,

		Transform = function(text)
			return Sift.List.map(TypeUtils.splitPrioritizedDelimeter(text, {",", "%s"}), function(value)
				return options.TransformEach(value)
			end)
		end,

		Validate = function(components)
			if options.Length and #components > options.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(options.Length)
			end

			for i = 1, options.Length or #components do
				local valid, reason = options.ValidateEach(components[i], i)

				if not valid then
					return false, reason
				end
			end

			return true
		end,

		Parse = options.Parse or function(components)
			return options.Constructor(unpack(components))
		end,
	}
end

return TypeUtils
