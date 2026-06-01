--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService
local Workspace = Services.Workspace

local floatEnabled = false
local floatPart = nil
local floatConn = nil

local function destroyFloat()
	floatEnabled = false
	if floatConn then
		floatConn:Disconnect()
		floatConn = nil
	end
	if floatPart then
		floatPart:Destroy()
		floatPart = nil
	end
end

return {
	Name = "float",
	Aliases = { "platform" },
	InverseAliases = { "unfloat", "nofloat" },
	Description = "Toggle floating on a platform beneath you.",
	Group = "DefaultDebug",
	Args = {},

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not floatEnabled then return "Float already disabled." end
			destroyFloat()
			return "Float disabled."
		end

		if floatEnabled then
			destroyFloat()
			return "Float disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		floatPart = Instance.new("Part")
		floatPart.Name = "FloatPlatform"
		floatPart.Size = Vector3.new(4, 0.5, 4)
		floatPart.Transparency = 0.5
		floatPart.CanCollide = true
		floatPart.Material = Enum.Material.Neon
		floatPart.Color = Color3.fromRGB(100, 200, 255)
		floatPart.Anchored = true
		floatPart.Parent = Workspace

		floatEnabled = true

		floatConn = RunService.RenderStepped:Connect(function()
			if not floatEnabled then return end
			local char = context.Executor.Character
			if not char then return end
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if not humanoid then return end
			local root = humanoid.RootPart
			if not root then return end

			local pos = root.Position
			floatPart.CFrame = CFrame.new(pos.X, pos.Y - 3, pos.Z)
		end)

		return "Float enabled."
	end,
}
