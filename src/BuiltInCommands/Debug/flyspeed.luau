--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "flyspeed";
	Aliases = {"flysp"};
	Description = "Get or set fly speed. Usage: flyspeed <speed>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "Fly speed";
			Optional = true;
		};
	};

	ClientRun = function(context, speed)
		if speed then
			flyLib:setSpeed(speed)
			return ("Fly speed set to %d."):format(speed)
		end

		local current = flyLib.method == "cframe" and flyLib.cFlySpeed or flyLib.method == "vehicle" and flyLib.vehicleFlySpeed or flyLib.flySpeed
		return ("Current fly speed: %d (%s)."):format(current, flyLib.method)
	end;
}
