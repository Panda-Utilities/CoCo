local Services = require("../../Shared/Services")
local Players = Services.Players

return {
	Name = "inspect";
	Aliases = {};
	Description = "Inspect properties of the object you're looking at.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local mouse = Players.LocalPlayer:GetMouse()
		local target = mouse.Target
		if not target then return "No object targeted." end

		local props = {
			Name = target.Name;
			Class = target.ClassName;
			Parent = target.Parent and target.Parent:GetFullName() or "nil";
		}

		return ("Name: %s | Class: %s | Parent: %s"):format(props.Name, props.Class, props.Parent)
	end;
}
