--!strict
local Services = require("../../Shared/Services")
local Players = Services.Players

return {
	Name = "delete";
	Aliases = {"del", "remove"};
	Description = "Delete the object you're looking at.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local mouse = Players.LocalPlayer:GetMouse()
		local target = mouse.Target
		if not target then return "No object targeted." end

		local name = target.Name
		target:Destroy()
		return ("Deleted %s."):format(name)
	end;
}
