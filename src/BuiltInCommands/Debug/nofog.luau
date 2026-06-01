--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

local savedFogEnd = nil

return {
	Name = "nofog";
	Aliases = {};
	InverseAliases = {"fog"};
	Description = "Toggle removing all fog.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not savedFogEnd then return "Fog already restored." end
			Lighting.FogEnd = savedFogEnd
			savedFogEnd = nil
			return "Fog restored."
		end

		if savedFogEnd then
			Lighting.FogEnd = savedFogEnd
			savedFogEnd = nil
			return "Fog restored."
		end

		savedFogEnd = Lighting.FogEnd
		Lighting.FogEnd = math.huge
		return "Fog removed."
	end;
}
