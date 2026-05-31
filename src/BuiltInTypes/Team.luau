--!strict
local Services = require("../Shared/Services")
local Teams = Services.Teams
local Fuzzy = require("../Shared/Fuzzy")
local TypeUtils = require("../Shared/TypeUtils")

local teamType = {
	Transform = function (text)
		local findTeam = Fuzzy.makeFuzzyFinder(Teams:GetTeams())

		return findTeam(text)
	end,

	Validate = function (teams)
		return #teams > 0, "No team with that name could be found."
	end,

	Autocomplete = function (teams)
		return Fuzzy.getNames(teams)
	end,

	Parse = function (teams)
		return teams[1]
	end,
}

local teamPlayersType = {
	Listable = true,
	Transform = teamType.Transform,
	Validate = teamType.Validate,
	Autocomplete = teamType.Autocomplete,

	Parse = function (teams)
		return teams[1]:GetPlayers()
	end,
}

local teamColorType = {
	Transform = teamType.Transform,
	Validate = teamType.Validate,
	Autocomplete = teamType.Autocomplete,

	Parse = function (teams)
		return teams[1].TeamColor
	end,
}

return function (coco)
	coco:registerType("team", teamType)
	coco:registerType("teams", TypeUtils.makeListableType(teamType))

	coco:registerType("teamPlayers", teamPlayersType)

	coco:registerType("teamColor", teamColorType)
	coco:registerType("teamColors", TypeUtils.makeListableType(teamColorType))
end