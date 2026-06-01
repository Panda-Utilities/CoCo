local Services = require("../../Shared/Services")
local RunService = Services.RunService

local noclipConnection = nil
local flinging = false
local flingBody = nil
local flingDied = nil

local function disableFling(context)
	flinging = false

	if flingDied then
		flingDied:Disconnect()
		flingDied = nil
	end

	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end

	if flingBody then
		flingBody:Destroy()
		flingBody = nil
	end

	local character = context.Executor.Character
	if character then
		for _, child in ipairs(character:GetDescendants()) do
			if child:IsA("BasePart") then
				child.CanCollide = true
				child.Massless = false
				child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
			end
		end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			local rootPart = humanoid.RootPart
			if rootPart then
				for _, v in ipairs(rootPart:GetChildren()) do
					if v.ClassName == "BodyAngularVelocity" then
						v:Destroy()
					end
				end
			end
		end
	end
end

return {
	Name = "fling";
	Aliases = {};
	InverseAliases = {"unfling", "nofling"};
	Description = "Toggle fling (spins you into others at high speed).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not flinging then return "Fling already disabled." end
			disableFling(context)
			return "Fling disabled."
		end

		if flinging then
			disableFling(context)
			return "Fling disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local rootPart = humanoid.RootPart
		if not rootPart then return "No root part found." end

		for _, child in ipairs(character:GetDescendants()) do
			if child:IsA("BasePart") then
				child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
			end
		end

		noclipConnection = RunService.Stepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			for _, d in ipairs(char:GetDescendants()) do
				if d:IsA("BasePart") then
					d.CanCollide = false
				end
			end
		end)

		task.wait(0.1)

		flingBody = Instance.new("BodyAngularVelocity")
		flingBody.Name = "FlingVelocity"
		flingBody.Parent = rootPart
		flingBody.AngularVelocity = Vector3.new(0, 99999, 0)
		flingBody.MaxTorque = Vector3.new(0, math.huge, 0)
		flingBody.P = math.huge

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
				v.Massless = true
				v.Velocity = Vector3.new(0, 0, 0)
			end
		end

		flinging = true

		flingDied = humanoid.Died:Connect(function()
			flinging = false
			if flingBody then
				flingBody:Destroy()
				flingBody = nil
			end
			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end
			if flingDied then
				flingDied:Disconnect()
				flingDied = nil
			end
		end)

		task.spawn(function()
			while flinging do
				if flingBody then
					flingBody.AngularVelocity = Vector3.new(0, 99999, 0)
				end
				task.wait(0.2)
				if flingBody then
					flingBody.AngularVelocity = Vector3.new(0, 0, 0)
				end
				task.wait(0.1)
			end
		end)

		return "Fling enabled."
	end;
}
