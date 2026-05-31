--!strict
local flyLib = require("../../Shared/FlyLib")

return {
	Name = "fly";
	Aliases = {"f"};
	Description = "Fly with WASD (and QE).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "flymethod";
			Name = "action";
			Description = "velocity, speed, vehicle, cframe, or a number";
			Optional = true;
		};
		{
			Type = "number";
			Name = "speed";
			Description = "Fly speed (used with method)";
			Optional = true;
		};
		{
			Type = "flykeybinds";
			Name = "keybinds";
			Description = "default or qe";
			Optional = true;
		};
	};

	ClientRun = function(context, action, speed, keybinds)
		local character = context.Executor.Character

		if not character then
			return "You don't have a character."
		end

		flyLib.character = character

		if not action then
			flyLib:flyToggle()
			return flyLib.flying and "Fly enabled." or "Fly disabled."
		end

		if action == "velocity" or action == "vehicle" or action == "cframe" then
			flyLib:flyMethod(action)

			if speed then
				flyLib:setSpeed(speed)
			end

			if keybinds then
				flyLib.keyBinds = keybinds
			end

			return ("Method: %s. Speed: %s. Keybinds: %s."):format(action, speed or "current", flyLib.keyBinds)
		end

		if action == "speed" then
			if speed then
				flyLib:setSpeed(speed)

				if not flyLib.flying then
					flyLib:fly()
				end

				return ("Speed set to %d."):format(speed)
			end

			return ("Current speed: %d."):format(flyLib.speed)
		end

		if ({ default = true, qe = true })[action] then
			flyLib.keyBinds = action
			return ("Keybinds: %s."):format(action)
		end

		local speedNum = tonumber(action)

		if speedNum then
			flyLib:setSpeed(speedNum)

			if not flyLib.flying then
				flyLib:fly()
			end

			return ("Speed set to %d."):format(speedNum)
		end

		return ("Unknown option %q."):format(action)
	end;
}
