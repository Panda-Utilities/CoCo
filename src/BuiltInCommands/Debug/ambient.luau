local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

return {
	Name = "ambient";
	Aliases = {};
	Description = "Set ambient lighting color (R G B).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "color3";
			Name = "color";
			Description = "RGB color values (0-255)";
		};
	};

	ClientRun = function(_, color)
		if not color then return "Usage: ambient <R> <G> <B>" end

		local saved = Lighting.OutdoorAmbient
		Lighting.OutdoorAmbient = color
		return ("Ambient set to RGB(%d, %d, %d)."):format(
			color.R * 255, color.G * 255, color.B * 255
		)
	end;
}
