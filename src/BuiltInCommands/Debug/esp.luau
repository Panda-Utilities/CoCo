--!strict

local FEATURE_NAMES: { string } = {
	"box fill",
	"health bar",
	"health text",
	"tool text",
	"box",
	"name",
	"distance",
	"highlight",
}

local SUBCOMMANDS: { string } = {
	"on",
	"off",
	"feature",
	"useteamcolors",
	"maxdistance",
	"teamcheck",
	"showenemies",
	"showfriendlies",
	"showneutral",
	"showlocal",
	"list",
	"status",
	"reset",
}

local BOOLEAN_TOGGLE_SUBCOMMANDS: { string } = {
	"useteamcolors",
	"teamcheck",
	"showenemies",
	"showfriendlies",
	"showneutral",
	"showlocal",
}

local function filterByPrefix(typed: string, items: { string }): { string }
	local results: { string } = {}
	local lower = typed:lower()
	for _, item in items do
		if item:lower():find(lower, 1, true) then
			if item:lower() == lower then
				table.insert(results, 1, item)
			else
				results[#results + 1] = item
			end
		end
	end
	return results
end

local function parseFeatureName(parts: { string }, startIndex: number): (string?, number)
	for _, fname in FEATURE_NAMES do
		local words = {}
		for w in fname:gmatch("%S+") do
			words[#words + 1] = w:lower()
		end
		if startIndex + #words - 1 <= #parts then
			local matched = true
			for j = 1, #words do
				if parts[startIndex + j - 1]:lower() ~= words[j] then
					matched = false
					break
				end
			end
			if matched then
				return fname, startIndex + #words
			end
		end
	end
	return nil, startIndex
end

local function splitValue(value: string): { string }
	local parts: { string } = {}
	for part in value:gmatch("%S+") do
		parts[#parts + 1] = part
	end
	return parts
end

local BOOLEAN_WORDS = {
	["on"] = true; ["off"] = false;
	["true"] = true; ["false"] = false;
	["yes"] = true; ["no"] = false;
	["enable"] = true; ["enabled"] = true;
	["disable"] = false; ["disabled"] = false;
	["1"] = true; ["0"] = false;
}

local function parseBool(text: string): boolean?
	return BOOLEAN_WORDS[text:lower()]
end

local function getSettingsList(esp: any): string
	local lines: { string } = {}
	table.insert(lines, string.format("Enabled: %s", esp.Enabled and "Yes" or "No"))
	table.insert(lines, string.format("Use Team Colors: %s", esp.UseTeamColors and "Yes" or "No"))
	table.insert(lines, string.format("Team Check: %s", esp.TeamCheck and "Yes" or "No"))
	table.insert(lines, string.format("Max Distance: %d", esp.MaxDistance))
	table.insert(lines, string.format("Show Enemies: %s", esp.ShowEnemies and "Yes" or "No"))
	table.insert(lines, string.format("Show Friendlies: %s", esp.ShowFriendlies and "Yes" or "No"))
	table.insert(lines, string.format("Show Neutral: %s", esp.ShowNeutral and "Yes" or "No"))
	table.insert(lines, string.format("Show Local: %s", esp.ShowLocal and "Yes" or "No"))
	table.insert(lines, "")
	table.insert(lines, "Features:")
	for _, fname in FEATURE_NAMES do
		local enabled = esp.Features[fname] or false
		table.insert(lines, string.format("  %s: %s", fname, enabled and "Yes" or "No"))
	end
	table.insert(lines, "")
	table.insert(lines, "Usage: esp <subcommand> [args]")
	table.insert(lines, "Subcommands: on, off, toggle, feature, useteamcolors, maxdistance,")
	table.insert(lines, "  teamcheck, showenemies, showfriendlies, showneutral, showlocal, list, status, reset")
	return table.concat(lines, "\n")
end

return {
	Name = "esp";
	Aliases = {"visuals"};
	Description = "Configure ESP overlay. Use 'esp list' for details.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = {
				DisplayName = "subcommand";
				Transform = function(text: string): string
					return text:lower()
				end;
				Validate = function(value: string): (boolean, string?)
					return true
				end;
				Autocomplete = function(typed: string): { string }
					return filterByPrefix(typed, SUBCOMMANDS)
				end;
				Parse = function(value: string): string
					return value
				end;
			};
			Name = "action";
			Description = "Subcommand: on, off, feature, useteamcolors, etc.";
			Optional = true;
		};
		{
			Type = {
				DisplayName = "value";
				Transform = function(text: string): string
					return text
				end;
				Validate = function(value: string): (boolean, string?)
					return true
				end;
				Autocomplete = function(typed: string, arg: any): { string }
					if not arg or not arg.Command then return {} end
					local rawArgs = arg.Command.RawArguments
					local action = rawArgs and rawArgs[1] and rawArgs[1]:lower() or ""

					local candidates: { string } = {}
					local found = false
					for _, btc in BOOLEAN_TOGGLE_SUBCOMMANDS do
						if action == btc then
							candidates = {"on", "off"}
							found = true
							break
						end
					end
					if found then
						return filterByPrefix(typed, candidates)
					end

					if action == "feature" then
						for _, fname in FEATURE_NAMES do
							candidates[#candidates + 1] = fname
						end
						candidates[#candidates + 1] = "on"
						candidates[#candidates + 1] = "off"
						return filterByPrefix(typed, candidates)
					end

					return {}
				end;
				Parse = function(value: string): string
					return value
				end;
			};
			Name = "value";
			Description = "Additional arguments for the subcommand";
			Optional = true;
			Default = "";
		};
	};

	ClientRun = function(context, action: string?, value: string?)
		local esp = context.CoCo.ESP
		if not esp then return "ESP not loaded." end

		if not action then
			esp.Enabled = not esp.Enabled
			esp.Changed:Fire()
			return "ESP " .. (esp.Enabled and "enabled" or "disabled") .. "."
		end

		local a = action:lower()
		local parts = splitValue(value or "")

		if a == "on" then
			esp.Enabled = true
			esp.Changed:Fire()
			return "ESP enabled."
		elseif a == "off" then
			esp.Enabled = false
			esp.Changed:Fire()
			return "ESP disabled."
		elseif a == "feature" then
			if #parts == 0 then
				local enabled = {}
				local disabled = {}
				for _, fname in FEATURE_NAMES do
					if esp.Features[fname] then
						enabled[#enabled + 1] = fname
					else
						disabled[#disabled + 1] = fname
					end
				end
				table.sort(enabled)
				table.sort(disabled)
				return string.format("Enabled: %s\nDisabled: %s",
					#enabled > 0 and table.concat(enabled, ", ") or "none",
					#disabled > 0 and table.concat(disabled, ", ") or "none")
			end
			local featureName, nextIdx = parseFeatureName(parts, 1)
			if not featureName then
				return string.format("Unknown feature. Valid: %s", table.concat(FEATURE_NAMES, ", "))
			end
			if nextIdx <= #parts then
				local newState = parseBool(parts[nextIdx])
				if newState ~= nil then
					esp.Features[featureName] = newState
				else
					return string.format("Invalid state %q. Use on or off.", parts[nextIdx])
				end
			else
				esp.Features[featureName] = not esp.Features[featureName]
			end
			esp.Changed:Fire()
			return string.format("ESP %s: %s", featureName, esp.Features[featureName] and "enabled" or "disabled")
		elseif a == "useteamcolors" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.UseTeamColors = newState
				else
					return "Usage: esp useteamcolors [on|off]"
				end
			else
				esp.UseTeamColors = not esp.UseTeamColors
			end
			esp.Changed:Fire()
			return string.format("ESP team colors: %s", esp.UseTeamColors and "enabled" or "disabled")
		elseif a == "maxdistance" then
			if #parts == 0 then
				return string.format("Max distance: %d", esp.MaxDistance)
			end
			local n = tonumber(parts[1])
			if not n or n < 0 then
				return "Usage: esp maxdistance <number>"
			end
			esp.MaxDistance = n
			esp.Changed:Fire()
			return string.format("ESP max distance set to %d", n)
		elseif a == "teamcheck" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.TeamCheck = newState
				else
					return "Usage: esp teamcheck [on|off]"
				end
			else
				esp.TeamCheck = not esp.TeamCheck
			end
			esp.Changed:Fire()
			return string.format("ESP team check: %s", esp.TeamCheck and "on" or "off")
		elseif a == "showenemies" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.ShowEnemies = newState
				else
					return "Usage: esp showenemies [on|off]"
				end
			else
				esp.ShowEnemies = not esp.ShowEnemies
			end
			esp.Changed:Fire()
			return string.format("ESP show enemies: %s", esp.ShowEnemies and "on" or "off")
		elseif a == "showfriendlies" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.ShowFriendlies = newState
				else
					return "Usage: esp showfriendlies [on|off]"
				end
			else
				esp.ShowFriendlies = not esp.ShowFriendlies
			end
			esp.Changed:Fire()
			return string.format("ESP show friendlies: %s", esp.ShowFriendlies and "on" or "off")
		elseif a == "showneutral" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.ShowNeutral = newState
				else
					return "Usage: esp showneutral [on|off]"
				end
			else
				esp.ShowNeutral = not esp.ShowNeutral
			end
			esp.Changed:Fire()
			return string.format("ESP show neutral: %s", esp.ShowNeutral and "on" or "off")
		elseif a == "showlocal" then
			if #parts > 0 then
				local newState = parseBool(parts[1])
				if newState ~= nil then
					esp.ShowLocal = newState
				else
					return "Usage: esp showlocal [on|off]"
				end
			else
				esp.ShowLocal = not esp.ShowLocal
			end
			esp.Changed:Fire()
			return string.format("ESP show local: %s", esp.ShowLocal and "on" or "off")
		elseif a == "list" or a == "status" then
			return getSettingsList(esp)
		elseif a == "reset" then
			local EspConfig = require("../../Visuals/Config")
			local defaults = EspConfig.create()
			for k, v in pairs(defaults) do
				if k ~= "Changed" then
					esp[k] = v
				end
			end
			esp.Changed:Fire()
			return "ESP settings reset to defaults."
		else
			return string.format("Unknown subcommand %q. Type 'esp list' for help.", a)
		end
	end;
}
