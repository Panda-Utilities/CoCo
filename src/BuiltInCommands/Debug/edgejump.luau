local Services = require("../../Shared/Services")
local RunService = Services.RunService
local Workspace = Services.Workspace

local edgeJumpConn = nil

return {
	Name = "edgejump",
	Aliases = { "ejump" },
	InverseAliases = { "unedgejump", "noejump" },
	Description = "Toggle auto-jump at edges (jumps when about to walk off).",
	Group = "DefaultDebug",
	Args = {},

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not edgeJumpConn then return "Edge jump already disabled." end
			edgeJumpConn:Disconnect()
			edgeJumpConn = nil
			return "Edge jump disabled."
		end

		if edgeJumpConn then
			edgeJumpConn:Disconnect()
			edgeJumpConn = nil
			return "Edge jump disabled."
		end

		edgeJumpConn = RunService.RenderStepped:Connect(function()
			local character = context.Executor.Character
			if not character then return end
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			if not humanoid then return end
			local root = humanoid.RootPart
			if not root then return end

			if humanoid.MoveDirection.Magnitude == 0 then return end

			local origin = root.Position - Vector3.new(0, 2, 0)
			local direction = root.CFrame.LookVector * 4
			local ray = Workspace:Raycast(origin, direction)

			if not ray then
				humanoid.Jump = true
			end
		end)

		return "Edge jump enabled."
	end,
}
