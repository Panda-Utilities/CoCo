local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

return {
	Name = "night";
	Aliases = {};
	Description = "Set lighting to nighttime.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		Lighting.ClockTime = 0
		return "Time set to night (0:00)."
	end;
}
