--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting
local RunService = Services.RunService

local invisState = {
	running = false,
	character = nil,
	invisChar = nil,
	invisFix = nil,
	invisDied = nil,
	pos = nil,
	camPos = nil,
}

local function disableInvis(context)
	if invisState.invisFix then
		invisState.invisFix:Disconnect()
		invisState.invisFix = nil
	end
	if invisState.invisDied then
		invisState.invisDied:Disconnect()
		invisState.invisDied = nil
	end

	local char = invisState.character
	local invisChar = invisState.invisChar
	local player = context.Executor

	if char and invisChar then
		local root = invisChar:FindFirstChildWhichIsA("Humanoid")
		local rootPart = root and root.RootPart
		local cf = rootPart and rootPart.CFrame

		char.HumanoidRootPart.CFrame = cf or char.HumanoidRootPart.CFrame
		invisChar:Destroy()
		player.Character = char
		char.Parent = workspace
	end

	invisState.running = false
	invisState.character = nil
	invisState.invisChar = nil
	invisState.pos = nil
	invisState.camPos = nil
end

return {
	Name = "invisible";
	Aliases = {"invis"};
	InverseAliases = {"visible", "vis", "uninvisible"};
	Description = "Toggle invisible (clone to Lighting, make original transparent).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not invisState.running then return "Already visible." end
			disableInvis(context)
			return "Visible."
		end

		if invisState.running then
			disableInvis(context)
			return "Invisible disabled."
		end

		local player = context.Executor
		local char = player.Character
		if not char then return "You don't have a character." end

		char.Archivable = true
		local invisChar = char:Clone()
		invisChar.Parent = Lighting
		invisChar.Name = ""

		for _, v in ipairs(invisChar:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Name == "HumanoidRootPart" then
					v.Transparency = 1
				else
					v.Transparency = 0.5
				end
			end
		end

		local void = workspace.FallenPartsDestroyHeight
		local invisFix = RunService.Stepped:Connect(function()
			pcall(function()
				local root = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
				if not root then return end
				local rootPart = root.RootPart
				if not rootPart then return end
				local y = rootPart.Position.Y
				local isNeg = tostring(void):find("-")
				if (isNeg and y <= void) or (not isNeg and y >= void) then
					respawnFunc()
				end
			end)
		end)

		local function respawnFunc()
			if not invisState.running then return end
			if not invisState.character then return end

			local char = invisState.character
			local invisChar = invisState.invisChar
			local player = context.Executor

			if invisFix then
				invisFix:Disconnect()
				invisFix = nil
			end
			if invisDied then
				invisDied:Disconnect()
				invisDied = nil
			end

			char.Parent = workspace
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if hum then hum:Destroy() end
			player.Character = char
			char:BreakJoints()
			invisState.running = false
			invisState.character = nil
			invisState.invisChar = nil
		end

		local invisDied = invisChar:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
			respawnFunc()
		end)

		local camPos = workspace.CurrentCamera.CFrame
		local cf = char.HumanoidRootPart.CFrame

		char:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
		task.wait(0.2)

		char.Parent = Lighting
		invisChar.Parent = workspace
		invisChar:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = cf
		player.Character = invisChar

		local cam = workspace.CurrentCamera
		cam.CameraType = Enum.CameraType.Custom
		cam.CFrame = camPos

		local animate = player.Character:FindFirstChild("Animate")
		if animate then
			animate.Disabled = true
			task.wait()
			animate.Disabled = false
		end

		invisState.running = true
		invisState.character = char
		invisState.invisChar = invisChar
		invisState.invisFix = invisFix
		invisState.invisDied = invisDied

		return "Invisible enabled."
	end;
}
