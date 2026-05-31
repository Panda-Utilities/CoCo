--!strict
local ScriptBloxShared = require("../Shared/ScriptBlox")

return function(coco)
	coco:registerType("scriptblox", {
		Transform = function(text: string): string
			return text
		end;

		Validate = function(value: any): (boolean, string?)
			return value ~= nil
		end;

		Parse = function(value: any): string
			return tostring(value)
		end;

		Autocomplete = function(currentValue: string, _arg: any): ({ any }, { IsPartial: boolean }?)
			if type(currentValue) ~= "string" or #currentValue < 2 then
				return {}, { IsPartial = true }
			end

			local ok, result = pcall(ScriptBloxShared.searchScripts, currentValue)
			if not ok or not result or not result.scripts then
				return {}, { IsPartial = false }
			end

			local queryLower = currentValue:lower()
			local scored = {}
			for _, script in ipairs(result.scripts) do
				local id = script._id or script.id
				if script.title and id then
					ScriptBloxShared.cacheScript(id, script)
					local titleLower = script.title:lower()
					local score = 0
					if titleLower == queryLower then
						score = 5
					elseif titleLower:find("^" .. queryLower:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")) then
						score = 4
					elseif titleLower:find("[^%w]" .. queryLower:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")) or titleLower:find("^" .. queryLower:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")) then
						score = 3
					elseif titleLower:find(queryLower:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"), 1, true) then
						score = 2
					end
					table.insert(scored, {
						script = script,
						id = id,
						score = score,
					})
				end
			end

			table.sort(scored, function(a, b)
				if a.score ~= b.score then
					return a.score > b.score
				end
				return (a.script.views or 0) > (b.script.views or 0)
			end)

			local suggestions = {}
			for _, entry in ipairs(scored) do
				local script = entry.script
				local views = ScriptBloxShared.formatNumber(script.views or 0)
				local keyStr = script.key and "Yes" or "No"
				local freeStr = (script.scriptType == "paid") and "No" or "Yes"
				local patchedStr = script.isPatched and "Yes" or "No"
				table.insert(suggestions, {
					title = entry.id,
					name = script.title,
					metaDesc = string.format("Views: %s  |  Key: %s  |  Free: %s  |  Patched: %s", views, keyStr, freeStr, patchedStr),
				})
			end

			return suggestions, { IsPartial = true }
		end;
	})
end
