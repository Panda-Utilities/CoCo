--!strict
local Services = require("./Services")
local HttpService = Services.HttpService
local Config = require("../Config")

local httpRequest = request or http_request or syn and syn.request

local function urlEncode(str: string): string
	return str:gsub("([^%w%.%-%~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

local MAX_CACHE_ENTRIES = 100
local autocompleteCache: { [string]: any } = {}
local cacheOrder: { string } = {}

local ScriptBlox = {}

local function formatNumber(n: number): string
	if n >= 1000000 then
		return string.format("%.1fM", n / 1000000)
	elseif n >= 1000 then
		return string.format("%.1fK", n / 1000)
	end
	return tostring(n)
end
ScriptBlox.formatNumber = formatNumber

function ScriptBlox.buildBadgeStr(script: any): string
	local badges = {}
	if script.verified then table.insert(badges, "Verified") end
	if script.isPatched then table.insert(badges, "Patched") end
	if script.key then table.insert(badges, "Key") end
	if script.isUniversal then table.insert(badges, "Universal") end
	if #badges > 0 then
		return " [" .. table.concat(badges, "] [") .. "]"
	end
	return ""
end

function ScriptBlox.searchScripts(query: string): any
	local url =  "https://scriptblox.com/api/script/search?q=" .. urlEncode(query)
	if not httpRequest then
		return nil
	end
	local success, response = pcall(httpRequest, { Url = url, Method = "GET" })
	if not success then
		return nil, "request_failed"
	end
	if not response or response.StatusCode ~= 200 or not response.Body then
		return nil, "bad_response"
	end
	local ok, data = pcall(HttpService.JSONDecode, HttpService, response.Body)
	if ok and data and data.result then
		return data.result
	end
	return nil, "parse_failed"
end

function ScriptBlox.formatResult(scripts: { any }): string
	local lines = {}
	for i, script in ipairs(scripts) do
		local title = script.title or "Untitled"
		local gameName = script.game and script.game.name or "Unknown"
		local badgeStr = ScriptBlox.buildBadgeStr(script)
		local views = formatNumber(script.views or 0)
		local likes = formatNumber(script.likes or 0)
		table.insert(lines, string.format(" %d. %s", i, title))
		table.insert(lines, string.format("    Game: %s  |  Views: %s  |  Likes: %s%s", gameName, views, likes, badgeStr))
	end
	return table.concat(lines, "\n")
end

function ScriptBlox.runScript(context: any, script: any): string
	local title = script.title or "Untitled"
	local gameName = script.game and script.game.name or "Unknown"
	local badgeStr = ScriptBlox.buildBadgeStr(script)
	local views = formatNumber(script.views or 0)
	local likes = formatNumber(script.likes or 0)
	local description = script.description and script.description:sub(1, 200) or "No description"

	local preview = string.format("=== %s ===\nGame: %s\nViews: %s  |  Likes: %s%s\nDescription: %s",
		title, gameName, views, likes, badgeStr, description)
	context:reply(preview, Config.Colors.TextAccent)

	local scriptCode = script.script
	if not scriptCode or scriptCode == "" then
		return "Script '" .. title .. "' has no code."
	end

	local loadSuccess, loadError = pcall(function()
		loadstring(scriptCode)()
	end)
	if not loadSuccess then
		return "Failed to execute script: " .. tostring(loadError)
	end

	return "Running: " .. title
end

function ScriptBlox.cacheScript(id: string, script: any)
	if autocompleteCache[id] then
		autocompleteCache[id] = script
		return
	end
	autocompleteCache[id] = script
	table.insert(cacheOrder, id)
	if #cacheOrder > MAX_CACHE_ENTRIES then
		local oldestId = table.remove(cacheOrder, 1)
		autocompleteCache[oldestId] = nil
	end
end

function ScriptBlox.getCachedScript(id: string): any
	return autocompleteCache[id]
end

function ScriptBlox.findScriptByPartialId(partial: string): any
	for id, script in pairs(autocompleteCache) do
		if id:sub(1, #partial):lower() == partial:lower() then
			return script
		end
	end
	return nil
end

return ScriptBlox
