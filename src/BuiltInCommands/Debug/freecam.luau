local Services = require("../../Shared/Services")
local UserInputService = Services.UserInputService
local RunService = Services.RunService
local ContextActionService = game:GetService("ContextActionService")

local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value

local Spring = {}
Spring.__index = Spring

function Spring.new(freq, pos)
	local self = setmetatable({}, Spring)
	self.f = freq
	self.p = pos
	self.v = pos * 0
	return self
end

function Spring:Update(dt, goal)
	local f = self.f * 2 * math.pi
	local p0 = self.p
	local v0 = self.v
	local offset = goal - p0
	local decay = math.exp(-f * dt)
	local p1 = goal + (v0 * dt - offset * (f * dt + 1)) * decay
	local v1 = (f * dt * (offset * f - v0) + v0) * decay
	self.p = p1
	self.v = v1
	return p1
end

function Spring:Reset(pos)
	self.p = pos
	self.v = pos * 0
end

local freecam = {
	running = false,
	camera = workspace.CurrentCamera,
	cameraPos = Vector3.new(),
	cameraRot = Vector2.new(),
	cameraFov = 70,
	navSpeed = 1,
	keyboard = { W = 0, A = 0, S = 0, D = 0, E = 0, Q = 0, Up = 0, Down = 0 },
	mouseDelta = Vector2.new(),
	velSpring = Spring.new(5, Vector3.new()),
	panSpring = Spring.new(5, Vector2.new()),
	playerState = {
		cameraType = nil,
		cameraCFrame = nil,
		cameraFocus = nil,
		cameraFieldOfView = nil,
		mouseBehavior = nil,
		mouseIconEnabled = nil,
	},
}

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	local newCamera = workspace.CurrentCamera
	if newCamera then
		freecam.camera = newCamera
	end
end)

local function getFocusDistance(cameraFrame)
	local camera = freecam.camera
	local znear = 0.1
	local viewport = camera.ViewportSize
	local fov = freecam.cameraFov
	local projy = 2 * math.tan(math.rad(fov) / 2)
	local projx = viewport.x / viewport.y * projy
	local fx = cameraFrame.RightVector
	local fy = cameraFrame.UpVector
	local fz = cameraFrame.LookVector

	local minVect = Vector3.new()
	local minDist = 512

	for x = 0, 1, 0.5 do
		for y = 0, 1, 0.5 do
			local cx = (x - 0.5) * projx
			local cy = (y - 0.5) * projy
			local offset = fx * cx - fy * cy + fz
			local origin = cameraFrame.p + offset * znear
			local _, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit * minDist))
			local dist = (hit - origin).Magnitude
			if minDist > dist then
				minDist = dist
				minVect = offset.unit
			end
		end
	end

	return fz:Dot(minVect) * minDist
end

local function stepFreecam(dt)
	local fc = freecam

	fc.navSpeed = math.clamp(fc.navSpeed + dt * (fc.keyboard.Up - fc.keyboard.Down) * 0.75, 0.01, 4)

	local kKeyboard = Vector3.new(
		fc.keyboard.D - fc.keyboard.A,
		fc.keyboard.E - fc.keyboard.Q,
		fc.keyboard.S - fc.keyboard.W
	) * Vector3.new(1, 1, 1)

	local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
	local vel = fc.velSpring:Update(dt, kKeyboard * (fc.navSpeed * (shift and 0.25 or 1)))

	local kMouse = fc.mouseDelta * Vector2.new(1, 1) * (math.pi / 64)
	fc.mouseDelta = Vector2.new()
	local pan = fc.panSpring:Update(dt, kMouse)

	local zoomFactor = math.sqrt(math.tan(math.rad(35)) / math.tan(math.rad(fc.cameraFov / 2)))
	fc.cameraRot = fc.cameraRot + pan * Vector2.new(0.75, 1) * 8 * (dt / zoomFactor)
	fc.cameraRot = Vector2.new(math.clamp(fc.cameraRot.x, -math.rad(90), math.rad(90)), fc.cameraRot.y % (2 * math.pi))

	local cameraCFrame = CFrame.new(fc.cameraPos) * CFrame.fromOrientation(fc.cameraRot.x, fc.cameraRot.y, 0) * CFrame.new(vel * Vector3.new(1, 1, 1) * 64 * dt)
	fc.cameraPos = cameraCFrame.p

	local camera = fc.camera
	camera.CFrame = cameraCFrame
	camera.Focus = cameraCFrame * CFrame.new(0, 0, -getFocusDistance(cameraCFrame))
	camera.FieldOfView = fc.cameraFov
end

local function disableFreecam()
	local fc = freecam
	ContextActionService:UnbindAction("FreecamKeyboard")
	ContextActionService:UnbindAction("FreecamMousePan")
	RunService:UnbindFromRenderStep("Freecam")

	fc.navSpeed = 1
	for k in fc.keyboard do fc.keyboard[k] = 0 end
	fc.mouseDelta = Vector2.new()

	local ps = fc.playerState
	local camera = fc.camera
	camera.FieldOfView = 70
	camera.CameraType = ps.cameraType
	camera.CFrame = ps.cameraCFrame
	camera.Focus = ps.cameraFocus
	UserInputService.MouseIconEnabled = ps.mouseIconEnabled
	UserInputService.MouseBehavior = ps.mouseBehavior

	fc.running = false
end

return {
	Name = "freecam";
	Aliases = {"fc"};
	InverseAliases = {"unfreecam", "nofreecam"};
	Description = "Toggle freecam (WASD/QE move, Up/Down speed, Shift slow, mouse look).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local fc = freecam

		if context:isInvertedCall() then
			if not fc.running then return "Freecam already disabled." end
			disableFreecam()
			return "Freecam disabled."
		end

		if fc.running then
			disableFreecam()
			return "Freecam disabled."
		end

		local camera = fc.camera
		local ps = fc.playerState
		ps.cameraFieldOfView = camera.FieldOfView
		ps.cameraType = camera.CameraType
		ps.cameraCFrame = camera.CFrame
		ps.cameraFocus = camera.Focus
		ps.mouseIconEnabled = UserInputService.MouseIconEnabled
		ps.mouseBehavior = UserInputService.MouseBehavior

		local cameraCFrame = camera.CFrame
		fc.cameraRot = Vector2.new()
		fc.cameraPos = cameraCFrame.p
		fc.cameraFov = ps.cameraFieldOfView
		fc.navSpeed = 1
		for k in fc.keyboard do fc.keyboard[k] = 0 end
		fc.mouseDelta = Vector2.new()
		fc.velSpring:Reset(Vector3.new())
		fc.panSpring:Reset(Vector2.new())

		camera.FieldOfView = 70
		camera.CameraType = Enum.CameraType.Custom
		UserInputService.MouseIconEnabled = true
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default

		ContextActionService:BindActionAtPriority("FreecamKeyboard", function(action, state, input)
			fc.keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
			return Enum.ContextActionResult.Sink
		end, false, INPUT_PRIORITY,
			Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
			Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down
		)

		ContextActionService:BindActionAtPriority("FreecamMousePan", function(action, state, input)
			local delta = input.Delta
			fc.mouseDelta = Vector2.new(-delta.Y, -delta.X)
			return Enum.ContextActionResult.Sink
		end, false, INPUT_PRIORITY, Enum.UserInputType.MouseMovement)

		RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, stepFreecam)

		fc.running = true
		return "Freecam enabled."
	end;
}
