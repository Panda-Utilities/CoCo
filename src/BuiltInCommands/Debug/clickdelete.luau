local Services = require("../../Shared/Services")
local UserInputService = Services.UserInputService
local RunService = Services.RunService

local clickDeleteActive = false
local clickDeleteConn = nil

return {
	Name = "clickdelete";
	Aliases = {};
	Description = "Toggle click-delete mode. Hold LeftAlt and click to delete parts.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		if clickDeleteActive then
			if clickDeleteConn then
				clickDeleteConn:Disconnect()
				clickDeleteConn = nil
			end
			clickDeleteActive = false
			return "Click-delete disabled."
		end

		clickDeleteActive = true

		clickDeleteConn = UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
			if not UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then return end

			local mouse = game:GetService("Players").LocalPlayer:GetMouse()
			local target = mouse.Target
			if target then
				local part = target:IsA("BasePart") and target or target.Parent
				if part then
					part:Destroy()
				end
			end
		end)

		return "Click-delete enabled (hold LeftAlt + click)."
	end;
}
