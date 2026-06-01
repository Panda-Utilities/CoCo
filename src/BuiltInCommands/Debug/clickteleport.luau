--!strict
local UserInputService = game:GetService("UserInputService")

local clickTpEnabled = false
local clickTpConn = nil

return {
	Name = "clickteleport",
	Aliases = { "ctp" },
	InverseAliases = { "unclickteleport", "noctp" },
	Description = "Toggle click-teleport (click anywhere to teleport there).",
	Group = "DefaultDebug",
	Args = {},

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not clickTpEnabled then return "Click-TP already disabled." end
			clickTpEnabled = false
			if clickTpConn then
				clickTpConn:Disconnect()
				clickTpConn = nil
			end
			return "Click-TP disabled."
		end

		if clickTpEnabled then
			clickTpEnabled = false
			if clickTpConn then
				clickTpConn:Disconnect()
				clickTpConn = nil
			end
			return "Click-TP disabled."
		end

		local mouse = context.Executor:GetMouse()

		clickTpConn = UserInputService.InputBegan:Connect(function(input, gpo)
			if gpo then return end
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

			local character = context.Executor.Character
			if not character then return end

			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			local root = humanoid and humanoid.RootPart
			if root then
				root.CFrame = CFrame.new(mouse.Hit.p)
			end
		end)

		clickTpEnabled = true
		return "Click-TP enabled."
	end,
}
