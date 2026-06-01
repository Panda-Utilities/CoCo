--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

return {
	Name = "time";
	Aliases = {};
	Description = "Set local time of day. Usage: time <0-24|morning|day|noon|night|midnight>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "time";
			Description = "Time value (0-24) or preset";
		};
	};

	ClientRun = function(_, timeStr)
		local presets = {
			morning = 6;
			day = 12;
			noon = 12;
			night = 0;
			midnight = 0;
		}

		local t = presets[timeStr:lower()] or tonumber(timeStr)
		if not t then return "Invalid time. Use 0-24 or: morning, day, noon, night, midnight." end

		t = math.clamp(t, 0, 24)
		Lighting.ClockTime = t
		return ("Time set to %g:00."):format(t)
	end;
}
