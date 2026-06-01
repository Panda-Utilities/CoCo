--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting
local RunService = Services.RunService

local fullbrightLoop = nil
local savedLighting = {}

local function restoreLighting()
	if fullbrightLoop then
		fullbrightLoop:Disconnect()
		fullbrightLoop = nil
	end

	Lighting.Brightness = savedLighting.Brightness or 1
	Lighting.ClockTime = savedLighting.ClockTime or 14
	Lighting.FogEnd = savedLighting.FogEnd or 100000
	Lighting.GlobalShadows = savedLighting.GlobalShadows
	Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient or Color3.new(0, 0, 0)
end

return {
	Name = "fullbright";
	Aliases = {"fb", "fullbrightness"};
	InverseAliases = {"unfullbright"};
	Description = "Toggle fullbright (max brightness, no shadows).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not fullbrightLoop then return "Fullbright already disabled." end
			restoreLighting()
			return "Fullbright disabled."
		end

		if fullbrightLoop then
			restoreLighting()
			return "Fullbright disabled."
		end

		savedLighting.Brightness = Lighting.Brightness
		savedLighting.ClockTime = Lighting.ClockTime
		savedLighting.FogEnd = Lighting.FogEnd
		savedLighting.GlobalShadows = Lighting.GlobalShadows
		savedLighting.OutdoorAmbient = Lighting.OutdoorAmbient

		local function applyFullbright()
			Lighting.Brightness = 2
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			Lighting.GlobalShadows = false
			Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		end

		applyFullbright()
		fullbrightLoop = RunService.RenderStepped:Connect(applyFullbright)

		return "Fullbright enabled."
	end;
}
