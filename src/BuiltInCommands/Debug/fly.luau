--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "fly";
	Aliases = {"f"};
	InverseAliases = {"unfly", "nofly"};
	Description = "Toggle fly with WASD (and QE).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not flyLib.flying or flyLib.method ~= "velocity" then
				return "Fly already disabled."
			end
			flyLib:flyStop()
			return "Fly disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		flyLib.character = character

		if flyLib.flying and flyLib.method == "velocity" then
			flyLib:flyStop()
			return "Fly disabled."
		end

		flyLib:flyMethod("velocity")
		return "Fly enabled."
	end;
}
