--!strict
local Services = require("../../Shared/Services")
local Players = Services.Players
local RunService = Services.RunService

local fpsGui = nil
local fpsLabel = nil
local fpsConn = nil
local frameTimes = {}

return {
	Name = "fps";
	Aliases = {"fpscounter"};
	InverseAliases = {"unfps"};
	Description = "Toggle FPS counter overlay.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not fpsGui then return "FPS counter already disabled." end
			if fpsConn then fpsConn:Disconnect(); fpsConn = nil end
			fpsGui:Destroy()
			fpsGui = nil
			fpsLabel = nil
			return "FPS counter disabled."
		end

		if fpsGui then
			if fpsConn then fpsConn:Disconnect(); fpsConn = nil end
			fpsGui:Destroy()
			fpsGui = nil
			fpsLabel = nil
			return "FPS counter disabled."
		end

		fpsGui = Instance.new("ScreenGui")
		fpsGui.Name = "CoCoFPS"
		fpsGui.ResetOnSpawn = false
		fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		fpsLabel = Instance.new("TextLabel")
		fpsLabel.Size = UDim2.new(0, 100, 0, 30)
		fpsLabel.Position = UDim2.new(1, -110, 0, 5)
		fpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
		fpsLabel.BackgroundTransparency = 0.5
		fpsLabel.TextColor3 = Color3.new(0, 1, 0)
		fpsLabel.TextScaled = true
		fpsLabel.Font = Enum.Font.Code
		fpsLabel.Text = "FPS: --"
		fpsLabel.Parent = fpsGui

		fpsGui.Parent = pcall(gethui) and gethui() or Players.LocalPlayer:WaitForChild("PlayerGui")

		local lastTime = tick()
		fpsConn = RunService.RenderStepped:Connect(function()
			local now = tick()
			local dt = now - lastTime
			lastTime = now

			table.insert(frameTimes, dt)
			if #frameTimes > 30 then table.remove(frameTimes, 1) end

			local sum = 0
			for _, t in ipairs(frameTimes) do sum = sum + t end
			local avg = sum / #frameTimes
			local fps = avg > 0 and math.floor(1 / avg) or 0
			fpsLabel.Text = ("FPS: %d"):format(fps)
		end)

		return "FPS counter enabled."
	end;
}
