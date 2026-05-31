--!strict
local Services = require("../../Shared/Services")
local TeleportService = game:GetService("TeleportService")
local HttpService = Services.HttpService

return {
	Name = "serverhop";
	Aliases = {"shop", "hop"};
	Description = "Teleports you to another server of the same game.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local player = Services.Players.LocalPlayer
		if not player then return "No local player." end

		local placeId = game.PlaceId
		local currentJobId = game.JobId
		local universeId = game.GameId

		local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?limit=100", universeId)
		local success, response = pcall(function()
			return HttpService:GetAsync(url)
		end)

		if not success then
			return "Failed to fetch servers."
		end

		local data = HttpService:JSONDecode(response)
		if not data or not data.data then
			return "No server data found."
		end

		for _, server in ipairs(data.data) do
			if server.id ~= currentJobId and server.playing < server.maxPlayers then
				TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
				return "Server hopping..."
			end
		end

		return "No other servers available."
	end;
}
