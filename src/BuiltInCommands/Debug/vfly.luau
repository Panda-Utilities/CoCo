--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "vfly";
	Aliases = {"vehiclefly"};
	InverseAliases = {"unvfly", "novehiclefly"};
	Description = "Toggle vehicle fly.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not flyLib.flying or flyLib.method ~= "vehicle" then
				return "Vehicle fly already disabled."
			end
			flyLib:flyStop()
			flyLib.method = "velocity"
			return "Vehicle fly disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		flyLib.character = character

		if flyLib.flying and flyLib.method == "vehicle" then
			flyLib:flyStop()
			flyLib.method = "velocity"
			return "Vehicle fly disabled."
		end

		flyLib:flyMethod("vehicle")
		return "Vehicle fly enabled."
	end;
}
