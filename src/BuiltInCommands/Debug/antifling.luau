local Services = require("../../Shared/Services")
local RunService = Services.RunService

local antiflingConnection = nil

return {
	Name = "antifling";
	Aliases = {};
	InverseAliases = {"unantifling", "noantifling"};
	Description = "Toggle anti-fling (prevent being flung by other players).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not antiflingConnection then return "Anti-fling already disabled." end
			antiflingConnection:Disconnect()
			antiflingConnection = nil
			return "Anti-fling disabled."
		end

		if antiflingConnection then
			antiflingConnection:Disconnect()
			antiflingConnection = nil
			return "Anti-fling disabled."
		end

		antiflingConnection = RunService.Stepped:Connect(function()
			local character = context.Executor.Character
			if not character then return end
			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.AssemblyLinearVelocity = Vector3.new()
					descendant.AssemblyAngularVelocity = Vector3.new()
				end
			end
		end)

		return "Anti-fling enabled."
	end;
}
