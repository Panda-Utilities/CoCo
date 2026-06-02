local Services = require("../../Shared/Services")
local RunService = Services.RunService

local OrgDestroyHeight = workspace.FallenPartsDestroyHeight
local antivoidConnection = nil

return {
	Name = "antivoid";
	Aliases = {};
	InverseAliases = {"unantivoid", "noantivoid"};
	Description = "Toggle void protection (launches you upward near kill height).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not antivoidConnection then return "Anti-void already disabled." end
			antivoidConnection:Disconnect()
			antivoidConnection = nil
			return "Anti-void disabled."
		end

		if antivoidConnection then
			antivoidConnection:Disconnect()
			antivoidConnection = nil
			return "Anti-void disabled."
		end

		antivoidConnection = RunService.Stepped:Connect(function()
			local character = context.Executor.Character
			if not character then return end

			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			if not humanoid then return end

			local rootPart = humanoid.RootPart
			if not rootPart then return end

			local y = rootPart.Position.Y
			if y <= OrgDestroyHeight + 25 then
				rootPart.Velocity = rootPart.Velocity + Vector3.new(0, 250, 0)
			end
		end)

		return "Anti-void enabled."
	end;
}
