--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

return {
	Name = "day";
	Aliases = {};
	Description = "Set lighting to daytime.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		Lighting.ClockTime = 12
		return "Time set to day (12:00)."
	end;
}
