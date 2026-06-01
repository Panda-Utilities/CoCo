--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "cframefly";
	Aliases = {"cfly"};
	InverseAliases = {"uncframefly", "nocframefly"};
	Description = "Toggle CFrame-based fly (no physics).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not flyLib.flying or flyLib.method ~= "cframe" then
				return "CFrame fly already disabled."
			end
			flyLib:flyStop()
			flyLib.method = "velocity"
			return "CFrame fly disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		flyLib.character = character

		if flyLib.flying and flyLib.method == "cframe" then
			flyLib:flyStop()
			flyLib.method = "velocity"
			return "CFrame fly disabled."
		end

		flyLib:flyMethod("cframe")
		return "CFrame fly enabled."
	end;
}
