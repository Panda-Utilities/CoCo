--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")
local Selectors = require("../Shared/PlayerSelectors")
local Services = require("../Shared/Services")
local Players = Services.Players

local nameCache = {}
local function getUserId(name)
	if nameCache[name] then
		return nameCache[name]
	elseif Players:FindFirstChild(name) then
		nameCache[name] = Players[name].UserId
		return Players[name].UserId
	else
		local ok, userid = pcall(Players.GetUserIdFromNameAsync, Players, name)

		if not ok then
			return nil, "Failed to get user ID for " .. name
		end

		nameCache[name] = userid
		return userid
	end
end

local playerIdType = {
	DisplayName = "Full Player Name",
	Prefixes = "# integer",

	Transform = function (text)
		local findPlayer = Fuzzy.makeFuzzyFinder(Players:GetPlayers())

		return text, findPlayer(text)
	end,

	ValidateOnce = function (text)
		return getUserId(text) ~= nil, "No player with that name could be found."
	end,

	Autocomplete = function (_, players, argument)
		return Selectors.buildAutocomplete(Fuzzy.getNames(players), argument)
	end,

	Parse = function (text)
		return getUserId(text)
	end,

	Default = function(player)
		return player.Name
	end,

	ArgumentOperatorAliases = Selectors.ArgumentOperatorAliases,
	Selectors = Selectors.Selectors,
}

return function (coco)
	coco:registerType("playerId", playerIdType)
	coco:registerType("playerIds", TypeUtils.makeListableType(playerIdType, {
		Prefixes = "# integers"
	}))
end
