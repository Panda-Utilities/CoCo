--!strict
local Services = require("../../Shared/Services")
local TeleportService = game:GetService("TeleportService")

return {
	Name = "rejoin";
	Aliases = {"rj"};
	Description = "Rejoins the current server.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local player = Services.Players.LocalPlayer
		if not player then return "No local player." end
		TeleportService:Teleport(game.PlaceId, player)
		return "Rejoining..."
	end;
}
