--!strict

local FEATURES: { string } = {
	"box",
	"box fill",
	"name",
	"health bar",
	"health text",
	"distance",
	"tool text",
	"highlight",
}

type Esp = {
	Features: { [string]: boolean },
	ShowOn: { [string]: { string } },
	TeamColors: { [string]: { [string]: Color3 } },
	TeamTransparencies: { [string]: { [string]: number } },
	UseTeamColors: boolean,
}

local Visibility = {}

function Visibility.TeamColor(esp: Esp, entity: { teamState: string, teamColor: Color3? }, feature: string): Color3
	if esp.UseTeamColors and entity.teamColor then
		return entity.teamColor
	end
	local state = entity.teamState or "neutral"
	return esp.TeamColors[state] and esp.TeamColors[state][feature] or Color3.fromRGB(255, 255, 255)
end

function Visibility.TeamTransparency(esp: Esp, entity: { teamState: string }, feature: string): number
	local state = entity.teamState or "neutral"
	return esp.TeamTransparencies[state] and esp.TeamTransparencies[state][feature] or 0
end

function Visibility.IsFeatureVisible(esp: Esp, entity: { teamState: string }, feature: string): boolean
	if not esp.Features[feature] then return false end
	local showOn = esp.ShowOn[feature]
	if not showOn or #showOn == 0 then return false end

	local state = entity.teamState or "neutral"
	local matched = false
	for _, allowed in showOn do
		if allowed == state then matched = true; break end
	end
	if not matched then return false end

	if feature ~= "highlight" then
		local trans = Visibility.TeamTransparency(esp, entity, feature)
		return trans < 1
	end
	return true
end

function Visibility.ComputeFeatures(esp: Esp, entity: { teamState: string }): { [string]: boolean }
	local features: { [string]: boolean } = {}
	local hasAny = false
	for _, feature in FEATURES do
		local enabled = Visibility.IsFeatureVisible(esp, entity, feature)
		features[feature] = enabled
		hasAny = hasAny or enabled
	end
	features["any"] = hasAny
	features["needs2D"] = features["box"]
		or features["box fill"]
		or features["name"]
		or features["health bar"]
		or features["health text"]
		or features["distance"]
		or features["tool text"]
	return features
end

function Visibility.HasAnyEnabledFeature(esp: Esp): boolean
	for _, enabled in esp.Features do
		if enabled then return true end
	end
	return false
end

return Visibility
