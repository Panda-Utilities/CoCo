local Services = require("../../Shared/Services")
local RunService = Services.RunService

local walkToConn = nil

return {
	Name = "walkto";
	Aliases = {"follow"};
	InverseAliases = {"unwalkto", "unfollow", "nowalkto"};
	Description = "Auto-walk toward a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to walk toward";
			Optional = true;
		};
	};

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			if not walkToConn then return "Walk-to already disabled." end
			walkToConn:Disconnect()
			walkToConn = nil
			return "Walk-to stopped."
		end

		if walkToConn then
			walkToConn:Disconnect()
			walkToConn = nil
			return "Walk-to stopped."
		end

		if not target then return "Usage: walkto <player>" end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		walkToConn = RunService.RenderStepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if not hum then return end
			local tChar = target.Character
			if not tChar then return end
			local tHum = tChar:FindFirstChildWhichIsA("Humanoid")
			if not tHum then return end
			local tRoot = tHum.RootPart
			if not tRoot then return end

			hum:MoveTo(tRoot.Position)
		end)

		return ("Now walking to %s."):format(target.Name)
	end;
}
