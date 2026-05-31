--!strict
local ScriptBlox = require("../../Shared/ScriptBlox")
local Config = require("../../Config")

return {
	Name = "scriptblox";
	Aliases = { "sb", "sblox" };
	Description = "Search and run scripts from ScriptBlox. Autocomplete shows matching scripts as you type.";
	Group = "DefaultUtil";
	Args = {
		{
			Type = "scriptblox";
			Name = "query";
			Description = "Search query or script name";
		};
	};

	ClientRun = function(context, query)
		local trimmed = query and query:match("^%s*(.-)%s*$") or query
		if not trimmed or trimmed == "" then
			return "Usage: scriptblox <search query>"
		end

		local cachedScript = ScriptBlox.getCachedScript(trimmed)
		if cachedScript then
			return ScriptBlox.runScript(context, cachedScript)
		end

		local searchQuery = trimmed
		local prefix, lastWord = trimmed:match("^(.*)%s([^%s]+)$")
		if prefix and lastWord and lastWord:match("^[0-9a-fA-F]{8,}$") then
			local found = ScriptBlox.findScriptByPartialId(lastWord)
			if found then
				return ScriptBlox.runScript(context, found)
			end
			local idOk, idResult = pcall(ScriptBlox.searchScripts, lastWord)
			if idOk and idResult and idResult.scripts and #idResult.scripts > 0 then
				local idMatch = idResult.scripts[1]
				ScriptBlox.cacheScript(lastWord, idMatch)
				return ScriptBlox.runScript(context, idMatch)
			end
			searchQuery = prefix
		end

		local ok, result, errType = pcall(ScriptBlox.searchScripts, searchQuery)
		if not ok then
			return string.format("ScriptBlox search threw an error for %q: %s", searchQuery, tostring(result))
		end
		if not result then
			local reason = errType == "bad_response" and "bad response" or errType == "parse_failed" and "failed to parse response" or "request failed"
			return string.format("ScriptBlox API error for %q (%s).", searchQuery, reason)
		end

		local scripts = result.scripts
		if not scripts or #scripts == 0 then
			return string.format("No scripts found matching %q.", searchQuery)
		end

		for _, script in ipairs(scripts) do
			if script.title and script.title:lower() == searchQuery:lower() then
				return ScriptBlox.runScript(context, script)
			end
		end

		if #scripts == 1 then
			return ScriptBlox.runScript(context, scripts[1])
		end

		context:reply(string.format("=== ScriptBlox Results (%d found) ===", #scripts), Config.Colors.TextAccent)
		context:reply(ScriptBlox.formatResult(scripts), Config.Colors.TextPrimary)
		context:reply("Tip: Refine your query to get a single result and it will run automatically.", Config.Colors.TextSecondary)
		return string.format("Showing %d results for %q. Refine your search.", #scripts, searchQuery)
	end;
}
