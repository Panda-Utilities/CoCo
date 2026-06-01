--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local orbitEnabled = false
local orbitConns = {}

local function stopOrbit()
	for _, con in ipairs(orbitConns) do
		con:Disconnect()
	end
	orbitConns = {}
	orbitEnabled = false
end

return {
	Name = "orbit";
	Aliases = {};
	InverseAliases = {"unorbit"};
	Description = "Orbit around a target player. Usage: orbit <player> [speed] [distance]";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to orbit around";
			Optional = true;
		};
		{
			Type = "number";
			Name = "speed";
			Description = "Orbit speed (default 0.2)";
			Optional = true;
		};
		{
			Type = "number";
			Name = "distance";
			Description = "Orbit distance (default 6)";
			Optional = true;
		};
	};

	ClientRun = function(context, target, speed, distance)
		if context:isInvertedCall() then
			if not orbitEnabled then return "Orbit already disabled." end
			stopOrbit()
			return "Orbit stopped."
		end

		if orbitEnabled then
			stopOrbit()
			return "Orbit stopped."
		end

		if not target then return "Specify a player to orbit around." end

		local character = context.Executor.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local root = humanoid and humanoid.RootPart
		if not root then return "You don't have a character with a root part." end

		local targetChar = target.Character
		local targetRoot = targetChar and targetChar:FindFirstChildWhichIsA("Humanoid") and targetChar:FindFirstChildWhichIsA("Humanoid").RootPart
		if not targetRoot then return "Target has no character or root part." end

		orbitEnabled = true
		speed = speed or 0.2
		distance = distance or 6
		local rotation = 0

		local con1 = RunService.Heartbeat:Connect(function()
			if not orbitEnabled then return end
			local r = humanoid and humanoid.RootPart
			local tr = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid") and target.Character:FindFirstChildWhichIsA("Humanoid").RootPart
			if not r or not tr then
				for _, c in ipairs(orbitConns) do
					c:Disconnect()
				end
				orbitConns = {}
				orbitEnabled = false
				return
			end
			rotation = rotation + speed
			r.CFrame = CFrame.new(tr.Position) * CFrame.Angles(0, math.rad(rotation), 0) * CFrame.new(distance, 0, 0)
		end)

		local con2 = RunService.RenderStepped:Connect(function()
			if not orbitEnabled then return end
			local r = humanoid and humanoid.RootPart
			local tr = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid") and target.Character:FindFirstChildWhichIsA("Humanoid").RootPart
			if not r or not tr then return end
			r.CFrame = CFrame.new(r.Position, tr.Position)
		end)

		local con3 = humanoid.Died:Connect(function()
			for _, c in ipairs(orbitConns) do
				c:Disconnect()
			end
			orbitConns = {}
			orbitEnabled = false
		end)

		local con4 = humanoid.Seated:Connect(function(value)
			if value then
				for _, c in ipairs(orbitConns) do
					c:Disconnect()
				end
				orbitConns = {}
				orbitEnabled = false
			end
		end)

		orbitConns = { con1, con2, con3, con4 }

		return ("Orbiting %s."):format(target.Name)
	end;
}
