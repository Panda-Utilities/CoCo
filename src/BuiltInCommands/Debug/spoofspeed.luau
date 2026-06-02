local Services = require("../../Shared/Services")
local RunService = Services.RunService

local spoofConnection = nil
local currentSpeed = 16

return {
	Name = "spoofspeed";
	Aliases = {"spoofws", "spoofwalkspeed"};
	Description = "Visually spoof walkspeed (overrides velocity each frame). Usage: spoofspeed <speed> | reset";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "Spoofed walkspeed (default: 50, use 16 or 'reset' to disable)";
			Default = 50;
			Optional = true;
		};
	};

	ClientRun = function(context, speed)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		if not speed or speed <= 0 or speed == 16 then
			if spoofConnection then
				spoofConnection:Disconnect()
				spoofConnection = nil
			end
			return "Spoof speed disabled."
		end

		if spoofConnection then
			spoofConnection:Disconnect()
		end

		currentSpeed = speed

		spoofConnection = RunService.RenderStepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if not hum or not hum.RootPart then return end
			local moveDir = hum.MoveDirection
			if moveDir.Magnitude > 0 then
				hum.RootPart.Velocity = moveDir * currentSpeed
			end
		end)

		return ("Spoof speed set to %d."):format(speed)
	end;
}
