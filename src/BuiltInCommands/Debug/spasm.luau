--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local spasmConnection = nil
local spasmDied = nil

local function stopSpasm()
	if spasmConnection then
		spasmConnection:Disconnect()
		spasmConnection = nil
	end
	if spasmDied then
		spasmDied:Disconnect()
		spasmDied = nil
	end
end

return {
	Name = "spasm";
	Aliases = {};
	InverseAliases = {"unspasm", "nospasm"};
	Description = "Toggle character spasm.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not spasmConnection then return "Spasm already disabled." end
			stopSpasm()
			return "Spasm disabled."
		end

		if spasmConnection then
			stopSpasm()
			return "Spasm disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		spasmConnection = RunService.Stepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			for _, part in ipairs(char:GetChildren()) do
				if part:IsA("BasePart") then
					part.Velocity = Vector3.new(
						math.random(-500, 500),
						math.random(-500, 500),
						math.random(-500, 500)
					)
					part.RotVelocity = Vector3.new(
						math.random(-500, 500),
						math.random(-500, 500),
						math.random(-500, 500)
					)
				end
			end
		end)

		spasmDied = humanoid.Died:Connect(function()
			if spasmConnection then
				spasmConnection:Disconnect()
				spasmConnection = nil
			end
			if spasmDied then
				spasmDied:Disconnect()
				spasmDied = nil
			end
		end)

		return "Spasm enabled."
	end;
}
