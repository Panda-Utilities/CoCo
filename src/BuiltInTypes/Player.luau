--!strict
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")
local Selectors = require("../Shared/PlayerSelectors")
local Services = require("../Shared/Services")
local Players = Services.Players

local playerType = {
	Transform = function (text)
		local findPlayer = Fuzzy.makeFuzzyFinder(Players:GetPlayers())

		return findPlayer(text)
	end,

	Validate = function (players)
		return #players > 0, "No player with that name could be found."
	end,

	Autocomplete = function (players, argument)
		return Selectors.buildAutocomplete(Fuzzy.getNames(players), argument)
	end,

	Parse = function (players)
		return players[1]
	end,

	Default = function(player)
		return player.Name
	end,

	ArgumentOperatorAliases = Selectors.ArgumentOperatorAliases,
	Selectors = Selectors.Selectors,
}

return function (coco)
	coco:registerType("player", playerType)
	coco:registerType("players", TypeUtils.makeListableType(playerType, {
		Prefixes = "% teamPlayers",
	}))
end
