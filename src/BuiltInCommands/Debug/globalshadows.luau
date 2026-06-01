--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

return {
	Name = "globalshadows";
	Aliases = {"gshadows"};
	InverseAliases = {"unglobalshadows", "nogshadows"};
	Description = "Toggle global shadows.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not Lighting.GlobalShadows then return "Global shadows already disabled." end
			Lighting.GlobalShadows = false
			return "Global shadows disabled."
		end

		Lighting.GlobalShadows = not Lighting.GlobalShadows
		return Lighting.GlobalShadows and "Global shadows enabled." or "Global shadows disabled."
	end;
}
