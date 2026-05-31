--!strict
local Players = require("./Services").Players

local function union(a: { [string]: boolean }, b: { [string]: boolean }): { [string]: boolean }
	for name in pairs(b) do
		a[name] = true
	end
	return a
end

local function intersection(a: { [string]: boolean }, b: { [string]: boolean }): { [string]: boolean }
	local result: { [string]: boolean } = {}
	for name in pairs(a) do
		if b[name] then
			result[name] = true
		end
	end
	return result
end

local function difference(a: { [string]: boolean }, b: { [string]: boolean }): { [string]: boolean }
	local result: { [string]: boolean } = {}
	for name in pairs(a) do
		result[name] = true
	end
	for name in pairs(b) do
		result[name] = nil
	end
	return result
end

local function complement(set: { [string]: boolean }): { [string]: boolean }
	local result: { [string]: boolean } = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if not set[player.Name] then
			result[player.Name] = true
		end
	end
	return result
end

return {
	union = union,
	intersection = intersection,
	difference = difference,
	complement = complement,
}
