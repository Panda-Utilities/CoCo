--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local stareTarget = nil
local stareConnection = nil

local function stopStare()
	if stareConnection then
		stareConnection:Disconnect()
		stareConnection = nil
	end
	stareTarget = nil
end

return {
	Name = "stare";
	Aliases = {"stareat"};
	InverseAliases = {"unstare", "nostare"};
	Description = "Toggle making your head face a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to stare at";
			Optional = true;
		};
	};

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			if not stareConnection then return "Not staring at anyone." end
			stopStare()
			return "Stare disabled."
		end

		if stareConnection or not target then
			stopStare()
			return "Stare disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local head = character:FindFirstChild("Head")
		if not head then return "No head found." end

		stareTarget = target

		stareConnection = RunService.RenderStepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			local h = char:FindFirstChild("Head")
			if not h then return end
			local tChar = stareTarget.Character
			if not tChar then return end
			local tHead = tChar:FindFirstChild("Head")
			if not tHead then return end
			h.CFrame = CFrame.lookAt(h.Position, tHead.Position)
		end)

		return ("Now staring at %s."):format(target.Name)
	end;
}
