--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local noclipConnection = nil

return {
	Name = "noclip";
	Aliases = {"nc"};
	InverseAliases = {"clip", "unnoclip"};
	Description = "Toggle noclip (walk through walls).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not noclipConnection then return "Noclip already disabled." end
			noclipConnection:Disconnect()
			noclipConnection = nil
			return "Noclip disabled."
		end

		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
			return "Noclip disabled."
		end

		noclipConnection = RunService.Stepped:Connect(function()
			local character = context.Executor.Character
			if not character then return end
			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = false
				end
			end
		end)

		return "Noclip enabled."
	end;
}
