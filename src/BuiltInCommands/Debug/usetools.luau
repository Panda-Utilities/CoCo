local Services = require("../../Shared/Services")
local RunService = Services.RunService

local usetoolsConnection = nil

return {
	Name = "usetools";
	Aliases = {};
	InverseAliases = {"unusetools", "nousetools"};
	Description = "Toggle auto-use tools (rapidly activates equipped tools).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not usetoolsConnection then return "Auto-use tools already disabled." end
			usetoolsConnection:Disconnect()
			usetoolsConnection = nil
			return "Auto-use tools disabled."
		end

		if usetoolsConnection then
			usetoolsConnection:Disconnect()
			usetoolsConnection = nil
			return "Auto-use tools disabled."
		end

		usetoolsConnection = RunService.RenderStepped:Connect(function()
			local character = context.Executor.Character
			if not character then return end

			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") then
					pcall(function()
						child:Activate()
					end)
				end
			end
		end)

		return "Auto-use tools enabled."
	end;
}
