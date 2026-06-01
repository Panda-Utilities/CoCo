--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local loopGotoConn = nil

return {
	Name = "loopgoto";
	Aliases = {};
	InverseAliases = {"unloopgoto", "noloopgoto"};
	Description = "Continuously teleport to a player every frame.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to follow";
			Optional = true;
		};
	};

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			if not loopGotoConn then return "Loop-goto already disabled." end
			loopGotoConn:Disconnect()
			loopGotoConn = nil
			return "Loop-goto stopped."
		end

		if loopGotoConn then
			loopGotoConn:Disconnect()
			loopGotoConn = nil
			return "Loop-goto stopped."
		end

		if not target then return "Usage: loopgoto <player>" end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		loopGotoConn = RunService.RenderStepped:Connect(function()
			local tChar = target.Character
			if not tChar then return end
			local tHum = tChar:FindFirstChildWhichIsA("Humanoid")
			if not tHum then return end
			local tRoot = tHum.RootPart
			if not tRoot then return end

			local char = context.Executor.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if not hum then return end
			local r = hum.RootPart
			if not r then return end

			r.CFrame = tRoot.CFrame * CFrame.new(0, 3, 0)
		end)

		return ("Now loop-goto %s."):format(target.Name)
	end;
}
