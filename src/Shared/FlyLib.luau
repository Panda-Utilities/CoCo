--!strict
local Services = require("../Shared/Services")

local control = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
local lastControl = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
local speed = 0
local bodyGyro
local bodyVelocity
local inputBeganConn
local inputEndedConn
local cFlyConnection

local keyToControl = {
	[Enum.KeyCode.W] = "F",
	[Enum.KeyCode.S] = "B",
	[Enum.KeyCode.A] = "L",
	[Enum.KeyCode.D] = "R",
	[Enum.KeyCode.Q] = "E",
	[Enum.KeyCode.E] = "Q",
}

local function getRoot(character)
	return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end

local FlyLib = {
	flying = false,
	method = "velocity",
	keyBinds = "default",
	flySpeed = 50,
	vehicleFlySpeed = 1,
	cFlySpeed = 50,
	character = nil,
}

local function detachInputs()
	if inputBeganConn then
		inputBeganConn:Disconnect()
		inputBeganConn = nil
	end
	if inputEndedConn then
		inputEndedConn:Disconnect()
		inputEndedConn = nil
	end
end

local function connectInputs()
	detachInputs()

	inputBeganConn = Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

		local k = keyToControl[input.KeyCode]
		if not k then return end

		if not FlyLib.flying then return end

		local spd = FlyLib.method == "vehicle" and FlyLib.vehicleFlySpeed or FlyLib.flySpeed
		if k == "F" then
			control.F = spd
		elseif k == "B" then
			control.B = -spd
		elseif k == "L" then
			control.L = -spd
		elseif k == "R" then
			control.R = spd
		elseif FlyLib.keyBinds == "qe" then
			if k == "Q" then
				control.E = -spd * 2
			elseif k == "E" then
				control.Q = spd * 2
			end
		end
		local cam = workspace.CurrentCamera
		if cam then
			cam.CameraType = Enum.CameraType.Track
		end
	end)

	inputEndedConn = Services.UserInputService.InputEnded:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

		local k = keyToControl[input.KeyCode]
		if k then
			if k == "F" then control.F = 0
			elseif k == "B" then control.B = 0
			elseif k == "L" then control.L = 0
			elseif k == "R" then control.R = 0
			elseif k == "E" then control.Q = 0
			elseif k == "Q" then control.E = 0
			end
		end
	end)
end

local function startRegular()
	local character = FlyLib.character
	if not character then return end
	local root = getRoot(character)
	if not root then return end

	FlyLib.flying = true

	local bg = Instance.new("BodyGyro")
	bg.P = 9e4
	bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.CFrame = root.CFrame
	bg.Parent = root
	bodyGyro = bg

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, 0, 0)
	bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bv.Parent = root
	bodyVelocity = bv

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and FlyLib.method ~= "vehicle" then
		humanoid.PlatformStand = true
	end

	connectInputs()

	task.spawn(function()
		while FlyLib.flying and bodyGyro and bodyGyro.Parent do
			task.wait()

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and FlyLib.method ~= "vehicle" then
				humanoid.PlatformStand = true
			end

			if control.L + control.R ~= 0 or control.F + control.B ~= 0 or control.Q + control.E ~= 0 then
				speed = 50
				lastControl.F = control.F
				lastControl.B = control.B
				lastControl.L = control.L
				lastControl.R = control.R
				lastControl.Q = control.Q
				lastControl.E = control.E
			elseif speed ~= 0 then
				speed = 0
			end

			local cam = workspace.CurrentCamera
			if cam and bodyVelocity then
				if (control.L + control.R) ~= 0 or (control.F + control.B) ~= 0 or (control.Q + control.E) ~= 0 then
					bodyVelocity.Velocity = (
						(cam.CFrame.LookVector * (control.F + control.B)) +
						((cam.CFrame * CFrame.new(control.L + control.R, (control.F + control.B + control.Q + control.E) * 0.2, 0).p) - cam.CFrame.p)
					) * speed
				elseif speed ~= 0 then
					bodyVelocity.Velocity = (
						(cam.CFrame.LookVector * (lastControl.F + lastControl.B)) +
						((cam.CFrame * CFrame.new(lastControl.L + lastControl.R, (lastControl.F + lastControl.B + control.Q + control.E) * 0.2, 0).p) - cam.CFrame.p)
					) * speed
				else
					bodyVelocity.Velocity = Vector3.new(0, 0, 0)
				end
				if bodyGyro then
					bodyGyro.CFrame = cam.CFrame
				end
			end
		end

		control = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		lastControl = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		speed = 0

		if bodyGyro then
			bodyGyro:Destroy()
			bodyGyro = nil
		end
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end

		detachInputs()
	end)
end

local function startCFrame()
	local character = FlyLib.character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	local head = character:FindFirstChild("Head")
	if not head then return end

	FlyLib.flying = true
	humanoid.PlatformStand = true
	head.Anchored = true

	if cFlyConnection then
		cFlyConnection:Disconnect()
	end

	cFlyConnection = Services.RunService.Heartbeat:Connect(function(deltaTime)
		if not FlyLib.flying then return end
		local moveDirection = humanoid.MoveDirection * (FlyLib.cFlySpeed * deltaTime)
		local headCFrame = head.CFrame
		local camera = workspace.CurrentCamera
		if not camera then return end
		local cameraCFrame = camera.CFrame
		local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
		cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
		local cameraPosition = cameraCFrame.Position
		local headPosition = headCFrame.Position

		local objectSpaceVelocity = CFrame.new(
			cameraPosition,
			Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)
		):VectorToObjectSpace(moveDirection)
		head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
	end)
end

local function stopCFrame()
	if cFlyConnection then
		cFlyConnection:Disconnect()
		cFlyConnection = nil
	end
	local character = FlyLib.character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end
		local head = character:FindFirstChild("Head")
		if head then
			head.Anchored = false
		end
	end
end

local function startByMethod()
	if FlyLib.method == "cframe" then
		startCFrame()
	else
		startRegular()
	end
end

local function stopAll()
	FlyLib.flying = false
	detachInputs()
	if cFlyConnection then
		stopCFrame()
	end

	local cam = workspace.CurrentCamera
	if cam then
		cam.CameraType = Enum.CameraType.Custom
	end
end

function FlyLib:fly()
	if not self.character then return end

	if self.flying then
		self:flyMethod(self.method)
	else
		startByMethod()
	end
end

function FlyLib:flyMethod(method)
	self.method = method
	stopAll()
	task.wait()
	startByMethod()
end

function FlyLib:flyStop()
	stopAll()
end

function FlyLib:flyToggle()
	if self.flying then
		stopAll()
	else
		startByMethod()
	end
end

function FlyLib:setSpeed(speed)
	if self.method == "cframe" then
		self.cFlySpeed = speed
	elseif self.method == "vehicle" then
		self.vehicleFlySpeed = speed
	else
		self.flySpeed = speed
	end
end

return FlyLib
