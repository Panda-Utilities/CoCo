--!strict
local Sift = require("../../packages/sift")

local Fuzzy = {}

local function transformInstanceSet(instances)
	local names = {}

	for i = 1, #instances do
		names[i] = instances[i].Name
	end

	return names, instances
end

function Fuzzy.makeFuzzyFinder(setOrContainer)
	local names
	local instances = {}

	if typeof(setOrContainer) == "Enum" then
		setOrContainer = setOrContainer:GetEnumItems()
	end

	if typeof(setOrContainer) == "Instance" then
		names, instances = transformInstanceSet(setOrContainer:GetChildren())
	elseif typeof(setOrContainer) == "table" then
		if
			typeof(setOrContainer[1]) == "Instance" or typeof(setOrContainer[1]) == "EnumItem" or
				(typeof(setOrContainer[1]) == "table" and typeof(setOrContainer[1].Name) == "string")
		 then
			names, instances = transformInstanceSet(setOrContainer)
		elseif type(setOrContainer[1]) == "string" then
			names = setOrContainer
		elseif setOrContainer[1] ~= nil then
			error("MakeFuzzyFinder only accepts tables of instances or strings.")
		else
			names = {}
		end
	else
		error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
	end

	return function(text, returnFirst)
		local results = {}

		for i, name in pairs(names) do
			local value = instances and instances[i] or name

			if name:lower() == text:lower() then
				if returnFirst then
					return value
				else
					table.insert(results, 1, value)
				end
			elseif name:lower():find(text:lower(), 1, true) then
				results[#results + 1] = value
			end
		end

		if returnFirst then
			return results[1]
		end

		return results
	end
end

function Fuzzy.getNames(instances)
	return Sift.List.map(instances, function(i)
		return i.Name or tostring(i)
	end)
end

function Fuzzy.makeEnumType(name, values)
	local findValue = Fuzzy.makeFuzzyFinder(values)
	return {
		Validate = function(text)
			return findValue(text, true) ~= nil, ("Value %q is not a valid %s."):format(text, name)
		end,
		Autocomplete = function(text)
			local list = findValue(text)
			return type(list[1]) ~= "string" and Fuzzy.getNames(list) or list
		end,
		Parse = function(text)
			return findValue(text, true)
		end
	}
end

return Fuzzy
