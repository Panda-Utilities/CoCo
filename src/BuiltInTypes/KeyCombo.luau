--!strict
local String = require("../Shared/String")
local Fuzzy = require("../Shared/Fuzzy")

local allKeyCodes = Enum.KeyCode:GetEnumItems()

local MODIFIER_DISPLAY = {
	LeftControl = "Ctrl"; RightControl = "Ctrl",
	LeftShift = "Shift"; RightShift = "Shift",
	LeftAlt = "Alt"; RightAlt = "Alt",
}

local isModifier = {}
for name in pairs(MODIFIER_DISPLAY) do
	for _, e in ipairs(allKeyCodes) do
		if e.Name == name then
			isModifier[e] = true
		end
	end
end

local displayToModifiers = {}
local modifiersList = {}
for _, e in ipairs(allKeyCodes) do
	local display = MODIFIER_DISPLAY[e.Name]
	if display then
		if not displayToModifiers[display] then
			displayToModifiers[display] = {}
		end
		table.insert(displayToModifiers[display], e)
		modifiersList[#modifiersList + 1] = e
	end
end

local nonModifierKeyCodes = {}
for _, e in ipairs(allKeyCodes) do
	if not isModifier[e] then
		table.insert(nonModifierKeyCodes, e)
	end
end

local keycomboType = {
	Transform = function(text)
		if not text or #text == 0 then return {} end

		if text:lower() == "list" then
			return { mode = "list" }
		end

		local parts = String.splitStringSimple(text, "+")
		local prefix = ""
		for i = 1, #parts - 1 do
			prefix = prefix .. parts[i] .. "+"
		end
		local lastPart = parts[#parts] or ""

		local findEnum = Fuzzy.makeFuzzyFinder(nonModifierKeyCodes)
		local matches = findEnum(lastPart)

		return {
			prefix = prefix,
			parts = parts,
			matches = matches,
			lastPart = lastPart,
		}
	end,

	Validate = function(combo)
		if not combo then return false, "No value provided." end
		if combo.mode == "list" then return true end
		if not combo.matches or #combo.matches == 0 then
			return false, "Could not find a matching key."
		end
		return true
	end,

	Autocomplete = function(combo, arg)
		local isUnbind = arg and arg.Command and arg.Command.Name:lower() == "unbind"

		if not combo or not combo.matches then
			if isUnbind then
				local binds = arg.Command.CoCo.Registry:getStore("COCO_Binds")
				local results = {}
				for key, data in pairs(binds) do
					if type(data) == "table" and data.mode then
						results[#results + 1] = key
					end
				end
				return results
			end
			return {"list"}
		end
		if combo.mode == "list" then return {"list"} end

		local names = Fuzzy.getNames(combo.matches)
		local results = {}

		if isUnbind then
			local binds = arg.Command.CoCo.Registry:getStore("COCO_Binds")
			for _, name in ipairs(names) do
				local fullName = combo.prefix .. name
				if binds[fullName] then
					results[#results + 1] = fullName
				end
			end
			return results
		end

		for _, name in ipairs(names) do
			results[#results + 1] = combo.prefix .. name
		end
		if #combo.parts == 1 and (#combo.lastPart == 0 or string.lower(string.sub("list", 1, #combo.lastPart)) == string.lower(combo.lastPart)) then
			table.insert(results, 1, "list")
		end
		return results
	end,

	Parse = function(combo)
		if not combo then return nil end
		if combo.mode == "list" then return nil end
		if not combo.matches or #combo.matches == 0 then return nil end

		local key = combo.matches[1]
		local modifiers = {}
		local parts = combo.parts

		for i = 1, #parts - 1 do
			local part = parts[i]
			local modEnums = displayToModifiers[part]
			if modEnums then
				for _, e in ipairs(modEnums) do
					modifiers[e] = true
				end
			end
		end

		return {
			key = key,
			modifiers = modifiers,
			text = combo.prefix .. key.Name,
		}
	end,
}

return function(coco)
	coco:registerType("keycombo", keycomboType)
end
