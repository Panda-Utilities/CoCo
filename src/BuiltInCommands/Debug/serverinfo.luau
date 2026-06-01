--!strict
local Services = require("../../Shared/Services")
local Players = Services.Players

return {
	Name = "serverinfo";
	Aliases = {"info", "sinfo"};
	Description = "Show server information (players, uptime, place, etc.).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local playerCount = #Players:GetPlayers()
		local placeId = game.PlaceId
		local jobId = game.JobId
		local gameId = game.GameId
		local fps = game:GetService("Stats"):FindFirstChild("PerformanceStats")
		local fpsVal = fps and math.floor(fps:GetValue()) or "N/A"

		local uptime = game:GetService("Stats"):FindFirstChild("Session")
		local uptimeVal = "N/A"
		if uptime then
			local u = uptime:GetValue()
			local hours = math.floor(u / 3600)
			local minutes = math.floor((u % 3600) / 60)
			local seconds = math.floor(u % 60)
			uptimeVal = ("%02d:%02d:%02d"):format(hours, minutes, seconds)
		end

		context:reply(("Players: %d | FPS: %s | Uptime: %s"):format(playerCount, fpsVal, uptimeVal))
		context:reply(("Place ID: %d | Game ID: %d"):format(placeId, gameId))
		context:reply(("Job ID: %s"):format(jobId))

		local creator = game.CreatorId and ("Creator ID: %d"):format(game.CreatorId) or ""
		if creator ~= "" then
			context:reply(creator)
		end

		return "Server info displayed."
	end;
}
