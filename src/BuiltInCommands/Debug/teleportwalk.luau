--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local tpwalkEnabled = false
local tpwalkCon = nil

return {
	Name = "teleportwalk";
	Aliases = {"tpwalk"};
	InverseAliases = {"unteleportwalk", "untpwalk"};
	Description = "Toggle teleport walk (rubberband as you move). Usage: teleportwalk [speed]";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "Teleport speed (default 1)";
			Optional = true;
		};
	};

	ClientRun = function(context, speed)
		if context:isInvertedCall() then
			if not tpwalkEnabled then return "Teleport walk already disabled." end
			if tpwalkCon then
				tpwalkCon:Disconnect()
				tpwalkCon = nil
			end
			tpwalkEnabled = false
			return "Teleport walk disabled."
		end

		if tpwalkEnabled then
			if tpwalkCon then
				tpwalkCon:Disconnect()
				tpwalkCon = nil
			end
			tpwalkEnabled = false
			return "Teleport walk disabled."
		end

		local character = context.Executor.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		tpwalkEnabled = true
		speed = speed or 1

		tpwalkCon = RunService.Heartbeat:Connect(function(delta)
			if not tpwalkEnabled then return end

			local char = context.Executor.Character
			local hum = char and char:FindFirstChildWhichIsA("Humanoid")
			if not (char and hum and hum.Parent) then
				tpwalkCon:Disconnect()
				tpwalkCon = nil
				tpwalkEnabled = false
				return
			end

			if hum.MoveDirection.Magnitude > 0 then
				char:TranslateBy(hum.MoveDirection * speed * delta * 10)
			end
		end)

		return ("Teleport walk enabled (speed: %s)."):format(tostring(speed))
	end;
}
