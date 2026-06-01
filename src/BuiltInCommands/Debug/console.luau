local Services = require("../../Shared/Services")
local StarterGui = Services.StarterGui

return {
	Name = "console";
	Aliases = {};
	Description = "Toggle the Roblox developer console (F9).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local visible = StarterGui:GetCore("DevConsoleVisible")
		StarterGui:SetCore("DevConsoleVisible", not visible)
		return visible and "Console closed." or "Console opened."
	end;
}
