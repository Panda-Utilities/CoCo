--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "qefly";
	Aliases = {"flyqe"};
	InverseAliases = {"unqefly", "noqefly"};
	Description = "Toggle QE up/down fly controls.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if flyLib.keyBinds ~= "qe" then return "QE fly already disabled." end
			flyLib.keyBinds = "default"
			return "QE fly disabled."
		end

		flyLib.keyBinds = flyLib.keyBinds == "qe" and "default" or "qe"
		return flyLib.keyBinds == "qe" and "QE fly enabled." or "QE fly disabled."
	end;
}
